import 'package:fidigames/themes/colors/colors.dart';
import 'package:fidigames/themes/styles/styles.dart';
import 'package:fidigames/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class FidigamesList extends StatefulWidget {
  const FidigamesList({Key? key}) : super(key: key);

  @override
  State<FidigamesList> createState() => _FidigamesListState();
}

class _FidigamesListState extends State<FidigamesList> {
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
          padding: EdgeInsets.symmetric(horizontal: height / 35.8),
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
                  const ReusableDropdownButton(),
                  SizedBox(
                    height: height / 35.8,
                  ),
                  const Expanded(
                    child: ReusableCard(),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height / 14.3),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                        ReusableButton(text: '+ Add Games', onPressed: () {})),
              )
            ],
          ),
        ),
      ),
    );
  }
}
