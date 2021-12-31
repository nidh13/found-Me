import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Pets/Domain/Repositories/petsRepository.dart';
import 'package:neopolis/Core/Utils/parameters.dart';

class UploadFilePets implements Usescases<Profile, AddEditUploadFilePetsParams> {
  final PetsRepository petsRepository;

  UploadFilePets(this.petsRepository);

  @override
  Future<Either<Failure, Profile>> call(AddEditUploadFilePetsParams addEditUploadFilePetsParams) async {
    return await petsRepository.uploadFilePets(addEditUploadFilePetsParams);
  }
}
