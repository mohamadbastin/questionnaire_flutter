import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/models/profile.dart';
import 'package:questionnaire_flutter/providers/formProvider.dart';
import 'package:questionnaire_flutter/screens/recent.dart';
import 'package:questionnaire_flutter/screens/splashScreen.dart';
import 'screens/authScreen.dart';

void main() => runApp(MyApp());

final String host = "http://127.0.0.1:8000";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<Profile>.value(value: Profile()),
      // ChangeNotifierProvider<FormProvider>.value(value: FormProvider())
      ],
      child: MaterialApp(
        title: 'AskFill',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: MyHomePage(),
        routes: {
          // "/": (_) => SplashScreen(),
          RecentFormsScreen.routeName : (_) => RecentFormsScreen(),
          AuthScreen.routeName : (_) => AuthScreen(),
          
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
