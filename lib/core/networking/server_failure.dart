import 'package:dio/dio.dart';

class Failure {
  int code;
  String message;

  Failure(this.code, this.message);
}

class ErrorModel {
  bool? success;
  String? message;

  ErrorModel({this.success, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

abstract class Failuree {
  final String errorMessage;
  Failuree({required this.errorMessage});
}

class ServerFailure extends Failuree {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: 'Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'Bad certificate error!');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response?.statusCode ?? 0,
            dioException.response?.data);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request error canceled');
      case DioExceptionType.connectionError:
        if (dioException.message?.contains('SocketException') == true) {
          return ServerFailure(errorMessage: 'No Internet Connection');
        }
        return ServerFailure(errorMessage: 'Connection error with ApiServer');
      case DioExceptionType.unknown:
        return ServerFailure(errorMessage: 'Unexpected error with ApiServer');
      default:
        return ServerFailure(errorMessage: 'Oops, there was an error!');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (response == null || response['error'] == null) {
      return ServerFailure(errorMessage: 'Unknown error');
    }
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
          errorMessage: response['error']['message'] ?? 'Unknown error');
    } else if (statusCode == 404) {
      return ServerFailure(
          errorMessage: 'Your request not found! Please try later.');
    } else if (statusCode == 500) {
      return ServerFailure(
          errorMessage: 'Internal Server error! Please try later.');
    } else {
      return ServerFailure(
          errorMessage: 'Oops, there was an error. Please try later!');
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unKnown.getFailure(message: error.toString());
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeout.getFailure();
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null) {
        final resp = ErrorModel.fromJson(error.response!.data);
        return DataSource.badResponse.getFailure(message: resp.message);
      }
      return DataSource.badResponse.getFailure();
    default:
      return DataSource.unKnown.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badResponse,
  forbidden,
  unauthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unKnown
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badResponse = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int internalServerError = 500;
  static const int notFound = 404;
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeOut = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int unKnown = -7;
}

class ResponseMessage {
  static const String success = 'Success';
  static const String noContent = 'Success';
  static const String badResponse = 'Failure: API rejected request';
  static const String unauthorized = 'Failure: User is not authorized';
  static const String forbidden = 'Failure: API rejected request';
  static const String internalServerError = 'Failure: Crash in server side';
  static const String notFound = 'Failure: Page not found';
  static const String connectTimeOut = 'Connection timeout';
  static const String cancel = 'Request canceled';
  static const String receiveTimeOut = 'Receive timeout';
  static const String sendTimeOut = 'Send timeout';
  static const String cacheError = 'Cache error';
  static const String noInternetConnection = 'فشل الاتصال بالانترنت';
  static const String unKnown = 'الخطأ غير معروف';
}

extension DataSourceExtension on DataSource {
  Failure getFailure({String? message}) {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badResponse:
        return Failure(
            ResponseCode.badResponse, message ?? ResponseMessage.badResponse);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorized:
        return Failure(ResponseCode.unauthorized, ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMessage.connectTimeOut);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeOut, ResponseMessage.receiveTimeOut);
      case DataSource.sendTimeOut:
        return Failure(ResponseCode.sendTimeOut, ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);
      case DataSource.unKnown:
        return Failure(ResponseCode.unKnown, ResponseMessage.unKnown);
    }
  }
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}
