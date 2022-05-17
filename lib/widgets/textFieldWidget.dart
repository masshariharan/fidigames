import 'package:fidigames/common/colors/colors.dart';
import 'package:fidigames/common/styles/styles.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField({Key? key, required this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: AppColor.primaryBackgroundColor,
        decoration: textFieldDecoration.copyWith(
          hintText: text,
        ));
  }
}
