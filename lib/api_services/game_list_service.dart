import 'dart:convert';
import 'package:fidigames/model/game_list_model.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class GameListService {
  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    final response = await http.get(
      Uri.parse(
        'https://fidigamesapi.herokuapp.com/games',
      ),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'api-key': token,
      },
    );

    if (response.statusCode == 200) {
      GameListModel gameData =
          GameListModel.fromJson(jsonDecode(response.body));

      return gameData.data;
    }
  }
}
