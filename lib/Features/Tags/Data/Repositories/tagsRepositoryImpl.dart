import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Network/networkInfo.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Data/Datasource/tagsRemoteDatasource.dart';
import 'package:neopolis/Features/Tags/Domain/Repositories/tagsRepository.dart';

class TagsRepositoryImpl implements TagsRepository {
  final TagsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  TagsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Profile>> addEditObjectTag(
      AddEditTagParams addEditTagParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.addEditObjectTag(addEditTagParams);
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
  Future<Either<Failure, Profile>> filterTags(Profile profile) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.filterTags(profile);
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
  Future<Either<Failure, Profile>> verifyTag(Profile profile) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.verifyTag(profile);
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
      AddEditObjectTagParams addEditObjectTagParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.uploadFile(addEditObjectTagParams);
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
