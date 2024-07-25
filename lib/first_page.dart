import 'package:caffae_vibhav/Login_Page.dart';
import 'package:caffae_vibhav/Register_Page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool showLoginPage = true;

  void togglescreens(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(showRegisterPage: togglescreens);
    } else {
      return RegisterPage(showLoginPage: togglescreens);
    }
  }
}