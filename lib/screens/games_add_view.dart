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
                  Text(
                    'Name of the Game',
                    style: textStyle.copyWith(
                        fontSize: textSize * 12, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height / 140,
                    ),
                    child: SizedBox(
                        height: height / 14,
                        child: ReusableTextField(
                          controller: gameNameController,
                          num: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter the Game Name';
                            }
                            return null;
                          },
                        )),
                  ),
                  SizedBox(
                    height: height / 29,
                  ),
                  Text(
                    'Description',
                    style: textStyle.copyWith(
                        fontSize: textSize * 12, fontWeight: FontWeight.w400),
                  ),
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
                  Text(
                    'Game URL',
                    style: textStyle.copyWith(
                        fontSize: textSize * 12, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height / 140,
                    ),
                    child: SizedBox(
                        height: height / 14,
                        child: ReusableTextField(
                          controller: gameURLController,
                          num: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required Game URL';
                            }
                            return null;
                          },
                        )),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Text(
                    'Image URL',
                    style: textStyle.copyWith(
                        fontSize: textSize * 12, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: height / 140,
                    ),
                    child: SizedBox(
                        height: height / 14,
                        child: ReusableTextField(
                          controller: imageURLController,
                          num: 1,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required Image URL';
                            }
                            return null;
                          },
                        )),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Text(
                    'Players Count',
                    style: textStyle.copyWith(
                        fontSize: textSize * 12, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 36),
                    child: Row(
                      children: [
                        Text(
                          'Minimum Count',
                          style: textStyle.copyWith(
                              fontSize: textSize * 13,
                              fontWeight: FontWeight.w400),
                        ),
                        CountBox(
                          controller: minCountController,
                        ),
                        SizedBox(
                          width: width / 15,
                        ),
                        Text(
                          'Miximum Count',
                          style: textStyle.copyWith(
                              fontSize: textSize * 13,
                              fontWeight: FontWeight.w400),
                        ),
                        CountBox(
                          controller: maxCountController,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 20,
                  ),
                  Text(
                    'Category',
                    style: textStyle.copyWith(
                        fontSize: textSize * 12, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: height / 14,
                    child: GameCategoryDropdown(
                      selectedValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                    ),
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
                                  // _showGameAddCard(context);

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

// _getFromGallery() async {
//   XFile? pickedFile = await ImagePicker().pickImage(
//     source: ImageSource.gallery,
//   );
//   if (pickedFile != null) {
//     setState(() {
//       imageFile = File(pickedFile.path);

//       image = imageFile!.path;

//       Logger().wtf(image);
//     });
//   }
// }

// Future<void> _showGameAddCard(BuildContext context) async {
//   return showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//             backgroundColor: AppColor.textFieldBackgrounColor,
//             contentPadding: const EdgeInsets.all(0),
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10))),
//             content: Builder(
//               builder: (context) {
//                 // Get available height and width of the build area of this widget. Make a choice depending on the size.
//                 var height = MediaQuery.of(context).size.height;
//                 var width = MediaQuery.of(context).size.width;

//                 double textSize = MediaQuery.textScaleFactorOf(context);
//                 return SizedBox(
//                   height: 160,
//                   width: double.infinity,
//                   child: Column(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     left: width / 24,
//                                     top: height / 47,
//                                     right: width / 24),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   // child: SizedBox(
//                                   //     height: height / 9.9,
//                                   //     width: height / 9.9,
//                                   //     child: Image.file(
//                                   //       imageFile!,
//                                   //       fit: BoxFit.cover,
//                                   //     )
//                                   //     ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Expanded(
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                   top: height / 47,
//                                   right: width / 24,
//                                   bottom: height / 47),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(gameNameController.text,
//                                       style: textStyle.copyWith(
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: textSize * 18)),
//                                   SizedBox(height: height / 130),
//                                   Text(descriptionController.text,
//                                       maxLines: 2,
//                                       style: textStyle.copyWith(
//                                           fontSize: textSize * 10,
//                                           fontStyle: FontStyle.normal,
//                                           fontWeight: FontWeight.w300)),
//                                   SizedBox(
//                                     height: height / 180,
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.start,
//                                     children: [
//                                       Icon(
//                                         Icons.person,
//                                         color: AppColor.primaryTextColor,
//                                         size: textSize * 15,
//                                       ),
//                                       SizedBox(
//                                         width: height / 130,
//                                       ),
//                                       Text(
//                                         '4 - 6 Players',
//                                         style: textStyle.copyWith(
//                                             fontSize: textSize * 12,
//                                             fontWeight: FontWeight.w300),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ElevatedButton(
//                               onPressed: () {},
//                               style: ButtonStyle(
//                                   side: MaterialStateProperty.all(
//                                       const BorderSide(
//                                           color: AppColor
//                                               .buttonBackgroundColor)),
//                                   backgroundColor: MaterialStateProperty.all(
//                                       AppColor.primaryBackgroundColor),
//                                   shape: MaterialStateProperty.all<
//                                           RoundedRectangleBorder>(
//                                       RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30),
//                                   )),
//                                   minimumSize: MaterialStateProperty.all(
//                                       const Size(40, 30))),
//                               child: Text(
//                                 'Decline',
//                                 style: textStyle.copyWith(
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 14,
//                                     color: AppColor.buttonBackgroundColor),
//                               )),
//                           ElevatedButton(
//                             onPressed: () {},
//                             style: ButtonStyle(
//                                 side: MaterialStateProperty.all(
//                                     const BorderSide(
//                                         color:
//                                             AppColor.buttonBackgroundColor)),
//                                 backgroundColor: MaterialStateProperty.all(
//                                     AppColor.primaryBackgroundColor),
//                                 shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 )),
//                                 minimumSize: MaterialStateProperty.all(
//                                     const Size(40, 30))),
//                             child: Text(
//                               'Accept',
//                               style: textStyle.copyWith(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 14,
//                                   color: AppColor.buttonBackgroundColor),
//                             ),
//                           ),
//                           ElevatedButton(
//                             onPressed: () {},
//                             style: ButtonStyle(
//                                 side: MaterialStateProperty.all(
//                                     const BorderSide(
//                                         color:
//                                             AppColor.buttonBackgroundColor)),
//                                 backgroundColor: MaterialStateProperty.all(
//                                     AppColor.primaryBackgroundColor),
//                                 shape: MaterialStateProperty.all<
//                                         RoundedRectangleBorder>(
//                                     RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                 )),
//                                 minimumSize: MaterialStateProperty.all(
//                                     const Size(10, 30))),
//                             child: Text(
//                               'Edit',
//                               style: textStyle.copyWith(
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 14,
//                                   color: AppColor.buttonBackgroundColor),
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ));
// }

// SizedBox(
//   height: height / 20,
// ),
// imageFile == null
//     ? ImagesUploadButton(
//         onTap: () {
//           _getFromGallery();
//         },
//       )
//     : SizedBox(
//         height: height / 9,
//         width: width / 4,
//         child: Image.file(
//           imageFile!,
//           fit: BoxFit.cover,
//         ),
//       ),
