import 'package:flutter/material.dart';
import 'package:perfection_task/core/di/dependcy_injection.dart';
import 'package:perfection_task/core/routing/app_router.dart';
import 'package:perfection_task/user_app.dart';

void main() {
  setupLocator();
  runApp( UserApp(appRouter: AppRouter(),));
}

