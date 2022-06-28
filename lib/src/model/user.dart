import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String nombre;
  String? apellidos;
  String email;

  User({
    this.id,
    required this.nombre,
    this.apellidos,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    nombre: json["nombre"],
    apellidos: json["apellidos"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "apellidos": apellidos,
    "email": email,
  };
}