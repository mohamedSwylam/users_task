import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfection_task/features/user_list/data/user_model.dart';
import 'package:perfection_task/features/user_list/domain/use_cases/get_users_use_case.dart';

class UsersController extends GetxController {
  final GetUsersUseCase getUsersUseCase;

  UsersController(this.getUsersUseCase);

  final isLoadingMore = false.obs;
  final scrollController = ScrollController();
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
    scrollController.addListener(_paginate);
  }

  var users = <UserModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var currentPage = 1.obs;
  var searchQuery = ''.obs;
  // Fetch users
  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage.value = 1; // Reset page for pull-to-refresh
      users.clear();
            hasMore = true;

    }
    isLoading.value = true;
    final result = await getUsersUseCase.execute(currentPage.value);
    result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (fetchedUsers) {
        currentPage.value++;
        users.addAll(fetchedUsers);
      },
    );
    isLoading.value = false;
  }
    List<UserModel> get filteredUsers {
    if (searchQuery.isEmpty) {
      return users;
    }
    return users
        .where((user) =>
            user.firstName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            user.lastName.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }
    void _paginate() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      fetchUsers();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
