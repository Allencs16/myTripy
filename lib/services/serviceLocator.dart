import 'package:get_it/get_it.dart';
import 'package:mytripy/services/user/userService.dart';
import 'package:mytripy/services/user/userServiceImpl.dart';

final getIt = GetIt.instance;

setupServiceLocator() {
  getIt.registerLazySingleton<UserService>(() => UserServiceImpl());
}