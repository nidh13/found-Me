import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Network/networkInfo.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Reminders/Data/Datasource/reminderRemoteDatasource.dart';
import 'package:neopolis/Features/Reminders/Domain/Repositories/reminderRepository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  ReminderRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Profile>> reminderList(
      DeteleReminderParams deteleReminderParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.reminderList(deteleReminderParams);
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
