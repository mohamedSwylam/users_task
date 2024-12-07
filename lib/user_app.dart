import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:perfection_task/core/routing/app_router.dart';
import 'package:perfection_task/core/routing/routes.dart';
import 'package:perfection_task/core/theming/colors.dart';


class UserApp extends StatelessWidget {
  final AppRouter appRouter;
  const UserApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        title: "UserApp",
        theme: ThemeData(
          primaryColor: ColorsManger.mainBlue,
          scaffoldBackgroundColor: Colors.white
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: Routes.userListPage,
        home: const Scaffold(
        body: Center(),
        ),
      ),
    );
  }
}