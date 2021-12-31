import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Network/networkInfo.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Data/Datasource/usersRemoteDatasource.dart';
import 'package:neopolis/Features/Users/Domain/Repositories/usersRepository.dart';
import 'package:neopolis/Features/Users/Domain/Usecases/DeleteSubUser.dart';

class UsersRepositoryImpl implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  UsersRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Profile>> editProfileSUbUser(
      AddEditUsersParams addEditUsersParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.editProfileSubUser(addEditUsersParams);
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
  Future<Either<Failure, Profile>> deleteProfileSubUser(
      AddEditUsersParams addEditUsersParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response =
          await remoteDataSource.deleteProfileSubUser(addEditUsersParams);
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
  Future<Either<Failure, Profile>> uploadFile(
      AddEditUploadFileUsersParams addEditUploadFileUsersParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response =
          await remoteDataSource.uploadFile(addEditUploadFileUsersParams);
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
