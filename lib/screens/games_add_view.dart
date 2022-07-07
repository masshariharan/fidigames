import 'package:fidigames/api_services/game_add_service.dart';
import 'package:fidigames/screens/fidigames_list.dart';
import 'package:fidigames/themes/colors/colors.dart';
import 'package:fidigames/themes/styles/styles.dart';
import 'package:fidigames/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class GamesAddView extends StatefulWidget {
  const GamesAddView({Key? key}) : super(key: key);

  static const String id = 'GamesAdd_screen';

  @override
  State<GamesAddView> createState() => _GamesAddViewState();
}

class _GamesAddViewState extends State<GamesAddView> {
  final _formKey = GlobalKey<FormState>();
  final gameNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final gameURLController = TextEditingController();
  final imageURLController = TextEditingController();

  final minCountController = TextEditingController();
  final maxCountController = TextEditingController();

  GameAddService gameAddService = GameAddService();

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);
    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: height / 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_sharp,
                              color: AppColor.primaryTextColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width / 24),
                            child: Text(
                              'Add a Game',
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: textSize * 20),
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: height / 29,
                  ),
                  HeadingText(text: 'Name of the Game', textSize: textSize),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height / 140,
                    ),
                    child: ReusableTextField(
                      controller: gameNameController,
                      num: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the Game Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: height / 29,
                  ),
                  HeadingText(text: 'Description', textSize: textSize),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height / 140,
                    ),
                    child: ReusableTextField(
                      controller: descriptionController,
                      num: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Description can't empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: height / 29,
                  ),
                  HeadingText(text: 'Game URL', textSize: textSize),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height / 140,
                    ),
                    child: ReusableTextField(
                      controller: gameURLController,
                      num: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Game URL';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  HeadingText(text: 'Image URL', textSize: textSize),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height / 140,
                    ),
                    child: ReusableTextField(
                      controller: imageURLController,
                      num: 1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required Image URL';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  HeadingText(text: 'Players Count', textSize: textSize),
                  Padding(
                    padding: EdgeInsets.only(top: height / 36),
                    child: Row(
                      children: [
                        CountName(text: 'Minimum Count', textSize: textSize),
                        CountBox(
                          controller: minCountController,
                        ),
                        SizedBox(
                          width: width / 15,
                        ),
                        CountName(text: 'Maximum Count', textSize: textSize),
                        CountBox(
                          controller: maxCountController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  HeadingText(text: 'Category', textSize: textSize),
                  GameCategoryDropdown(
                    selectedValue: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                  ),
                  SizedBox(
                    height: height / 24,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height / 24),
                    child: Align(
                        alignment: Alignment.center,
                        child: ReusableButton(
                            text: 'Submit',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (selectedValue == null) {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => const AlertDialog(
                                            content: Text("can't empty"),
                                          ));
                                } else {
                                  gameAddService.gameAdd(
                                      gameName: gameNameController.text,
                                      description: descriptionController.text,
                                      gameUrl: gameURLController.text,
                                      imageURL: imageURLController.text,
                                      minP: minCountController.text,
                                      maxP: maxCountController.text,
                                      category: selectedValue!);

                                  Navigator.pushNamed(
                                      context, FidigamesList.id);
                                }
                              }
                            })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
