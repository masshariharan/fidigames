import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fidigames/api_services/add_like.dart';
import 'package:fidigames/api_services/category_service.dart';
import 'package:fidigames/api_services/game_list_service.dart';
import 'package:fidigames/api_services/remove_like.dart';
import 'package:fidigames/model/game_list_model.dart';
import 'package:fidigames/themes/colors/colors.dart';
import 'package:fidigames/themes/styles/styles.dart';
import 'package:fidigames/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'games_add_view.dart';

String? selectedValue;

class FidigamesList extends StatefulWidget {
  const FidigamesList({Key? key}) : super(key: key);

  static const String id = 'FidigameList_screen';

  @override
  State<FidigamesList> createState() => _FidigamesListState();
}

class _FidigamesListState extends State<FidigamesList> {
  GameListService gameListService = GameListService();

  CategoryService categoryService = CategoryService();

  AddLikeService addLikeService = AddLikeService();

  RemoveLikeService removeLikeService = RemoveLikeService();

  Color likeColor = AppColor.primaryTextColor;

  List gamesData = [];
  List categoryData = [];

  @override
  void initState() {
    getAllGames();
    super.initState();
  }

  Future getAllGames() async {
    return await gameListService.getData().then((data) {
      setState(() {
        gamesData = data;
      });
    });
  }

  Future categoryGameData(String selectValue) async {
    return await categoryService.getData(selectValue).then((gameData) {
      setState(() {
        categoryData = gameData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);

    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width / 18),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height / 28.7),
                  Text(
                    'Fidigames',
                    style: textStyle.copyWith(fontSize: textSize * 20),
                  ),
                  SizedBox(height: height / 28.7),
                  ReusableDropdownButton(
                    selectedValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                        categoryGameData(selectedValue!);
                      });
                    },
                  ),
                  SizedBox(
                    height: height / 35.8,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: selectedValue == null
                            ? gamesData.length
                            : categoryData.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (selectedValue == null) {
                            return ReusableCard(
                              image: Image.network(
                                gamesData[index]['game_image_url'],
                                fit: BoxFit.fill,
                              ),
                              title: gamesData[index]['game_name'],
                              content: gamesData[index]['game_url'],
                              n1: gamesData[index]['game_minp'],
                              n2: gamesData[index]['game_maxp'],
                              likesCount: gamesData[index]['game_likes_count'],
                              iconWidget: IconButton(
                                  onPressed: () {
                                    if (gamesData[index]['game_likes_count'] <
                                        1) {
                                      setState(() {
                                        addLikeService.addLike(
                                            likesCount:
                                                '${gamesData[index]['game_likes_count'] = gamesData[index]['game_likes_count'] + 1}',
                                            idNum: '${gamesData[index]['id']}');
                                      });
                                    } else if (gamesData[index]
                                            ['game_likes_count'] >
                                        0) {
                                      setState(() {
                                        removeLikeService.removeLike(
                                            likesCount:
                                                '${gamesData[index]['game_likes_count'] - 1}',
                                            idNum: '${gamesData[index]['id']}');
                                      });
                                    }
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    size: textSize * 16,
                                    color: gamesData[index]
                                                ['game_likes_count'] ==
                                            0
                                        ? AppColor.primaryTextColor
                                        : AppColor.buttonBackgroundColor,
                                  )),
                            );
                          } else if (selectedValue != null) {
                            return ReusableCard(
                              image: Image.network(
                                categoryData[index]['game_image_url'],
                                fit: BoxFit.fill,
                              ),
                              title: categoryData[index]['game_name'],
                              content: categoryData[index]['game_url'],
                              n1: categoryData[index]['game_minp'],
                              n2: categoryData[index]['game_maxp'],
                              likesCount: categoryData[index]
                                  ['game_likes_count'],
                              iconWidget: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (categoryData[index]
                                              ['game_likes_count'] <
                                          1) {
                                        addLikeService.addLike(
                                            likesCount:
                                                '${categoryData[index]['game_likes_count'] = categoryData[index]['game_likes_count'] + 1}',
                                            idNum:
                                                '${categoryData[index]['id']}');
                                      } else if (categoryData[index]
                                              ['game_likes_count'] >
                                          0) {
                                        removeLikeService.removeLike(
                                            likesCount:
                                                '${categoryData[index]['game_likes_count'] - 1}',
                                            idNum:
                                                '${categoryData[index]['id']}');
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    size: textSize * 16,
                                    color: categoryData[index]
                                                ['game_likes_count'] ==
                                            0
                                        ? AppColor.primaryTextColor
                                        : AppColor.buttonBackgroundColor,
                                  )),
                            );
                          }
                          return Center(
                              child: Text(
                            'No Data',
                            style: textStyle.copyWith(fontSize: textSize * 18),
                          ));
                        }),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height / 14.3),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ReusableButton(
                        text: '+ Add Games',
                        onPressed: () {
                          Navigator.pushNamed(context, GamesAddView.id);
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
