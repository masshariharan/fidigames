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

  @override
  void initState() {
    getGameData();
    super.initState();
  }

  Future getGameData() async {
    return await gameListService.getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);
    // var logger = Logger();
    // logger.d(height / 14.3);

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
                        categoryService.getData(selectedValue!);
                      });
                    },
                  ),
                  SizedBox(
                    height: height / 35.8,
                  ),
                  FutureBuilder(
                      future: selectedValue == null
                          ? getGameData()
                          : categoryService.getData(selectedValue),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        //Logger().wtf(getGameData());

                        if (!snapshot.hasData) {
                          return const Center(
                              child: Text(
                            'No Games Data',
                            style: textStyle,
                          ));
                        } else {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ReusableCard(
                                    image: Image.network(
                                      snapshot.data[index]['game_image_url'],
                                      fit: BoxFit.fill,
                                    ),
                                    title: snapshot.data[index]['game_name'],
                                    content: snapshot.data[index]['game_url'],
                                    n1: snapshot.data[index]['game_minp'],
                                    n2: snapshot.data[index]['game_maxp'],
                                    likesCount: snapshot.data[index]
                                        ['game_likes_count'],
                                    iconWidget: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (snapshot.data[index]
                                                    ['game_likes_count'] <
                                                1) {
                                              addLikeService.addLike(
                                                  likesCount:
                                                      '${snapshot.data[index]['game_likes_count'] = snapshot.data[index]['game_likes_count'] + 1}',
                                                  idNum:
                                                      '${snapshot.data[index]['id']}');
                                            } else if (snapshot.data[index]
                                                    ['game_likes_count'] >
                                                0) {
                                              removeLikeService.removeLike(
                                                  likesCount:
                                                      '${snapshot.data[index]['game_likes_count'] - 1}',
                                                  idNum:
                                                      '${snapshot.data[index]['id']}');
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          size: textSize * 16,
                                          color: snapshot.data[index]
                                                      ['game_likes_count'] ==
                                                  0
                                              ? AppColor.primaryTextColor
                                              : AppColor.buttonBackgroundColor,
                                        )),
                                  );
                                }),
                          );
                        }
                      }),
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
