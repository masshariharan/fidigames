import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  Future getData(String? categoryName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;

      final url = Uri.parse(
        'https://fidigamesapi.herokuapp.com/games/category/$categoryName',
      );

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'api-key': token,
        },
      );

      if (response.statusCode == 200) {
        Logger().wtf(jsonDecode(response.body));

        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      Logger().wtf(e);
    }
  }
}
