import 'package:caffae_vibhav/Chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String User_Chat_Name = '';
  String User_Chat_ID = '';

  Future<void> fetchUserName() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the currently authenticated user
      User? user = auth.currentUser;

      if (user != null) {
        String authenticatedEmail = user.email!;

        // Query Firestore to find a document with the authenticated email
        QuerySnapshot querySnapshot = await firestore
            .collection('Users')  // Replace with your Firestore collection
            .where('email', isEqualTo: authenticatedEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Document(s) found with the authenticated email
          setState(() {
            User_Chat_Name = querySnapshot.docs.first.get('firstname');
            User_Chat_ID = querySnapshot.docs.first.get('uid');
          });
        } else {
          // No document found with the authenticated email
          print('No document found with email: $authenticatedEmail');
        }
      } else {
        // User is not authenticated or user is null
        print('User is not authenticated.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  void signUserIn() async {

    showDialog(
      context: context, 
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      });

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text
    );
      fetchUserName();
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found'){
        wrongEmailMessage();
      } else if (e.code == 'wrong-password'){
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage(){
    showDialog(
      context: context, 
      builder: (context){
        return const AlertDialog(
          title: Text("Incorrect Email"),
        );
      }
    );
  }

  void wrongPasswordMessage(){
    showDialog(
      context: context, 
      builder: (context){
        return const AlertDialog(
          title: Text("Incorrect Password"),
        );
      }
    );
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/loginpagebg.png'), fit: BoxFit.cover)
            ),
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
                    height: 160,
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
                    height: 20,
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
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white24,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[300])),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                GestureDetector(
                  onTap: (){
                    signUserIn();
                    // ZIMKit().connectUser(id: User_Chat_ID , name: User_Chat_Name);
                  },
                  child: Container(
                  height: 62.5,
                  margin: const EdgeInsets.symmetric(horizontal: 27),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.5,
                      ),
                    ),
                  ),
                ),),
                const SizedBox(
                    height: 30,
                  ),
                GestureDetector(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[400], fontSize: 18, fontFamily: "Chivo"),
                    ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent
                  ),
                    onPressed: widget.showRegisterPage,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'New to Caffae? Sign up now!',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Chivo"),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ) 
                ),
        ),
    );
  }
}