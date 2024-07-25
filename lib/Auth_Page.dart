//This page is to check if the user is signed in or not. If the user isn't signed in, 
//we'll re-direct him/her to the login page and if he/she is already signed-in, we'll redirect them to the homepage directly

import 'package:caffae_vibhav/Home.dart';
import 'package:caffae_vibhav/Login_Page.dart';
import 'package:caffae_vibhav/Navigation.dart';
import 'package:caffae_vibhav/first_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          // If user is logged in
          if(snapshot.hasData){
            return NavigationPage();
          }
          // If user isn't loggen in
          else{
            return FirstPage();
          }
        }
      ),
    );
  }
}