import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:questionnaire_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  Future<bool> autologin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("askfilltoken")) {
      return false;
    }
    // add other information
    token = prefs.getString("askfilltoken");
    notifyListeners();
    return true;
  }

  Future<void> sendCode(String phone) async {
    await http.post("$host/register/",
        body: json.encode({
          'phone': phone,
        }),
        headers: {
          'Content-Type': 'application/json',
        });
        print("sending code");
  }
}
