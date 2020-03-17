import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:questionnaire_flutter/models/profile.dart';




class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => 
            Transform.rotate(angle: animation.value,
            child: LogoWidget())
            ,child: child)
      );
}


class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  Widget build(BuildContext context) => Container(
        height: 200,
        child: Image.asset('assets/images/frm.png'),
      );
}



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  Animation<double> animation;         
  AnimationController controller;
  bool _auth;
  String route;
  Future<bool> _autologin;


  void navigationPage(){
    controller.dispose();

    Navigator.of(context).popAndPushNamed(route);
  }

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  routemaker() async {
    if (_auth || await _autologin){
        route = '/recent';
      } else{
        route = '/auth';
      }
  }

  @override
  void initState() {
      super.initState();


      startTime();


      controller = AnimationController(vsync: this, duration: Duration(seconds: 2));

      animation = Tween<double>(begin: 0, end: 6).animate(controller)
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed){
          controller.repeat();
        }
      });

          controller.forward();

      _auth = Provider.of<Profile>(context, listen: false).isAuth;
      _autologin = Provider.of<Profile>(context, listen: false).autologin();

      routemaker();

    }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blueGrey,
      child: Center(child: GrowTransition(animation: animation, child: LogoWidget()),),
    );
  }
}