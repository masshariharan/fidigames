import 'package:fidigames/api_services/user_login.dart';
import 'package:fidigames/screens/fidigames_list.dart';
import 'package:fidigames/themes/colors/colors.dart';
import 'package:fidigames/themes/styles/styles.dart';
import 'package:fidigames/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const String id = 'Login_screen';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  ApiService apiService = ApiService();

  String? token;
  @override
  void initState() {
    super.initState();
    userLoggedIn();
  }

  Future<void> userLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //token = prefs.getString('token')!;

    if (prefs.getString('token') != null) {
      // Navigator.pushNamed(context, FidigamesList.id);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => FidigamesList()));
    }
  }

  Future login(String email, String password) async {
    try {
      await apiService.userLogin(emailController.text, passwordController.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => FidigamesList()));
    } catch (error) {
      if (error.toString() == "type 'Null' is not a subtype of type 'String'" ||
          error.toString() ==
              "Expected a value of type 'String', but got one of type 'Null'") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: AppColor.primaryTextColor,
            content: Text(
              'Wrong Password',
              style: TextStyle(color: AppColor.buttonBackgroundColor),
            )));
      }
    }
  }

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
                
                CustomText(textSize: textSize*32, text: 'Fidigames'),
                SizedBox(
                  height: height / 5.83,
                ),
              
                CustomText(textSize: textSize* 18, text: 'Log In'),
                
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await login(
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
