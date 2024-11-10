import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfection_task/core/helper/spacing.dart';
import 'package:perfection_task/core/theming/style.dart';
import 'package:perfection_task/features/user_details/logic/user_details_cubit.dart';
import 'package:perfection_task/features/user_details/logic/user_details_states.dart';

class UserDetailsPage extends StatelessWidget {
  final int userId;

  const UserDetailsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
          builder: (context, state) {
            if (state is UserDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserDetailsLoaded) {
              final user = state.user;
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                          'User Details',
                          style:  TextStyles.font13DarkBlueRegular,
                        ),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50.w,
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                        verticalSpace(16),
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: TextStyles.font32BlueBold,
                        ),
                        verticalSpace(8),
                        Text(
                          user.email,
                          style: TextStyles.font15DarkBlueMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is UserDetailsError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No user selected'));
          },
        );
  }
}