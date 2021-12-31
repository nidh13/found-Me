import 'dart:async';
import 'dart:convert';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Help/Data/Datasource/helpRemoteDatasource.dart';

class helpRemoteDataSourceImpl implements HelpRemoteDataSource {
  final http.Client client;

  helpRemoteDataSourceImpl({@required this.client});





}
