import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fidigames/themes/colors/colors.dart';
import 'package:fidigames/themes/styles/styles.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField(
      {Key? key, this.text, required this.validator, this.controller, this.num})
      : super(key: key);

  final String? text;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? num;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: num,
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
              horizontal: width / 10, vertical: height / 61),
          child: Text(
            text,
            style: buttonTextStyle.copyWith(
                fontSize: textSize * 14, fontWeight: FontWeight.w600),
          ),
        ));
  }
}

class ReusableDropdownButton extends StatefulWidget {
  const ReusableDropdownButton(
      {Key? key, required this.selectedValue, required this.onChanged})
      : super(key: key);

  final String? selectedValue;
  final void Function(String?)? onChanged;

  @override
  State<ReusableDropdownButton> createState() => _ReusableDropdownButtonState();
}

class _ReusableDropdownButtonState extends State<ReusableDropdownButton> {
  final List<String> items = ['AMOUNGUS', 'RACING', 'QUIZ'];

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
      value: widget.selectedValue,
      onChanged: widget.onChanged,
    ));
  }
}

class ReusableCard extends StatefulWidget {
  const ReusableCard(
      {Key? key,
      this.image,
      this.title,
      this.content,
      this.n1,
      this.n2,
      this.likesCount,
      this.iconWidget})
      : super(key: key);

  final Widget? image;
  final String? title;
  final String? content;
  final int? n1;
  final int? n2;
  final int? likesCount;
  // final void Function()? onPressed;
  final Widget? iconWidget;

  @override
  State<ReusableCard> createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: width / 24, top: height / 47, right: width / 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                        height: height / 8.9,
                        width: width / 4.9,
                        child: widget.image),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: width / 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // IconButton(
                      //     onPressed: widget.onPressed,
                      //     icon: Icon(
                      //       Icons.favorite_border,
                      //       size: textSize * 16,
                      //       color: AppColor.primaryTextColor,
                      //     )),
                      widget.iconWidget!,
                      Text(
                        '${widget.likesCount}',
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: textSize * 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    top: height / 47, right: width / 24, bottom: height / 47),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title!,
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: textSize * 18)),
                    SizedBox(height: height / 130),
                    Text(widget.content!,
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
                              side: MaterialStateProperty.all(const BorderSide(
                                  color: AppColor.buttonBackgroundColor)),
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
                              '${widget.n1} - ${widget.n2} Players',
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
  }
}

/// GamesAdd Screen Widgets
class GameCategoryDropdown extends StatefulWidget {
  const GameCategoryDropdown(
      {Key? key, required this.selectedValue, this.onChanged})
      : super(key: key);

  final String? selectedValue;
  final void Function(String?)? onChanged;

  @override
  State<GameCategoryDropdown> createState() => _GameCategoryDropdownState();
}

class _GameCategoryDropdownState extends State<GameCategoryDropdown> {
  List<String> items = ['AMOUNGUS', 'RACING', 'QUIZ'];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);
    return Padding(
      padding: EdgeInsets.only(top: height / 140),
      child: SizedBox(
          width: double.infinity,
          child: DropdownButtonHideUnderline(
              child: DropdownButton2(
            buttonDecoration: BoxDecoration(
              color: AppColor.textFieldBackgrounColor,
              border: Border.all(
                color: AppColor.textFieldBackgrounColor,
                width: 1,
              ), //Border.all
              borderRadius: BorderRadius.circular(10),
            ),
            icon: Padding(
              padding: EdgeInsets.only(right: width / 18),
              child: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.primaryTextColor,
              ),
            ),
            itemHeight: height / 14,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColor.textFieldBackgrounColor,
            ),
            hint: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 18),
              child: Text(
                'Choose the Category of game',
                style: textStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: textSize * 13,
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
            value: widget.selectedValue,
            onChanged: widget.onChanged,
          ))),
    );
  }
}

class ImagesUploadButton extends StatelessWidget {
  const ImagesUploadButton({Key? key, required this.onTap}) : super(key: key);

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);
    return Container(
      height: height / 14,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.textFieldBackgrounColor,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width / 18),
                child: const Icon(
                  Icons.drive_folder_upload,
                  color: AppColor.primaryTextColor,
                ),
              ),
              Text(
                'Upload an Image',
                style: textStyle.copyWith(
                    fontSize: textSize * 13, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CountBox extends StatelessWidget {
  const CountBox({Key? key, required this.controller}) : super(key: key);

  // final String? num;

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);
    return Padding(
      padding: EdgeInsets.only(left: width / 35),
      child: Container(
        height: height / 23,
        width: width / 12,
        decoration: BoxDecoration(
            color: AppColor.textFieldBackgrounColor,
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          cursorColor: AppColor.primaryBackgroundColor,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 6, bottom: 10),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
          style: const TextStyle(
            color: AppColor.primaryTextColor,
          ),
          controller: controller,
          maxLines: 1,
        ),
      ),
    );
  }
}

class CountName extends StatelessWidget {
  const CountName({Key? key, required this.textSize, required this.text})
      : super(key: key);

  final double textSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle.copyWith(
          fontSize: textSize * 13, fontWeight: FontWeight.w400),
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({Key? key, required this.textSize, required this.text})
      : super(key: key);

  final double textSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle.copyWith(
          fontSize: textSize * 12, fontWeight: FontWeight.w400),
    );
  }
}
