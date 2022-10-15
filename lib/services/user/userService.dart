import 'package:mytripy/models/user/user.dart';

abstract class UserService {
  
  Future<User> getUserLogado();

  void setUser(Future<User> usuario);
}