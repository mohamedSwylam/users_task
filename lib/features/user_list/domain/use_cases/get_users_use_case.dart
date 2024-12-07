import 'package:perfection_task/core/networking/server_failure.dart';
import 'package:perfection_task/core/repo/user_repo.dart';
import 'package:either_dart/either.dart';
import 'package:perfection_task/features/user_list/data/user_model.dart';

class GetUsersUseCase {
  final UsersRepository repository;

  GetUsersUseCase(this.repository);

  Future<Either<Failure, List<UserModel>>> execute(int page) {
    return repository.getUsers(page);
  }
    Future<Either<Failure, List<UserModel>>> executeDetails(int id) {
    return repository.getUsersById(id);
  }
}
