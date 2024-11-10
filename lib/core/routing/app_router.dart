import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfection_task/core/di/dependcy_injection.dart';
import 'package:perfection_task/core/routing/routes.dart';
import 'package:perfection_task/features/user_details/logic/user_details_cubit.dart';
import 'package:perfection_task/features/user_details/ui/user_details_screen.dart';
import 'package:perfection_task/features/user_list/logic/user_list_cubit.dart';
import 'package:perfection_task/features/user_list/ui/user_list_screen.dart';

class AppRouter {

  Route? generateRoute(RouteSettings sittings) {
        final arguments = sittings.arguments;

    switch (sittings.name) {
      case Routes.userListPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>  getIt<UserListCubit>()..fetchUsers(),
            child:  const UserListPage(),
          ),
        );
        case Routes.userDetailsPage:
        return MaterialPageRoute(
          builder: (_) {
            final userId = arguments as int;
            return BlocProvider(
            create: (_) => getIt<UserDetailsCubit>()..fetchUserDetails(userId),
            child:  UserDetailsPage(userId: userId),
          );
          }
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
