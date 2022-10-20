import 'dart:convert';
import 'package:cbot/model/User.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class authSave {
  saveLoginData(var data) async {
    data = jsonDecode(data);
    User user = User.fromJson(data);
    SharedPreferences sh = await SharedPreferences.getInstance();
    await sh.setBool('user', true);
    await sh.setString('id', user.id.toString());
    await sh.setString('token', user.token.toString());
    await sh.setString('upDatedAt', user.updatedAt.toString());
    await sh.setString('createdAt', user.createdAt.toString());
  }

  static Future<bool?> getLoggedinStatus() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    return await sh.getBool('user');
  }

  static Future<String?> getId() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    return await sh.getString('id');
  }

  static Future<String?> getToken() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    return await sh.getString('token');
  }

  static Future<bool?> logoutDevice() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    await sh.setBool('user', false);
  }
}
