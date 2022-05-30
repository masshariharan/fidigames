import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fidigames/model/database.dart';
import 'package:fidigames/themes/colors/colors.dart';
import 'package:fidigames/themes/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField(
      {Key? key,
      required this.text,
      required this.validator,
      required this.controller})
      : super(key: key);

  final String? text;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: validator,
        controller: controller,
        style: const TextStyle(color: AppColor.primaryTextColor),
        cursorColor: AppColor.primaryBackgroundColor,
        decoration: textFieldDecoration.copyWith(
          hintText: text,
        ));
  }
}

class ReusableButton extends StatelessWidget {
  const ReusableButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);

    return ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width / 30, vertical: height / 71),
          child: Text(
            text,
            style: buttonTextStyle.copyWith(fontSize: textSize * 14),
          ),
        ));
  }
}

class ReusableDropdownButton extends StatefulWidget {
  const ReusableDropdownButton({Key? key}) : super(key: key);

  @override
  State<ReusableDropdownButton> createState() => _ReusableDropdownButtonState();
}

class _ReusableDropdownButtonState extends State<ReusableDropdownButton> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);
    return DropdownButtonHideUnderline(
        child: DropdownButton2(
      buttonDecoration: BoxDecoration(
        border: Border.all(
          color: AppColor.primaryTextColor,
          width: 1,
        ), //Border.all
        borderRadius: BorderRadius.circular(50),
      ),
      icon: const Padding(
        padding: EdgeInsets.only(right: 20),
        child: Icon(
          Icons.keyboard_arrow_down,
          color: AppColor.primaryTextColor,
        ),
      ),
      itemHeight: height / 17.5,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: AppColor.textFieldBackgrounColor,
      ),
      hint: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 18),
        child: Text(
          'Categories',
          style: textStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: textSize * 12,
            color: AppColor.primaryTextColor,
          ),
        ),
      ),
      items: items
          .map((item) => DropdownMenuItem(
              value: item,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 18),
                child: Text(
                  item,
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: textSize * 12,
                    color: AppColor.primaryTextColor,
                  ),
                ),
              )))
          .toList(),
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value as String;
        });
      },
    ));
  }
}

class ReusableCard extends StatefulWidget {
  const ReusableCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ReusableCard> createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {
  DataBase dataBase = DataBase();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);

    return ListView.builder(
        itemCount: dataBase.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: height / 71),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.textFieldBackgrounColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width / 24,
                            top: height / 47,
                            right: width / 24),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                              height: height / 9.9,
                              width: height / 9.9,
                              child: Image.asset(
                                dataBase.data[index]['image'],
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: width / 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border,
                                  size: textSize * 16,
                                  color: AppColor.primaryTextColor,
                                )),
                            Text(
                              '240',
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontSize: textSize * 12),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height / 47,
                          right: width / 24,
                          bottom: height / 47),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dataBase.data[index]['title'],
                              style: textStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: textSize * 18)),
                          SizedBox(height: height / 130),
                          Text(dataBase.data[index]['content'],
                              maxLines: 2,
                              style: textStyle.copyWith(
                                  fontSize: textSize * 10,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w300)),
                          SizedBox(
                            height: height / 180,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                        const BorderSide(
                                            color: AppColor
                                                .buttonBackgroundColor)),
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColor.buttonTextColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    )),
                                    minimumSize: MaterialStateProperty.all(
                                        const Size(70, 30))),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.play_arrow,
                                      color: AppColor.primaryTextColor,
                                      size: textSize * 17,
                                    ),
                                    Text(
                                      'Play',
                                      style: textStyle.copyWith(
                                          fontSize: textSize * 11,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: width / 18),
                                    child: Icon(
                                      Icons.person,
                                      color: AppColor.primaryTextColor,
                                      size: textSize * 15,
                                    ),
                                  ),
                                  SizedBox(
                                    width: height / 130,
                                  ),
                                  Text(
                                    '4 - 6 Players',
                                    style: textStyle.copyWith(
                                        fontSize: textSize * 12,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
