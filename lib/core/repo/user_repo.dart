import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:perfection_task/core/repo/base_repository.dart';
import 'package:perfection_task/features/user_list/data/user_model.dart';
import '../../../core/networking/network_constants.dart';
import '../../../core/networking/server_failure.dart';


class UsersRepository extends BaseRepository {
  Future<Either<Failure, List<UserModel>>> getUsers(int page) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();
        final response = await d.get(NetworkConstants.baseUrl, queryParameters: {'page': page});

        if (response.statusCode == 200) {
          final data = response.data['data'];
          final List<UserModel> users =
              (data as List).map((user) => UserModel.fromJson(user)).toList();
          return Right(users);
        } else {
          //failure -- return business error

          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          debugPrint(
              error.response?.data['message'] ?? ResponseMessage.unauthorized);
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
  Future<Either<Failure, List<UserModel>>> getUsersById(int userId) async {
    if (await networkInfo.isConnected) {
      //its connected to internet , its safe to call API
      try {
        var d = await dio.getDio();
        final response = await d.get("${NetworkConstants.baseUrl}/$userId",);

        if (response.statusCode == 200) {
          final data = response.data['data'];
          final List<UserModel> users =
              (data as List).map((user) => UserModel.fromJson(user)).toList();
          return Right(users);
        } else {
          //failure -- return business error

          return Left(
              Failure(ApiInternalStatus.failure, ResponseMessage.unKnown));
        }
      } on DioException catch (error) {
        if (error.response?.statusCode == 406) {
          debugPrint(
              error.response?.data['message'] ?? ResponseMessage.unauthorized);
          return Left(Failure(
              error.response?.statusCode ?? ApiInternalStatus.failure,
              error.response?.data['message']));
        } else {
          return Left(ErrorHandler.handle(error).failure);
        }
      }
    } else {
      //return internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
