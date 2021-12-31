import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Domain/Repositories/usersRepository.dart';

class DeleteProfileSubUser implements Usescases<Profile, AddEditUsersParams> {
  final UsersRepository usersRepository;

  DeleteProfileSubUser(this.usersRepository);

  @override
  Future<Either<Failure, Profile>> call(
      AddEditUsersParams addUsersUsesrParams) async {
    return await usersRepository.deleteProfileSubUser(addUsersUsesrParams);
  }
}
