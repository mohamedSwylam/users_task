import 'package:flutter/material.dart';
import 'package:perfection_task/core/helper/spacing.dart';
import 'package:perfection_task/core/theming/style.dart';
import 'package:perfection_task/features/user_list/data/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${user.firstName} ${user.lastName}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.avatar),
              ),
              verticalSpace(16),
              Text("${user.firstName} ${user.lastName}", style: TextStyles.font24BlackBold),
              Text(user.email, style: TextStyles.font24BlackBold),
            ],
          ),
        ),
      ),
    );
  }
}
