import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:perfection_task/core/networking/dio_factory.dart';
import 'package:perfection_task/core/networking/network_info.dart';
import 'package:perfection_task/core/repo/user_repo.dart';
import 'package:perfection_task/features/user_list/domain/use_cases/get_users_use_case.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register Dio
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerLazySingleton<DioFactory>(() => DioFactory());



getIt.registerLazySingleton<InternetConnectionChecker>(() => InternetConnectionChecker());

getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt<InternetConnectionChecker>()));

  // Registering UserRepository and GetUsersUseCase
  getIt.registerLazySingleton<UsersRepository>(() => UsersRepository());
  getIt.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(getIt<UsersRepository>()));
}
