import 'package:get_it/get_it.dart';
import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/requestService.dart/request-serviceImpl.dart';
import 'package:mytripy/services/user/userService.dart';
import 'package:mytripy/services/user/userServiceImpl.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<UserService>(() => UserServiceImpl());
  getIt.registerLazySingleton<RequestService>(() => RequestServiceImpl());
}