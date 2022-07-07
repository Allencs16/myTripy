import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/services/user/userService.dart';

class UserServiceImpl extends UserService{
  late User usuarioOnline;

  @override
  void setUser(User user) {
    this.usuarioOnline = user;
  }

  @override
  User getUser(){
    return this.usuarioOnline;
  }
}