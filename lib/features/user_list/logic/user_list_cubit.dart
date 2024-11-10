import 'package:bloc/bloc.dart';
import 'package:perfection_task/core/networking/api_service.dart';
import 'package:perfection_task/features/user_list/data/user_model.dart';
import 'package:perfection_task/features/user_list/logic/user_list_states.dart';


class UserListCubit extends Cubit<UserState> {
  final ApiService _apiService;

  UserListCubit(this._apiService) : super(UserInitial());

  Future<void> fetchUsers() async {
    emit(UserLoading());
    try {
      final usersPage1 = await _apiService.fetchUsers(1);
      final usersPage2 = await _apiService.fetchUsers(2);
      final users = (usersPage1 + usersPage2).map((json) => User.fromJson(json)).toList();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError('Failed to load users'));
    }
  }
}
