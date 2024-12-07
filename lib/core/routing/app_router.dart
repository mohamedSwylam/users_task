import 'package:flutter/material.dart';
import 'package:perfection_task/core/routing/routes.dart';
import 'package:perfection_task/features/user_list/presentation/ui/user_list_screen.dart';

class AppRouter {

  Route? generateRoute(RouteSettings sittings) {
      //  final arguments = sittings.arguments;

    switch (sittings.name) {
      case Routes.userListPage:
        return MaterialPageRoute(
          builder: (_) => const UsersPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route definedfor ${sittings.name}'),
            ),
          ),
        );
    }
  }
}
