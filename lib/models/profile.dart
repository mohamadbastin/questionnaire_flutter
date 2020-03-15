import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile with ChangeNotifier {
  int id;
  String name;
  String email;
  String picture;
  String phone;
  String token;

  Profile(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.picture});

  bool get isAuth {
    return token != null;
  }
}
