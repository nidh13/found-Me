import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Network/networkInfo.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Data/Datasource/userRemoteDatasource.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Signin/Domain/Repositories/userRepository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  UserRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Profile>> login(LoginParams loginParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.login(loginParams);
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
  Future<Either<Failure, Profile>> loginGoogle(String test) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.loginGoogle(test);
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
  Future<Either<Failure, Profile>> loginFacebook(String test) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.loginFacebook(test);
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
  Future<Either<Failure, String>> register(
      RegisterParams registerParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.register(registerParams);
      if (response is String) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.forgotPassword(email);
      if (response is String) {
        return Right(response);
      } else {
        return Left(response);
      }
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }
}
