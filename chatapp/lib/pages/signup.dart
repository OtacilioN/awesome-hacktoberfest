import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widget/widgets.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        alignment: context.screenWidth > 1000
            ? Alignment.center
            : Alignment.bottomCenter,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('./lib/assets/bg.jpg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: context.screenWidth < 1000
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Create together\nSupport Community\nStay Connected",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 45,
                          color: Vx.white,
                          shadows: [Shadow(color: Vx.gray600, blurRadius: 25)],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    formScreen(context, 2, _formKey)
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        child: Text(
                      "Create together\nSupport Community\nStay Connected",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 45,
                          color: Vx.white,
                          shadows: [Shadow(color: Vx.gray600, blurRadius: 25)],
                          fontWeight: FontWeight.bold),
                    )),
                    formScreen(context, 2, _formKey)
                  ],
                ),
        ),
      ),
    );
  }
}
