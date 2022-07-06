import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:logger/logger.dart';

class AddLikeService {
  Future addLike({required String likesCount, required String idNum}) async {
    String gameAddURL =
        'https://fidigamesapi.herokuapp.com/games/$idNum/addlike';
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;

       await http.put(
        Uri.parse(gameAddURL),

        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'api-key': token,
        },
        body: json.encode({"game_likes_count": likesCount}),
      );



  }
}
