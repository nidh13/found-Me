import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Network/networkInfo.dart';
import 'package:neopolis/Features/Profile/Data/Datasource/profileRemoteDatasource.dart';
import 'package:neopolis/Features/Profile/Domain/Repositories/profileRepository.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  ProfileRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Profile>> editProfile(Profile profile) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.editProfile(profile);
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
  Future<Either<Failure, Profile>> uploadFile(Profile profile) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.uploadFile(profile);
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
