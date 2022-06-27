import 'package:flutter/material.dart';
import 'package:sqlitecrudprovider/src/database/db_helper.dart';
import 'package:sqlitecrudprovider/src/model/user.dart';

class UserProvider with ChangeNotifier{

  late List<User> _userList;

  List<User> get userList => _userList;

  
  Future<void> addUser(String nombre, String apellidos, String email) async{   
    User user = User(nombre: nombre, apellidos: apellidos, email: email);
    await DBHelper.instance.createUser(user);
  } 


  Future<void> listUsers() async{
    _userList = await DBHelper.instance.listUsers();

    notifyListeners();
  }
}