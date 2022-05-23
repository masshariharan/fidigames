import 'package:fidigames/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  String loginUrl = 'https://fidigamesapi.herokuapp.com/games/login';

  void userLogin(String email, password) async {
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

        var data = LoginResponseModel.fromJson(jsonDecode(response.body));

        print(data.msg);
        print(data.apiKey);
      } else {
        print('failed');
      }
    } catch (e) {
      print(e);
    }
  }
}


