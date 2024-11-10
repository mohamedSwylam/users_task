import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:perfection_task/core/networking/api_service.dart';
import 'package:perfection_task/features/user_details/logic/user_details_cubit.dart';
import 'package:perfection_task/features/user_list/logic/user_list_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register Dio
  getIt.registerSingleton<Dio>(Dio());

  // Register ApiService
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  // Register Cubits
  getIt
      .registerFactory<UserListCubit>(() => UserListCubit(getIt<ApiService>()));
  getIt.registerFactory<UserDetailsCubit>(
      () => UserDetailsCubit(getIt<ApiService>()));
}
