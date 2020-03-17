// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:questionnaire_flutter/models/form.dart';
// import 'package:questionnaire_flutter/models/profile.dart';
// import 'package:questionnaire_flutter/main.dart';

// class FormProvider with ChangeNotifier {
//   List<myForm> _myForms = [];

//   List<myForm> get myForms {
//     List<myForm> myForms = [];
//     for (var form in _myForms) {
//       myForms.add(form);
//     }
//     return myForms;
//   }

//   Future<void> fetchAndSetmyForms(String token) async {
//     var response = await http.get(host + "/form/list/", headers: {
//       "Accept": "application/json",
//       'Content-Type': 'application/json',
//       "Authorization": "Token " + token.toString(),
//     });

//     var extractedData = List<Map<String, dynamic>>.from(
//         jsonDecode(utf8.decode(response.bodyBytes)));

//     final List<myForm> extractedList = [];

//     extractedData.forEach((form) {
//       var i = form['author'];
//       Profile tmp_profile = new Profile(
//           id: i['id'],
//           name: i['name'],
//           phone: i['phone'],
//           email: i['email'],
//           picture: i['picture']);

//       List<int> times = [];
//       for (int j=0; j<form['times'].length;j++){
//         times.add(form['times'][j]['hour'].substring(0,2));
//       }
//       print(times.length);

//       extractedList.add(myForm(
//         id: form['id'],
//         name: form['name'],
//         author: tmp_profile,
//         description: form['description'],
//         is_active: form['is_active'],
//         is_private: form['ia_private'],
//         is_repeated: form['is_repeated'],
//         created: form['created'],
//         estimated_time: form['estimated_time'],
//         duration: form['duration'],
//         times: times
      
//       ));
//     });
//     _myForms = extractedList;
//     // print(_myForms.length);
//     notifyListeners();
//   }

//   myForm findById(int id) {
//     return _myForms.firstWhere((form) {
//       return form.id == id;
//     });
//   }
// }
