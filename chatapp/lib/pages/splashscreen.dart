import 'dart:async';

import 'package:cbot/helper/authSave.dart';
import 'package:cbot/pages/homescreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
    Timer(Duration(milliseconds: 3000), () {
      if (loggedIn == null) {
        Navigator.pushReplacementNamed(context, '/signin');
      } else {
        if (loggedIn)
          Navigator.pushReplacementNamed(context, '/');
        else
          Navigator.pushReplacementNamed(context, '/signin');
      }
    });
  }

  getStatus() async {
    await authSave.getLoggedinStatus().then((value) => {loggedIn = value!});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                './lib/assets/splash.gif',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Splash Screen",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
