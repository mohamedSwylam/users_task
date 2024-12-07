import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfection_task/core/di/dependcy_injection.dart';
import 'package:perfection_task/core/repo/user_repo.dart';
import 'package:perfection_task/core/routing/app_router.dart';
import 'package:perfection_task/features/user_list/domain/use_cases/get_users_use_case.dart';
import 'package:perfection_task/user_app.dart';

void main() {
  setupLocator();
  Get.put(UsersRepository()); // Register UsersRepository
  Get.put(GetUsersUseCase(Get.find())); // Register GetUsersUseCase
  runApp( UserApp(appRouter: AppRouter(),));
}

