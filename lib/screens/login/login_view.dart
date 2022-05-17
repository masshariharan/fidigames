import 'package:fidigames/common/colors/colors.dart';
import 'package:fidigames/common/styles/styles.dart';
import 'package:fidigames/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 93.0,
              ),
              const Text(
                'Fidigames',
                style: TextStyle(
                    color: AppColor.primaryTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 32),
              ),
              const SizedBox(
                height: 123.0,
              ),
              const Text(
                'Log In',
                style: TextStyle(
                    color: AppColor.primaryTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 39.0,
              ),
              const ReusableTextField(
                text: 'Email',
              ),
              const SizedBox(
                height: 20.0,
              ),
              const ReusableTextField(
                text: 'Password',
              ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: buttonStyle,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
