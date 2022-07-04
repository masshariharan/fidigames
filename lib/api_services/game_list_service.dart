import 'dart:convert';
import 'package:fidigames/model/game_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameListService {
  Future getData() async {
    try {
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
        var gameData = GameListModel.fromJson(jsonDecode(response.body));

        // Logger().wtf(gameData.data);
        //data = gameData.data!;

        return gameData.data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      Logger().wtf(e);
    }
  }
}
