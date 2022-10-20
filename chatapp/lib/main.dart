import 'package:camera/camera.dart';
import 'package:cbot/pages/Camera_content.dart';
import 'package:cbot/pages/homescreen.dart';
import 'package:cbot/pages/signin.dart';
import 'package:cbot/pages/signup.dart';
import 'package:cbot/pages/splashscreen.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } catch (CameraException) {
    cameras = [];
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '',
      onGenerateRoute: (settings) {
        if (settings.name == '') {
          return MaterialPageRoute(builder: (_) => SplashScreen());
        }
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (_) => Homescreen());
        }
        var uri = settings.name.toString().replaceAll('/', '');
        print(uri);
        if (uri == 'signin') {
          return MaterialPageRoute(builder: (_) => Signin());
        } else if (uri == 'signup') {
          return MaterialPageRoute(builder: (_) => Signup());
        }
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
