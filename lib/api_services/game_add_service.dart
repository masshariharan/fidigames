import 'package:fidigames/model/game_add_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:logger/logger.dart';

class GameAddService {
  String gameAddURL = 'https://fidigamesapi.herokuapp.com/games';

  Future gameAdd(
      {required String gameName,
      required String description,
      required String imageURL,
      required String gameUrl,
      required String minP,
      required String maxP,
      required String category}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;

      var response = await http.post(
        Uri.parse(gameAddURL),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'api-key': token,
        },
        body: json.encode({
          "game_name": gameName,
          "game_description": description,
          "game_image_url": imageURL,
          "game_url": gameUrl,
          "game_minp": minP,
          "game_maxp": maxP,
          "game_category": category,
        }),
      );

      if (response.statusCode == 200) {
        var data = GameAddModel.fromJson(jsonDecode(response.body));

        Logger().wtf(data);
      } else {
        Logger().wtf('failed');
      }
    } catch (e) {
      Logger().wtf(e);
    }
  }
}