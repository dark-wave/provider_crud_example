import 'package:flutter/material.dart';
import 'package:sqlitecrudprovider/src/model/user.dart';

class UserApiProvider extends ChangeNotifier{
  static List<User> _userList = []; 

  List<User> get userList => _userList;
}