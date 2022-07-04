import 'package:fidigames/screens/fidigames_list.dart';
import 'package:fidigames/screens/games_add_view.dart';
import 'package:fidigames/screens/login/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginView.id,
      routes: {
        LoginView.id: (context) => const LoginView(),
        FidigamesList.id: (context) => const FidigamesList(),
        GamesAddView.id: (context) => const GamesAddView(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Fidigames',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
    );
  }
}
