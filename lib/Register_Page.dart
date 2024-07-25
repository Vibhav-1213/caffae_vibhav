import 'dart:developer';
import 'dart:ffi';

import 'package:caffae_vibhav/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  RegisterPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirstnameController = TextEditingController();
  final LastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  String User_firestore_id_register_page = '';

  Future signUp() async {

    if (passwordconfirmed()){
      // create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim()
      );
      CollectionReference collref = FirebaseFirestore.instance.collection('Users');
      await collref.add({
        'firstname': FirstnameController.text,
        'lastname': LastnameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'confirmpassword': confirmpasswordController.text,
        'User_image': ''
      }).then((DocumentReference doc){
        print("My document id is ${doc.id}");
        collref..doc(doc.id).update({
          'uid': doc.id,
        });
        setState(() {
          User_firestore_id_register_page = doc.id;
        });
      });
    }
  }

  bool passwordconfirmed() {
    if (passwordController.text.trim() == confirmpasswordController.text.trim()){
      return true;
    } else {
      return false;
    }
  }

  @override 
  void dispose(){
    FirstnameController.dispose();
    LastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 12.5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: const Image(image: AssetImage('images/fin.png'), height: 50,)),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: FirstnameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: LastnameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[300])),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: confirmpasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.grey[300])),
                    ),
                  ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: (){
                    signUp();
                    // ZIMKit().connectUser(id: User_firestore_id_register_page , name: FirstnameController.text.trim());
                  },
                  child: Container(
                  height: 67.5,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.5,
                      ),
                    ),
                  ),
                ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent
                  ),
                    onPressed: widget.showLoginPage,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Already a member? Login now!',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Chivo"),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 224,
                ),
              ],
            ),
          ) 
        ),
      ),
    );
  }
}