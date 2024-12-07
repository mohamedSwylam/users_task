import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:perfection_task/core/theming/style.dart';
import 'package:perfection_task/features/user_details/ui/user_details_screen.dart';
import 'package:perfection_task/features/user_list/domain/use_cases/get_users_use_case.dart';
import 'package:perfection_task/features/user_list/presentation/controller/users_controller.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(GetUsersUseCase(Get.find()));
    final controller = Get.put(UsersController(Get.find()));

    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) => controller.searchQuery(query),
              decoration: InputDecoration(
                hintText: "Search Users...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage.value}'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchUsers(isRefresh: true); // Pull to refresh
          },
          child: ListView.builder(
            controller: controller.scrollController, // Add the scroll controller for pagination
            itemCount: controller.users.length + 1, // Add 1 for loading indicator
            itemBuilder: (context, index) {
              if (index == controller.users.length) {
                if (controller.isLoadingMore.value) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return Container();
              }

              final user = controller.users[index];
              return GestureDetector(
                onTap: () => Get.to(
                  () => UserDetailsScreen(user: user),
                  transition: Transition.fadeIn, // Add smooth transition
                  duration: const Duration(milliseconds: 300),
                ),
                child: ListTile(
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style: TextStyles.font15DarkBlueMedium,
                  ),
                  subtitle: Text(
                    user.email,
                    style: TextStyles.font14GrayMedium,
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
