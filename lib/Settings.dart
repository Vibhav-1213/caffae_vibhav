import 'package:caffae_vibhav/Auth_Page.dart';
import 'package:caffae_vibhav/Home.dart';
import 'package:caffae_vibhav/Login_Page.dart';
import 'package:caffae_vibhav/Navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                icon: Icon(Icons.arrow_back_sharp), iconSize: 30,),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 22),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Chivo",
                  fontSize: 25
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _auth.signOut().then((value) => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AuthPage()),
               (route) => false));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8, right: 8),
              child: Container(
                height: 75,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}