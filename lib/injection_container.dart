import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:neopolis/Features/Home/Data/Datasource/homeRemoteDatasource.dart';
import 'package:neopolis/Features/Home/Data/Repositories/homeRepositoryImpl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:neopolis/Core/Network/networkInfo.dart';
import 'package:neopolis/Features/Help/Presentation/bloc/help_bloc.dart';
import 'package:neopolis/Features/Notifications/Presentation/bloc/notifications_bloc.dart';
import 'package:neopolis/Features/Home/Data/Datasource/Implementations/homeRemoteDatasourceImpl.dart';
import 'package:neopolis/Features/Home/Domain/Repositories/homeRepository.dart';
import 'package:neopolis/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:neopolis/Features/Messages/Presentation/bloc/messages_bloc.dart';
import 'package:neopolis/Features/Profile/Data/Datasource/Implementations/profileRemoteDataSourceImpl.dart';
import 'package:neopolis/Features/Profile/Data/Datasource/profileRemoteDatasource.dart';
import 'package:neopolis/Features/Profile/Data/Repositories/profileRepositoryImpl.dart';
import 'package:neopolis/Features/Profile/Domain/Repositories/profileRepository.dart';
import 'package:neopolis/Features/Profile/Domain/Usecases/editProfile.dart';
import 'package:neopolis/Features/Home/Domain/Usecases/resetPassword.dart';
import 'package:neopolis/Features/Profile/Domain/Usecases/uploadFile.dart';
import 'package:neopolis/Features/Profile/Presentation/bloc/profile_bloc.dart';
import 'package:neopolis/Features/Reminders/Data/Datasource/Implementations/reminderRemoteDataSourceImpl.dart';
import 'package:neopolis/Features/Reminders/Data/Datasource/reminderRemoteDatasource.dart';
import 'package:neopolis/Features/Reminders/Data/Repositories/reminderRepositoryImpl.dart';
import 'package:neopolis/Features/Reminders/Domain/Repositories/reminderRepository.dart';
import 'package:neopolis/Features/Reminders/Domain/Usecases/getReminderList.dart';
import 'package:neopolis/Features/Reminders/Presentation/bloc/reminders_bloc.dart';
import 'package:neopolis/Features/Signin/Data/Datasource/Implementations/socialMediaService.dart';
import 'package:neopolis/Features/Signin/Data/Datasource/Implementations/userRemoteDatasourceImpl.dart';
import 'package:neopolis/Features/Signin/Data/Datasource/userRemoteDatasource.dart';
import 'package:neopolis/Features/Signin/Data/Repositories/userRepositoryImpl.dart';
import 'package:neopolis/Features/Signin/Domain/Repositories/userRepository.dart';
import 'package:neopolis/Features/Signin/Domain/Usecases/forgotPassword.dart';
import 'package:neopolis/Features/Signin/Domain/Usecases/login.dart';
import 'package:neopolis/Features/Signin/Domain/Usecases/loginFacebook.dart';
import 'package:neopolis/Features/Signin/Domain/Usecases/loginGoogle.dart';
import 'package:neopolis/Features/Home/Domain/Usecases/logout.dart';
import 'package:neopolis/Features/Signin/Domain/Usecases/register.dart';
import 'package:neopolis/Features/Signin/Presentation/bloc/login_bloc.dart';
import 'package:neopolis/Features/Tags/Data/Datasource/Implementations/tagsRemoteDataSourceImpl.dart';
import 'package:neopolis/Features/Tags/Data/Datasource/tagsRemoteDatasource.dart';
import 'package:neopolis/Features/Tags/Data/Repositories/tagsRepositoryImpl.dart';
import 'package:neopolis/Features/Tags/Domain/Repositories/tagsRepository.dart';
import 'package:neopolis/Features/Tags/Domain/Usecases/addEditObjectTag.dart';
import 'package:neopolis/Features/Tags/Domain/Usecases/uploadFile.dart';
import 'package:neopolis/Features/Tags/Domain/Usecases/verifyTag.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:neopolis/Features/Users/Data/Datasource/Implementations/usersRemoteDataSourceImpl.dart';
import 'package:neopolis/Features/Users/Data/Datasource/usersRemoteDatasource.dart';
import 'package:neopolis/Features/Users/Data/Repositories/usersRepositoryImpl.dart';
import 'package:neopolis/Features/Users/Domain/Repositories/usersRepository.dart';
import 'package:neopolis/Features/Users/Domain/Usecases/uploadFile.dart';
import 'package:neopolis/Features/Users/Domain/Usecases/DeleteSubUser.dart';

import 'package:neopolis/Features/Users/Domain/Usecases/editProfileSubUser.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:neopolis/Features/Pets/Data/Datasource/petsRemoteDatasource.dart';
import 'package:neopolis/Features/Pets/Data/Repositories/petsRepositoryImpl.dart';
import 'package:neopolis/Features/Pets/Domain/Usecases/uploadFilePets.dart';
import 'package:neopolis/Features/Pets/Domain/Usecases/editProfilePets.dart';
import 'package:neopolis/Features/Pets/Domain/Usecases/addTagPets.dart';

import 'package:neopolis/Features/Pets/Presentation/bloc/pets_bloc.dart';
import 'package:neopolis/Features/Pets/Domain/Repositories/petsRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neopolis/Features/Pets/Data/Datasource/Implimentations/petsRemoteDataSourceImpl.dart';
import 'package:neopolis/Features/Messages/Domain/Usecases/listMessages.dart';
import 'package:neopolis/Features/Messages/Domain/Usecases/goToSpecificMessage.dart';
import 'package:neopolis/Features/Messages/Domain/Usecases/sendMessage.dart';
import 'package:neopolis/Features/Messages/Domain/Usecases/deleteDiscussion.dart';
import 'package:neopolis/Features/Messages/Domain/Repositories/messagesRepository.dart';
import 'package:neopolis/Features/Messages/Data/Repositories/messagesRepositoryImpl.dart';
import 'package:neopolis/Features/Messages/Data/Datasource/messagesRemoteDatasource.dart';
import 'package:neopolis/Features/Messages/Data/Datasource/Implementations/messagesRemoteDatasourceImpl.dart';
import 'package:neopolis/Features/Notifications/Data/Datasource/Implimentations/notificationsRemoteDataSourceImpl.dart';
import 'package:neopolis/Features/Notifications/Data/Datasource/notificationsRemoteDatasource.dart';
import 'package:neopolis/Features/Notifications/Domain/Repositories/notificationsRepository.dart';
import 'package:neopolis/Features/Notifications/Data/Repositories/notificationsRepositoryImpl.dart';
import 'package:neopolis/Features/Notifications/Domain/Usecases/editNotifications.dart';
import 'package:neopolis/Features/Tags/Domain/Usecases/filterTag.dart';

final sl = GetIt.instance;

void init() {
  //* ---------------------------------  Feature Sign in  --------------------------

  // ? Bloc
  sl.registerFactory(() => LoginBloc(
        login: sl(),
        loginGoogle: sl(),
        loginFacebook: sl(),
        register: sl(),
        forgotPassword: sl(),
      ));

  // ? Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => LoginGoogle(sl()));
  sl.registerLazySingleton(() => LoginFacebook(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => ForgotPassword(sl()));

  // ? Repository
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

//* ---------------------------------  Feature Home  --------------------------

  // ? Bloc
  sl.registerFactory(() => HomeBloc(
        resetPassword: sl(),
        logout: sl(),
      ));

  // ? Use cases
  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  // sl.registerLazySingleton(() => Register(sl()));

  // ? Repository
  sl.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(client: sl()));

//* ---------------------------------  Feature Profile  --------------------------

  // ? Bloc
  sl.registerFactory(() => ProfileBloc(
        editProfile: sl(),
        uploadFile: sl(),
      ));

  // ? Use cases
  sl.registerLazySingleton(() => EditProfile(sl()));
  sl.registerLazySingleton(() => UploadFileProfile(sl()));

  // ? Repository
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(client: sl()));

  //* ---------------------------------  Feature Tags  --------------------------
  // ? Bloc
  sl.registerFactory(() => TagsBloc(
        addEditObjectTag: sl(),
        uploadFileObjectTag: sl(),
        /*      listingTags: sl() */
        verifyTag: sl(),
        filterTags: sl(),
      ));

  // ? Use cases
  sl.registerLazySingleton(() => AddEditObjectTag(sl()));
  sl.registerLazySingleton(() => UploadFileObjectTag(sl()));
  sl.registerLazySingleton(() => VerifyTag(sl()));
  sl.registerLazySingleton(() => FilterTags(sl()));
  // // ? Repository
  sl.registerLazySingleton<TagsRepository>(
      () => TagsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // // ? Data sources
  sl.registerLazySingleton<TagsRemoteDataSource>(
      () => TagsRemoteDataSourceImpl(client: sl()));

  //* ---------------------------------  Feature Users  --------------------------

  // ? Bloc
  sl.registerFactory(() => UsersBloc(
      editProfileSubUser: sl(), uploadFile: sl(), deleteProfileSubUser: sl()
      // loginGoogle: sl(),
      ));

  // ? Use cases

  sl.registerLazySingleton(() => EditProfileSubUser(sl()));

  sl.registerLazySingleton(() => UploadFileSubUsers(sl()));
  sl.registerLazySingleton(() => DeleteProfileSubUser(sl()));

  // sl.registerLazySingleton(() => LoginGoogle(sl()));

  // ? Repository
  sl.registerLazySingleton<UsersRepository>(
      () => UsersRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<UsersRemoteDataSource>(
      () => UsersRemoteDataSourceImpl(client: sl()));

//* ---------------------------------  Feature Help  --------------------------

  // ? Bloc
  sl.registerFactory(() => HelpBloc(
      // login: sl(),
      // loginGoogle: sl(),
      ));

  // ? Use cases
  // sl.registerLazySingleton(() => Login(sl()));
  // sl.registerLazySingleton(() => LoginGoogle(sl()));

  // ? Repository
  // sl.registerLazySingleton<UserRepository>(
  //     () => UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  // sl.registerLazySingleton<UserRemoteDataSource>(
  //     () => UserRemoteDataSourceImpl(client: sl()));

  //* ---------------------------------  Feature Notifications  --------------------------

  // ? Bloc
  sl.registerFactory(() => NotificationsBloc(editNotifications: sl()
      // login: sl(),
      // loginGoogle: sl(),
      ));

  //? Use cases
  sl.registerLazySingleton(() => EditNotifications(sl()));

  // ? Repository
  sl.registerLazySingleton<NotificationsRepository>(() =>
      NotificationsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSourceImpl(client: sl()));

//* ---------------------------------  Feature pets  --------------------------

  // ? Bloc
  sl.registerFactory(() =>
      PetsBloc(editProfilePets: sl(), uploadFilePets: sl(), addTagPets: sl()));

  // ? Use cases
  sl.registerLazySingleton(() => EditProfilePets(sl()));
  sl.registerLazySingleton(() => UploadFilePets(sl()));
  sl.registerLazySingleton(() => AddPetTags(sl()));

  // ? Repository
  sl.registerLazySingleton<PetsRepository>(
      () => PetsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources

  sl.registerLazySingleton<PetsRemoteDataSource>(
      () => PetsRemoteDataSourceImpl(client: sl()));

  //* ---------------------------------  Feature Messages  --------------------------

  // ? Bloc
  sl.registerFactory(() => MessagesBloc(
        listMessages: sl(),
        goToSpecificMessage: sl(),
        sendMessage: sl(),
        deleteDiscussion: sl(),
      ));

  // ? Use cases
  sl.registerLazySingleton(() => ListMessages(sl()));
  sl.registerLazySingleton(() => GoToSpecificMessage(sl()));
  sl.registerLazySingleton(() => SendMessage(sl()));
  sl.registerLazySingleton(() => DeleteDiscussion(sl()));

  // ? Repository
  sl.registerLazySingleton<MessagesRepository>(
      () => MessagesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<MessagesRemoteDataSource>(
      () => MessagesRemoteDataSourceImpl(client: sl()));

  //* ---------------------------------  Feature Reminders  --------------------------

  // ? Bloc
  sl.registerFactory(() => RemindersBloc(
        reminderList: sl(),
      ));

  // ? Use cases
  sl.registerLazySingleton(() => ReminderList(sl()));

  // ? Repository
  sl.registerLazySingleton<ReminderRepository>(
      () => ReminderRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // ? Data sources
  sl.registerLazySingleton<ReminderRemoteDataSource>(
      () => ReminderRemoteDataSourceImpl(client: sl()));

  //*--------------------------------------- External  --------------------------------------

  sl.registerLazySingleton(() => SocialMediaService());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => SharedPreferences.getInstance());
}


