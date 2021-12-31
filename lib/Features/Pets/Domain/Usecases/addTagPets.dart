import 'package:dartz/dartz.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Usecases/usecases.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Pets/Domain/Repositories/petsRepository.dart';

class AddPetTags implements Usescases<Profile, AddEditUploadFilePetsParams> {
  final PetsRepository usersRepository;

  AddPetTags(this.usersRepository);

  @override
  Future<Either<Failure, Profile>> call(
      AddEditUploadFilePetsParams addPetsUsesrParams) async {
    return await usersRepository.addTagPets(addPetsUsesrParams);
  }
}
