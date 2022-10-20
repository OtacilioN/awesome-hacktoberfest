import 'package:cbot/widget/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
          child: context.screenWidth < 1000
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Create together\nSupport Community\nStay Connected",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 45,
                            color: Vx.white,
                            shadows: [
                              Shadow(color: Vx.gray600, blurRadius: 25)
                            ],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      formScreen(context, 1, _formKey)
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    formScreen(context, 1, _formKey)
                  ],
                ),
        ));
  }
}
