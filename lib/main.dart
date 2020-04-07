import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/models/profile.dart';
import 'package:questionnaire_flutter/providers/formProvider.dart';
import 'package:questionnaire_flutter/screens/createForm.dart';
import 'package:questionnaire_flutter/screens/entercode.dart';
import 'package:questionnaire_flutter/screens/recent.dart';
import 'package:questionnaire_flutter/screens/splashScreen.dart';
import 'screens/authScreen.dart';

void main() => runApp(MyApp());

final String host = "https://ques.mbastin.ir";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Profile>.value(value: Profile()),
      ChangeNotifierProvider<FormProvider>.value(value: FormProvider())
      ],
      child: MaterialApp(
        title: 'AskFill',
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            focusColor: Colors.deepOrange,
            accentColor: Colors.deepPurpleAccent,
            brightness: Brightness.dark,
            inputDecorationTheme: InputDecorationTheme(
                filled: true,
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        width: 2.0
                    ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        color: Colors.white70,
                        width: 2.0
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                        color: Colors.white,
                        width: 1.0
                    )
                )
            )
        ),
        home: MyHomePage(),
        routes: {
          // "/": (_) => SplashScreen(),
          RecentFormsScreen.routeName : (_) => RecentFormsScreen(),
          AuthScreen.routeName : (_) => AuthScreen(),
          EnterCodeScreen.routeName: (_) => EnterCodeScreen(),
          CreateFormScreen.routeName: (_) => CreateFormScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: SplashScreen(),
    );
  }
}
