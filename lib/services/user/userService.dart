import 'package:mytripy/models/user/user.dart';

abstract class UserService {
  
  void setUser(User user);
  
  User getUser(); 
}