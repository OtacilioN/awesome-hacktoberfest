import 'dart:async';
import 'dart:convert';
import 'package:cbot/helper/authSave.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

Widget formScreen(BuildContext context, int c, GlobalKey<FormState> _formKey) {
  String email = "";
  String password = "";

  return Container(
    width: 450,
    padding: EdgeInsets.all(45),
    height: context.screenHeight * 0.6,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [
          Colors.white.withOpacity(0.8),
          Colors.white.withOpacity(0.3)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(c == 1 ? "LOGIN" : "SIGN UP",
              style: TextStyle(
                  letterSpacing: 1.2,
                  color: Colors.blue.shade700,
                  fontSize: 35,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: 35,
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: Colors.blue.shade900,
                        width: 1,
                        style: BorderStyle.solid))),
            validator: (value) {
              var pattern =
                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                  r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
                  r"{0,253}[a-zA-Z0-9])?)*$";
              RegExp regex = new RegExp(pattern);
              if (!regex.hasMatch(value.toString()) || value.isEmptyOrNull)
                return 'Enter a valid email address';
              else
                return null;
            },
            onSaved: (value) {
              email = value.toString();
            },
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        color: Colors.blue.shade900,
                        width: 1,
                        style: BorderStyle.solid))),
            validator: (value) {
              var pattern =
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~_]).{5,}$';
              RegExp regex = new RegExp(pattern);
              if (!regex.hasMatch(value.toString()) || value.isEmptyOrNull)
                return 'Enter a 5-digit password with atleast one UperCase Letter,\none LowerCase Letter & a Special Symbol';
              else
                return null;
            },
            onSaved: (value) {
              password = value.toString();
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.blue.shade700, fontSize: 15),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                //auth(context, 'adityanandi008@gmail.com', 'Phoenix@225',
//_formKey, 1, 'https://cbot-backend.herokuapp.com/login');
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  c == 1
                      ? auth(context, email, password, _formKey, 1,
                          'https://cbot-backend.herokuapp.com/login')
                      : auth(context, email, password, _formKey, 2,
                          'https://cbot-backend.herokuapp.com/signup');
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: context.screenWidth * 0.6 > 500
                    ? 450 - 90
                    : context.screenWidth * 0.6 - 90,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.all(15),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Vx.white, fontSize: 15),
                ),
              )),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(c == 1 ? '/signup' : '/signin');
              },
              child: Center(
                child: Text(
                  c != 1
                      ? "Already a user? Sign In"
                      : "Don't have an account? Sign Up",
                  style: TextStyle(color: Vx.black, fontSize: 15),
                ),
              )),
        ],
      ),
    ),
  );
}

auth(BuildContext context, String email, String password,
    GlobalKey<FormState> _formKey, int p, String link) async {
  var url = Uri.parse(link);
  var response = await http.post(url,
      body: json.encode({'email': email, 'password': password}),
      headers: {'content-type': 'application/json'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    shDialog(context, result, _formKey, 2);
    authSave().saveLoginData(response.body);
    Timer(Duration(milliseconds: 2500),
        () => Navigator.pushReplacementNamed(context, '/'));
  }
  if (response.statusCode == 400) {
    var result = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.up,
      duration: Duration(milliseconds: 2000),
      content: Text(
        result['message'],
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.red[200],
    ));
  }
}

shDialog(
    BuildContext context, var result, GlobalKey<FormState> _formKey, int p) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('./lib/assets/success.gif'),
                SizedBox(
                  height: 25,
                ),
                Text(
                  result['message'],
                  style: TextStyle(fontSize: 25, color: Colors.black),
                )
              ],
            ),
          ),
        );
      });

  Timer timer = Timer(Duration(milliseconds: 2000), () {
    Navigator.of(context, rootNavigator: true).pop();
    _formKey.currentState!.reset();
  });
}
