import 'package:flutter/material.dart';
import 'package:sqlitecrudprovider/src/model/user.dart';

class UserApiProvider extends ChangeNotifier{
  static List<User> _userList = []; 

  List<User> get userList => _userList;

  Future<void> addUser(String nombre, String apellidos, String email) async{}

  Future<void> updateUser(User user) async{}

  Future<void> deleteUser(int id) async{}

  Future<void> listUsers() async{}
}