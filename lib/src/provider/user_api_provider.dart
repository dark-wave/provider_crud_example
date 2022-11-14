import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqlitecrudprovider/src/api/api_const.dart';
import 'package:sqlitecrudprovider/src/model/user.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class UserApiProvider extends ChangeNotifier{
  static List<User> _userList = []; 

  List<User> get userList => _userList;

  Future<void> addUser(String nombre, String apellidos, String email) async{
    final String baseUrl = Platform.isIOS ? ApiConst.baseUrlIos : ApiConst.baseUrlAndroid; 
    const String endPoint = 'users';
    final User user = User(nombre: nombre, apellidos: apellidos, email: email);

    var url = Uri.parse(baseUrl + endPoint);
    await http.post(url, 
                    headers: {'Content-Type': 'application/json'}, 
                    body: userToJson(user));

    listUsers();
  }

  Future<void> updateUser(User user) async{
    final String baseUrl = Platform.isIOS ? ApiConst.baseUrlIos : ApiConst.baseUrlAndroid; 
    const String endPoint = 'users';

    var url = Uri.parse('$baseUrl$endPoint/${user.id}');

    await http.put(url, 
                  headers: {'Content-Type': 'application/json'},
                  body: userToJson(user));

    listUsers();
  }

  Future<void> deleteUser(int id) async{
    final String baseUrl = Platform.isIOS ? ApiConst.baseUrlIos : ApiConst.baseUrlAndroid; 
    const String endPoint = 'users';

    var url = Uri.parse('$baseUrl$endPoint/$id');

    await http.delete(url);

    listUsers();
  }

  Future<void> listUsers() async{
    final String baseUrl = Platform.isIOS ? ApiConst.baseUrlIos : ApiConst.baseUrlAndroid; 
    const String endPoint = 'users';

    var url = Uri.parse(baseUrl + endPoint);
    var response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if(response.statusCode ==200){
      List<dynamic> jsonReponse = json.decode(utf8.decode(response.bodyBytes));
      _userList = jsonReponse.map((user) => User.fromJson(user)).toList();

      notifyListeners();
    }
  }
}