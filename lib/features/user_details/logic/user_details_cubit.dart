import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfection_task/core/networking/api_service.dart';
import 'package:perfection_task/features/user_details/logic/user_details_states.dart';
import 'package:perfection_task/features/user_list/data/user_model.dart';
class UserDetailsCubit extends Cubit<UserDetailsState> {
  final ApiService _apiService;

  UserDetailsCubit(this._apiService) : super(UserDetailsInitial());

  Future<void> fetchUserDetails(int userId) async {
    emit(UserDetailsLoading());
    try {
      final userData = await _apiService.fetchUserDetails(userId);
      final user = User.fromJson(userData);
      emit(UserDetailsLoaded(user));
    } catch (e) {
      emit(UserDetailsError('Failed to load user details'));
    }
  }
}