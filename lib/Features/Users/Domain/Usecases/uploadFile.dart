import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Domain/Repositories/usersRepository.dart';
import 'package:neopolis/Core/Utils/parameters.dart';

class UploadFileSubUsers implements Usescases<Profile, AddEditUploadFileUsersParams> {
  final UsersRepository usersRepository;

  UploadFileSubUsers(this.usersRepository);

  @override
  Future<Either<Failure, Profile>> call(AddEditUploadFileUsersParams addEditUploadFileUsersParams) async {
    return await usersRepository.uploadFile(addEditUploadFileUsersParams);
  }
}
