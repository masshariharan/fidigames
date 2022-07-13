import 'dart:convert';


import 'package:fidigames/model/category_gamelist_model.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  Future getData(String? categoryName) async {
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
        CategoryGameListModel categoryGameData =
            CategoryGameListModel.fromJson(jsonDecode(response.body));

        //Logger().wtf(categoryGameData.categoryData![0].gameName);

        return categoryGameData.categoryData;
      }
    
  }
}
