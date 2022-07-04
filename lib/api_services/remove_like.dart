import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:logger/logger.dart';

class RemoveLikeService {
  Future removeLike({required String likesCount, required String idNum}) async {
    String gameAddURL =
        'https://fidigamesapi.herokuapp.com/games/$idNum/removelike';
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;

      var response = await http.delete(
        Uri.parse(gameAddURL),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'api-key': token,
        },
        body: json.encode({"game_likes_count": likesCount}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        Logger().wtf(data);
      } else {
        Logger().wtf('failed');
      }
    } catch (e) {
      Logger().wtf(e);
    }
  }
}
