import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String nombre;
  String? apellidos;
  String email;

  User({
      required this.nombre,
      this.apellidos,
      required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      nombre: json["nombre"],
      apellidos: json["apellidos"],
      email: json["email"],
  );

  Map<String, dynamic> toJson() => {
      "nombre": nombre,
      "apellidos": apellidos,
      "email": email,
  };
}