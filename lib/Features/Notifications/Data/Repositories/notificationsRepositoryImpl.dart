 import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:neopolis/Core/Error/failure.dart';
import 'package:neopolis/Core/Network/networkInfo.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Notifications/Data/Datasource/notificationsRemoteDatasource.dart';
import 'package:neopolis/Features/Notifications/Domain/Repositories/notificationsRepository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  var response;

  NotificationsRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });


  @override
  Future<Either<Failure, Profile>> editNotifications(EditNotificationsParams editNotifcationsParams) async {
    try {
      if (await networkInfo.isConnected == false) {
        throw ServerExeption();
      }
      response = await remoteDataSource.editnotifications(editNotifcationsParams);
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
 