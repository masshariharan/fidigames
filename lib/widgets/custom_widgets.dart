import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fidigames/themes/colors/colors.dart';
import 'package:fidigames/themes/styles/styles.dart';
import 'package:flutter/material.dart';

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
              horizontal: width / 70, vertical: height / 71),
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
    //double width = MediaQuery.of(context).size.width;
    //double textSize = MediaQuery.textScaleFactorOf(context);
    return Container(
      height: 35,
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.primaryTextColor,
          ),
          borderRadius: BorderRadius.circular(50)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButtonHideUnderline(
              child: DropdownButton2(
            buttonWidth: height / 7.18,
            itemHeight: height / 17.5,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColor.textFieldBackgrounColor,
            ),
            hint: const Text(
              'Categories',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.primaryTextColor,
              ),
            ),
            items: items
                .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColor.primaryTextColor,
                      ),
                    )))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
            },
          ))),
    );
  }
}

class ReusableCard extends StatelessWidget {
  const ReusableCard({Key? key, required this.title, required this.image})
      : super(key: key);

  final String? title;
  final Image? image;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color(0xff292333),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                SizedBox(height: 95, width: 90, child: image),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.favorite,
                      color: Color(0xffFCBC3C),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '240',
                      style: TextStyle(color: Color(0xffFFFFFF)),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Join your crewmates in a\nmultiplayer game of team work',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xffFFFFFF)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            side: MaterialStateProperty.all(
                                const BorderSide(color: Color(0xffFCBC3C))),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff1A121E)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ))),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            Text(
                              'Play',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '4 - 6 Players',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
