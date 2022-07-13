import 'package:fidigames/api_services/add_like.dart';
import 'package:fidigames/api_services/category_service.dart';
import 'package:fidigames/api_services/game_list_service.dart';
import 'package:fidigames/api_services/remove_like.dart';
import 'package:fidigames/model/category_gamelist_model.dart';
import 'package:fidigames/model/game_list_model.dart';
import 'package:fidigames/themes/colors/colors.dart';

import 'package:fidigames/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

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

  Color unLikeButtonColor = AppColor.primaryTextColor;

  Color likeButtonColor = AppColor.buttonBackgroundColor;

  List<GameDetail> gamesData = [];
  List<CategoryGameDetail> categoryData = [];

  @override
  void initState() {
    getAllGames();
    super.initState();
  }

  Future getAllGames() async {
    try {
      return await gameListService.getData().then((data) {
        setState(() {
          gamesData = data;
        });
      });
    } catch (error) {
      return null;
    }
  }

  Future categoryGameData(String selectValue) async {
    try {
      return await categoryService.getData(selectValue).then((gameData) {
        setState(() {
          categoryData = gameData;
        });
      });
    } catch (error) {
      return null;
    }
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
                  CustomText(textSize: textSize * 20, text: 'Fidigames'),
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
                      child: gamesData.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: selectedValue == null
                                  ? gamesData.length
                                  : categoryData.length,
                              itemBuilder: (context, index) {
                                if (selectedValue == null) {
                                  GameDetail dataList = gamesData[index];

                                  return GamesDataCard(
                                    dataList: dataList,
                                    likeColor: gamesData[index].likesCount == 0
                                        ? unLikeButtonColor
                                        : likeButtonColor,
                                    onTapLikeCount: () {
                                      if (gamesData[index].likesCount! < 1) {
                                        setState(() {
                                          addLikeService.addLike(
                                              likesCount:
                                                  '${gamesData[index].likesCount = gamesData[index].likesCount! + 1}',
                                              idNum: '${gamesData[index].id}');
                                        });
                                      } else if (gamesData[index].likesCount! >
                                          0) {
                                        setState(() {
                                          removeLikeService.removeLike(
                                              likesCount:
                                                  '${gamesData[index].likesCount = gamesData[index].likesCount! - 1}',
                                              idNum: '${gamesData[index].id}');
                                        });
                                      }
                                    },
                                  );
                                }

                                CategoryGameDetail categoryDataList =
                                    categoryData[index];

                                return selectedValue ==
                                        categoryData[index].gameCategory
                                    ? CategoryGamesCard(
                                        dataList: categoryDataList,
                                        likeColor:
                                            categoryData[index].likesCount == 0
                                                ? unLikeButtonColor
                                                : likeButtonColor,
                                        onTapLikeCount: () {
                                          if (categoryData[index].likesCount! <
                                              1) {
                                            setState(() {
                                              addLikeService.addLike(
                                                  likesCount:
                                                      '${categoryData[index].likesCount = categoryData[index].likesCount! + 1}',
                                                  idNum:
                                                      '${categoryData[index].id}');
                                            });
                                          } else if (categoryData[index]
                                                  .likesCount! >
                                              0) {
                                            setState(() {
                                              removeLikeService.removeLike(
                                                  likesCount:
                                                      '${categoryData[index].likesCount = categoryData[index].likesCount! - 1}',
                                                  idNum:
                                                      '${categoryData[index].id}');
                                            });
                                          }
                                        },
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      );
                              }))
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
