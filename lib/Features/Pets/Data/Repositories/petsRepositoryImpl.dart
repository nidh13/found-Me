import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Network/networkInfo.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Pets/Data/Datasource/petsRemoteDatasource.dart';
import 'package:neopolis/Features/Pets/Domain/Repositories/petsRepository.dart';

class PetsRepositoryImpl implements PetsRepository {
  final PetsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  PetsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Profile>> editProfilePets(
      AddEditUploadFilePetsParams addEditPetsParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.editProfilePets(addEditPetsParams);
      if (response is Profile) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Profile>> addTagPets(
      AddEditUploadFilePetsParams addEditPetsParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.addTagPets(addEditPetsParams);
      if (response is Profile) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }


    @override
  Future<Either<Failure, Profile>> uploadFilePets(
      AddEditUploadFilePetsParams addEditUploadFilePetsParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.uploadFilePets(addEditUploadFilePetsParams);
      if (response is Profile) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }
}
