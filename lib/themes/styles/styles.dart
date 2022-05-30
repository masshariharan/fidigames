import 'package:flutter/material.dart';

import '../colors/colors.dart';

final textFieldDecoration = InputDecoration(
    fillColor: const Color(0xff292333),
    filled: true,
    hintStyle: const TextStyle(fontSize: 14.0, color: Colors.white),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColor.primaryBackgroundColor)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColor.primaryBackgroundColor)));

final buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(AppColor.buttonBackgroundColor),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    )));

const textStyle = TextStyle(
  fontFamily: 'Poppins',
  color: AppColor.primaryTextColor,
  fontWeight: FontWeight.w600,
);

const buttonTextStyle = TextStyle(
  color: AppColor.buttonTextColor,
  fontWeight: FontWeight.w600,
);
