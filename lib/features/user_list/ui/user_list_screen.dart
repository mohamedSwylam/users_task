import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfection_task/core/helper/exetention.dart';
import 'package:perfection_task/core/routing/routes.dart';
import 'package:perfection_task/core/theming/style.dart';
import 'package:perfection_task/features/user_list/logic/user_list_cubit.dart';
import 'package:perfection_task/features/user_list/logic/user_list_states.dart';


class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User List',style:TextStyles.font13DarkBlueRegular),leading: const Icon(Icons.menu),),
      body:BlocBuilder<UserListCubit, UserState>(
  builder: (context, state) {
    if (state is UserLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is UserLoaded) {
      return ListView.builder(
        itemCount: state.users.length,
        itemBuilder: (context, index) {
          final user = state.users[index];
          return ListTile(
            title: Text('${user.firstName} ${user.lastName}',style: TextStyles.font11BlackMedium,),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.avatar),
            ),
            onTap: () {
          context.pushNamed(Routes.userDetailsPage,arguments: user.id);
            },
          );
        },
      );
    } else if (state is UserError) {
      return Center(child: Text(state.message));
    }
    return const Center(child: Text('Press button to fetch users'));
  },
)
    );
  }
}
