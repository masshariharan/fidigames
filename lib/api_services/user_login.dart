import 'package:fidigames/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  String loginUrl = 'https://fidigamesapi.herokuapp.com/games/login';

  dynamic data;
  Future userLogin(String email, password) async {
    try {
      var response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          "user_username": email,
          "user_password": password,
        }),
      );

      if (response.statusCode == 200) {
        data = LoginResponseModel.fromJson(jsonDecode(response.body));

        String token = data.apiKey;
       
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
     
      } else {
        Logger().wtf('failed');
      }
    } catch (e) {
      Logger().wtf(e);
    }
  }
}
