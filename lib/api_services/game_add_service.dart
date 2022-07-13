
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';



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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    await http.post(
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
  }
}
