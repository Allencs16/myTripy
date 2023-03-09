import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/services/user/userService.dart';

class UserServiceImpl extends UserService{
  late Future<User> usuarioLogado;

  @override
  Future<User> getUserLogado() {
    return usuarioLogado;
  }

  @override
  void setUser(Future<User> usuario) {
    usuarioLogado = usuario;
  }
}