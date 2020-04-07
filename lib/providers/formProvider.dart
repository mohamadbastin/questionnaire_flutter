import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/models/form.dart';
import 'package:questionnaire_flutter/models/profile.dart';
import 'package:questionnaire_flutter/main.dart';


List<myForm> myFormsList = [];

class FormProvider with ChangeNotifier {
  List<myForm> _myForms = [];

  List<myForm> get myForms {
    List<myForm> myForms = [];
    for (var form in _myForms) {
      myForms.add(form);
    }
    return myForms;
  }

  Future<void> fetchAndSetmyForms() async {
    // String token = await Provider.of<Profile>(context, listen: false).token;
    // print ("asfg");
    var response = await http.get(host + "/form/list/", headers: {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      "Authorization": "Token " + authtoken.toString(),
    });

    print(response.body);

    var extractedData = List<Map<String, dynamic>>.from(
        jsonDecode(utf8.decode(response.bodyBytes)));

    print(extractedData);

    final List<myForm> extractedList = [];
    // print(extractedData.length);
    // print(2);

    extractedData.forEach((form) {
      var i = form['author'];
      Profile tmp_profile = new Profile(
          id: i['id'],
          name: i['name'],
          phone: i['phone'],
          email: i['email'],
          picture: i['picture']);

        // print(3);

      List<int> times = [];
      // print(form['time']);
      for (int j=0; j<form['time'].length;j++){
        // print();
        times.add(int.parse(form['time'][j]['hour']));
      }
      // print(4);
      // print(times.length);

      extractedList.add(myForm(
        id: form['id'],
        name: form['name'],
        author: tmp_profile,
        description: form['description'],
        is_active: form['is_active'],
        is_private: form['ia_private'],
        is_repeated: form['is_repeated'],
        created: form['created'],
        estimated_time: form['estimated_time'],
        duration: form['duration'],
        times: times
      
      ));
      // print(MediaQuery.of(context));
    });
    _myForms = extractedList;
    myFormsList = extractedList;
    // print(_myForms);
    // print(_myForms.length);
    notifyListeners();
  }

  myForm findById(int id) {
    return _myForms.firstWhere((form) {
      return form.id == id;
    });
  }
}
