import 'package:fidigames/api_services/user_login.dart';
import 'package:fidigames/themes/colors/colors.dart';
import 'package:fidigames/themes/styles/styles.dart';
import 'package:fidigames/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textSize = MediaQuery.textScaleFactorOf(context);

    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: height / 8.65,
                ),
                Text(
                  'Fidigames',
                  style: textStyle.copyWith(fontSize: textSize * 32),
                ),
                SizedBox(
                  height: height / 5.83,
                ),
                Text(
                  'Log In',
                  style: textStyle.copyWith(fontSize: textSize * 18),
                ),
                SizedBox(
                  height: height / 18.4,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 18),
                  child: ReusableTextField(
                    text: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: height / 35,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width / 18),
                  child: ReusableTextField(
                    text: 'Password',
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Password';
                      } else if (value.length < 6) {
                        return 'Password must be greater than 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: height / 14.2,
                ),
                ReusableButton(
                    text: 'Sign In',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        apiService.userLogin(
                            emailController.text, passwordController.text);
                      }
                    }),
                SizedBox(
                  height: height / 18,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
