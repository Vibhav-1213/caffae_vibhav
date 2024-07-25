import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Youtube Link used for animation controllers : https://www.youtube.com/watch?v=k5BDKI7R6ag
// Youtube Link used for file picking : https://www.youtube.com/watch?v=3x92z0oHbtY
// Youtube Link used for pushing data into firestore : https://www.youtube.com/watch?v=COZ67pwhguY

class GuruFormPage2 extends StatefulWidget {
  const GuruFormPage2({super.key});

  @override
  State<GuruFormPage2> createState() => _GuruFormPage2State();
}

class _GuruFormPage2State extends State<GuruFormPage2> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  var filename;
  String User_id = '';
  String Guru_image = '';

  @override
  void initState(){
    super.initState();
    fetchUserName();

    _animationController = AnimationController(
      duration: Duration(seconds: 1, milliseconds: 500),
      vsync: this);

      _animationController.forward();
  }
  
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
            User_id = querySnapshot.docs.first.get('uid');
            Guru_image = querySnapshot.docs.first.get('User_image');
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

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  void openFile(PlatformFile file){
    OpenFile.open(file.path!);
  }
  Map<String, String> Container3 = {};
  Map<String, String> FinalDatatoUpload = {};
  int currentStep = 0;
  bool isCompleted = false;
  bool ischecked1 = false;
  int counter1 = 0;
  int counter2 = 0;
  int counter3 = 0;
  int counter4 = 0;
  int counter5 = 0;
  int counter6 = 0;
  int counter7 = 0;
  int counter8 = 0;
  int counter9 = 0;
  int counter10 = 0;
  int counter11 = 0;
  int counter12 = 0;
  int counter13 = 0;
  int counter14 = 0;
  int counter15 = 0;
  int counter16 = 0;
  int counter17 = 0;
  int counter18 = 0;
  bool ischecked2 = false;
  bool ischecked3 = false;
  bool ischecked4 = false;
  bool ischecked5 = false;
  bool ischecked6 = false;
  bool ischecked7 = false;
  bool ischecked8 = false;
  bool ischecked9 = false;
  bool ischecked10 = false;
  bool ischecked11 = false;
  bool ischecked12 = false;
  bool ischecked13 = false;
  bool ischecked14 = false;
  bool ischecked15 = false;
  bool ischecked16 = false;
  bool ischecked17 = false;
  bool ischecked18 = false;

  
  final guru_full_name_controller = new TextEditingController();
  final guru_email_controller = new TextEditingController();
  final guru_phone_number_controller = new TextEditingController();
  final guru_street_address_controller = new TextEditingController();
  final guru_city_controller = new TextEditingController();
  final guru_state_controller = new TextEditingController();
  final guru_postal_code_controller = new TextEditingController();
  final guru_country_controller = new TextEditingController();
  final guru_linkedin_controller = new TextEditingController();
  final guru_highest_degree_controller = new TextEditingController();
  final guru_university_controller = new TextEditingController();
  final guru_graduation_year_controller = new TextEditingController();
  final guru_current_job_title_controller = new TextEditingController();
  final guru_current_employer_controller = new TextEditingController();
  final guru_prev_roles_controller = new TextEditingController();
  final guru_years_of_experience_controller = new TextEditingController();
  final guru_desc_of_experience_controller = new TextEditingController();
  final guru_certification_controller = new TextEditingController();
  final guru_prof_affliations_controller = new TextEditingController();

  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FadeTransition(
            opacity: _animationController,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/gurupagebg.png'), fit: BoxFit.fill)
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 30),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Image.asset('images/back.png', height: 22,),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Become a GURU!", style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "Chivo"),)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 9, 125, 214),
                      height: 10,
                      thickness: 3,
                    )
                ],
              ),
            ),
          ),
          // Pageview
          Padding(
            padding: const EdgeInsets.only(top: 150.0, bottom: 75),
            child: PageView(
              controller: _controller,
              children: [
                Container(
                  color: Colors.black,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Your Details : ", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Container(
                          width: 1000,
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            controller: guru_full_name_controller,
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
                            hintText: 'Full Name',
                            hintStyle: TextStyle(color: Colors.grey[300])
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_email_controller,
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
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_phone_number_controller,
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
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color: Colors.grey[300])
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Address : ", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_street_address_controller,
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
                            hintText: 'Street Address',
                            hintStyle: TextStyle(color: Colors.grey[300])
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_city_controller,
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
                            hintText: 'City',
                            hintStyle: TextStyle(color: Colors.grey[300])
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_state_controller,
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
                            hintText: 'State',
                            hintStyle: TextStyle(color: Colors.grey[300])
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_postal_code_controller,
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
                            hintText: 'Postal Code',
                            hintStyle: TextStyle(color: Colors.grey[300])
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_country_controller,
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
                            hintText: 'Country',
                            hintStyle: TextStyle(color: Colors.grey[300])
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Your LinkedIn : ", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guru_linkedin_controller,
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
                        hintText: 'LinkedIn Profile URL (Optional)',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Educational Background :", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guru_highest_degree_controller,
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
                        hintText: 'Highest Degree Obtained',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guru_university_controller,
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
                        hintText: 'University/Institute Name',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guru_graduation_year_controller,
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
                        hintText: 'Year of Graduation',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Professional Experience : ", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guru_current_job_title_controller,
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
                        hintText: 'Current Job Title',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guru_current_employer_controller,
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
                        hintText: 'Current Employer',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guru_prev_roles_controller,
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
                        hintText: 'Previous relevant roles',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: guru_years_of_experience_controller,
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
                        hintText: 'Total years of experience',
                        hintStyle: TextStyle(color: Colors.grey[300])
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Expertise and Domains : ", style: TextStyle(color: Colors.grey[200], fontSize: 20),)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked1,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked1 = newbool!;
                                    counter1 += 1;
                                    if (counter1 == 1){
                                      if (ischecked1 == true){
                                        Container3['Entrepreneurship'] = 'Yes';
                                    } 
                                    } else if (counter1 > 1) {
                                      if (ischecked1 == true){
                                        Container3['Entrepreneurship'] = 'Yes';
                                      } else {
                                        Container3.remove('Entrepreneurship');
                                      }
                                    }
                                  });
                                }),
                                Text('Entrepreneurship', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked2,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked2 = newbool!;
                                    counter2 += 1;
                                    if (counter2 == 1){
                                      if (ischecked2 == true){
                                        Container3['Career Growth'] = 'Yes';
                                    } 
                                    } else if (counter2 > 1) {
                                      if (ischecked2 == true){
                                        Container3['Career Growth'] = 'Yes';
                                      } else {
                                        Container3.remove('Career Growth');
                                      }
                                    }
                                  });
                                }),
                                Text('Career Growth', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked3,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked3 = newbool!;
                                    counter3 += 1;
                                    if (counter3 == 1){
                                      if (ischecked3 == true){
                                        Container3['Education'] = 'Yes';
                                    } 
                                    } else if (counter3 > 1) {
                                      if (ischecked3 == true){
                                        Container3['Education'] = 'Yes';
                                      } else {
                                        Container3.remove('Education');
                                      }
                                    }
                                  });
                                }),
                                Text('Education', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked4,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked4 = newbool!;
                                    counter4 += 1;
                                    if (counter4 == 1){
                                      if (ischecked4 == true){
                                        Container3['Technology'] = 'Yes';
                                    } 
                                    } else if (counter4 > 1) {
                                      if (ischecked4 == true){
                                        Container3['Technology'] = 'Yes';
                                      } else {
                                        Container3.remove('Technology');
                                      }
                                    }
                                  });
                                }),
                                Text('Technology', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked5,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked5 = newbool!;
                                    counter5 += 1;
                                    if (counter5 == 1){
                                      if (ischecked5 == true){
                                        Container3['Finance'] = 'Yes';
                                    } 
                                    } else if (counter5 > 1) {
                                      if (ischecked5 == true){
                                        Container3['Finance'] = 'Yes';
                                      } else {
                                        Container3.remove('Finance');
                                      }
                                    }
                                  });
                                }),
                                Text('Finance', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked6,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked6 = newbool!;
                                    counter6 += 1;
                                    if (counter6 == 1){
                                      if (ischecked6 == true){
                                        Container3['Health and Wellness'] = 'Yes';
                                    } 
                                    } else if (counter6 > 1) {
                                      if (ischecked6 == true){
                                        Container3['Health and Wellness'] = 'Yes';
                                      } else {
                                        Container3.remove('Health and Wellness');
                                      }
                                    }
                                  });
                                }),
                                Text('Health and Wellness', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked7,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked7 = newbool!;
                                    counter7 += 1;
                                    if (counter7 == 1){
                                      if (ischecked7 == true){
                                        Container3['Others'] = 'Yes';
                                    } 
                                    } else if (counter7 > 1) {
                                      if (ischecked7 == true){
                                        Container3['Others'] = 'Yes';
                                      } else {
                                        Container3.remove('Others');
                                      }
                                    }
                                  });
                                }),
                                Text('Others (Please Specify)', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_desc_of_experience_controller,
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
                            hintText: 'Brief description of Expertise',
                            hintStyle: TextStyle(color: Colors.grey[300])
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_certification_controller,
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
                            hintText: 'Certifications or Awards',
                            hintStyle: TextStyle(color: Colors.grey[300])
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: guru_prof_affliations_controller,
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
                            hintText: 'Professional Affiliations (if any)',
                            hintStyle: TextStyle(color: Colors.grey[300])
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Availability and Preferences : ", style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'Chivo'),)),
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("1. Preferred Consultation Hours : ", style: TextStyle(color: Colors.grey[200], fontSize: 17),)),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Weekdays : ", style: TextStyle(color: Colors.blue.shade300, fontSize: 15.5, fontFamily: 'Chivo'),)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked8,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked8 = newbool!;
                                    counter8 += 1;
                                    if (counter8 == 1){
                                      if (ischecked8 == true){
                                        Container3['WD_Morning (5:00 am - 12:00 noon)'] = 'Yes';
                                    } 
                                    } else if (counter8 > 1) {
                                      if (ischecked8 == true){
                                        Container3['WD_Morning (5:00 am - 12:00 noon)'] = 'Yes';
                                      } else {
                                        Container3.remove('WD_Morning (5:00 am - 12:00 noon)');
                                      }
                                    }
                                  });
                                }),
                                Text('Morning (5:00 am - 12:00 noon)', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked9,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked9 = newbool!;
                                    counter9 += 1;
                                    if (counter9 == 1){
                                      if (ischecked9 == true){
                                        Container3['WD_Afternoon (12:00 noon - 5:00 pm)'] = 'Yes';
                                    } 
                                    } else if (counter9 > 1) {
                                      if (ischecked9 == true){
                                        Container3['WD_Afternoon (12:00 noon - 5:00 pm)'] = 'Yes';
                                      } else {
                                        Container3.remove('WD_Afternoon (12:00 noon - 5:00 pm)');
                                      }
                                    }
                                  });
                                }),
                                Text('Afternoon (12:00 noon - 5:00 pm)', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked10,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked10 = newbool!;
                                    counter10 += 1;
                                    if (counter10 == 1){
                                      if (ischecked10 == true){
                                        Container3['WD_Evening (5:00 pm - 9:00 pm)'] = 'Yes';
                                    } 
                                    } else if (counter10 > 1) {
                                      if (ischecked10 == true){
                                        Container3['WD_Evening (5:00 pm - 9:00 pm)'] = 'Yes';
                                      } else {
                                        Container3.remove('WD_Evening (5:00 pm - 9:00 pm)');
                                      }
                                    }
                                  });
                                }),
                                Text('Evening (5:00 pm - 9:00 pm)', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked11,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked11 = newbool!;
                                    counter11 += 1;
                                    if (counter11 == 1){
                                      if (ischecked11 == true){
                                        Container3['WD_Night (9:00 pm - 5:00 am)'] = 'Yes';
                                    } 
                                    } else if (counter11 > 1) {
                                      if (ischecked11 == true){
                                        Container3['WD_Night (9:00 pm - 5:00 am)'] = 'Yes';
                                      } else {
                                        Container3.remove('WD_Night (9:00 pm - 5:00 am)');
                                      }
                                    }
                                  });
                                }),
                                Text('Night (9:00 pm - 5:00 am)', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Weekends : ", style: TextStyle(color: Colors.blue.shade300, fontSize: 15.5, fontFamily: 'Chivo'),)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked12,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked12 = newbool!;
                                    counter12 += 1;
                                    if (counter12 == 1){
                                      if (ischecked12 == true){
                                        Container3['WE_Morning (5:00 am - 12:00 noon)'] = 'Yes';
                                    } 
                                    } else if (counter12 > 1) {
                                      if (ischecked12 == true){
                                        Container3['WE_Morning (5:00 am - 12:00 noon)'] = 'Yes';
                                      } else {
                                        Container3.remove('WE_Morning (5:00 am - 12:00 noon)');
                                      }
                                    }
                                  });
                                }),
                                Text('Morning (5:00 am - 12:00 noon)', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked13,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked13 = newbool!;
                                    counter13 += 1;
                                    if (counter13 == 1){
                                      if (ischecked13 == true){
                                        Container3['WE_Afternoon (12:00 noon - 5:00 pm)'] = 'Yes';
                                    } 
                                    } else if (counter13 > 1) {
                                      if (ischecked13 == true){
                                        Container3['WE_Afternoon (12:00 noon - 5:00 pm)'] = 'Yes';
                                      } else {
                                        Container3.remove('WE_Afternoon (12:00 noon - 5:00 pm)');
                                      }
                                    }
                                  });
                                }),
                                Text('Afternoon (12:00 noon - 5:00 pm)', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked14,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked14 = newbool!;
                                    counter14 += 1;
                                    if (counter14 == 1){
                                      if (ischecked14 == true){
                                        Container3['WE_Evening (5:00 pm - 9:00 pm)'] = 'Yes';
                                    } 
                                    } else if (counter14 > 1) {
                                      if (ischecked14 == true){
                                        Container3['WE_Evening (5:00 pm - 9:00 pm)'] = 'Yes';
                                      } else {
                                        Container3.remove('WE_Evening (5:00 pm - 9:00 pm)');
                                      }
                                    }
                                  });
                                }),
                                Text('Evening (5:00 pm - 9:00 pm)', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked15,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked15 = newbool!;
                                    counter15 += 1;
                                    if (counter15 == 1){
                                      if (ischecked15 == true){
                                        Container3['WE_Night (9:00 pm - 5:00 am)'] = 'Yes';
                                    } 
                                    } else if (counter15 > 1) {
                                      if (ischecked15 == true){
                                        Container3['WE_Night (9:00 pm - 5:00 am)'] = 'Yes';
                                      } else {
                                        Container3.remove('WE_Night (9:00 pm - 5:00 am)');
                                      }
                                    }
                                  });
                                }),
                                Text('Night (9:00 pm - 5:00 am)', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Consultation Mode : ", style: TextStyle(color: Colors.blue.shade300, fontSize: 15.5, fontFamily: 'Chivo'),)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked16,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked16 = newbool!;
                                    counter16 += 1;
                                    if (counter16 == 1){
                                      if (ischecked16 == true){
                                        Container3['CM_Video Call'] = 'Yes';
                                    } 
                                    } else if (counter16 > 1) {
                                      if (ischecked16 == true){
                                        Container3['CM_Video Call'] = 'Yes';
                                      } else {
                                        Container3.remove('CM_Video Call');
                                      }
                                    }
                                  });
                                }),
                                Text('Video Call', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked17,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked17 = newbool!;
                                    counter17 += 1;
                                    if (counter17 == 1){
                                      if (ischecked17 == true){
                                        Container3['CM_Voice Call'] = 'Yes';
                                    } 
                                    } else if (counter17 > 1) {
                                      if (ischecked17 == true){
                                        Container3['CM_Voice Call'] = 'Yes';
                                      } else {
                                        Container3.remove('CM_Voice Call');
                                      }
                                    }
                                  });
                                }),
                                Text('Voice Call', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked18,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked18 = newbool!;
                                    counter18 += 1;
                                    if (counter18 == 1){
                                      if (ischecked18 == true){
                                        Container3['CM_Chatting'] = 'Yes';
                                    } 
                                    } else if (counter18 > 1) {
                                      if (ischecked18 == true){
                                        Container3['CM_Chatting'] = 'Yes';
                                      } else {
                                        Container3.remove('CM_Chatting');
                                      }
                                    }
                                  });
                                }),
                                Text('Chatting', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Preferred language : ", style: TextStyle(color: Colors.blue.shade300, fontSize: 15.5, fontFamily: 'Chivo'),)),
                      ),
                    ]
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Payment and Rates : ", style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'Chivo'),)),
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("1. Charge per minute : ", style: TextStyle(color: Colors.grey[200], fontSize: 17),)),
                      ),
                    ]
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Document Verification : ", style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'Chivo'),)),
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("1. Upload the following documents: ", style: TextStyle(color: Colors.grey[200], fontSize: 17),)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Upload ID proof : ", style: TextStyle(color: Colors.blue.shade300, fontSize: 15.5, fontFamily: 'Chivo'),)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0, right: 9),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      backgroundColor: Color.fromARGB(62, 0, 76, 134)
                                    ),
                                    onPressed: () async {
                                      final result = await FilePicker.platform.pickFiles();
                                      if (result == null) return;
                              
                                      // Open single file
                                      final file = result.files.first;
                                      openFile(file);
                              
                                      filename = file.name;
                                      print( 'Name: ${file.name}');
                                      print( 'Bytes: ${file.bytes}');
                                      print( 'Size: ${file.size}');
                                      print( 'Extension: ${file.extension}');
                                      print( 'Path: ${file.path}');
                                    }, 
                                    child: Text('Upload', style: TextStyle(color: Color.fromARGB(255, 9, 125, 214)),)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Upload professional Certificates (if any) : ", style: TextStyle(color: Colors.blue.shade300, fontSize: 15.5, fontFamily: 'Chivo'),)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 9),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  backgroundColor: Color.fromARGB(62, 0, 76, 134)
                                ),
                                onPressed: (){}, 
                                child: Text('Upload', style: TextStyle(color: Color.fromARGB(255, 9, 125, 214)),)
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Upload a recent photograph : ", style: TextStyle(color: Colors.blue.shade300, fontSize: 15.5, fontFamily: 'Chivo'),)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 9),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  backgroundColor: Color.fromARGB(62, 0, 76, 134)
                                ),
                                onPressed: (){}, 
                                child: Text('Upload', style: TextStyle(color: Color.fromARGB(255, 9, 125, 214)),)
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Video verification : ", style: TextStyle(color: Colors.blue.shade300, fontSize: 15.5, fontFamily: 'Chivo'),)),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 9),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  backgroundColor: Color.fromARGB(62, 0, 76, 134)
                                ),
                                onPressed: (){}, 
                                child: Text('Upload', style: TextStyle(color: Color.fromARGB(255, 9, 125, 214)),)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                ),
                Container(
                  color: Colors.black,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Agreement : ", style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'Chivo'),)),
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("1. Terms and Conditions : ", style: TextStyle(color: Colors.grey[200], fontSize: 17),)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                value: ischecked1,
                                activeColor: Colors.blue, 
                                onChanged: (newbool){
                                  setState(() {
                                    ischecked1 = newbool!;
                                  });
                                }),
                                Text('I agree to the T&Cs of Caffae', style: TextStyle(color: Colors.white, fontSize: 15),)
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                       Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("2. Your Signature : ", style: TextStyle(color: Colors.grey[200], fontSize: 17),)),
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
          // Dot indicators
          Container(
            alignment: Alignment(0, 0.96),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7.0, right: 2),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      backgroundColor: Color.fromARGB(62, 0, 76, 134)
                    ),
                    onPressed: (){
                      _controller.previousPage(
                        duration: Duration(milliseconds: 500), 
                        curve: Curves.easeIn
                      );
                      currentStep -= 1; 
                    }, 
                    child: Text('Back', style: TextStyle(color: Color.fromARGB(255, 9, 125, 214)),)
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller, 
                  count: 7,
                  effect: const SlideEffect(
                    activeDotColor: Color.fromARGB(255, 9, 125, 214),
                    dotHeight: 15,
                    dotWidth: 15,
                    // To find out the style of movement of the dot
                    dotColor: Colors.grey
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7.0, left: 3),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      backgroundColor: Color.fromARGB(62, 0, 76, 134)
                    ),
                    onPressed: (){
                      final isLastStep = currentStep == 6;
                      if (isLastStep){
                      setState(() {
                        isCompleted = true;
                      Map<String,String> dataToSave = {
                        "User_id": User_id,
                        "Guru_image" : Guru_image,
                        "Full Name" : guru_full_name_controller.text.trim(),
                        "Email" : guru_email_controller.text.trim(),
                        "Phone Number" : guru_phone_number_controller.text.trim(),
                        "Street Address" : guru_street_address_controller.text.trim(),
                        "City" : guru_city_controller.text.trim(),
                        "State" : guru_state_controller.text.trim(),
                        "Postal Code" : guru_postal_code_controller.text.trim(),
                        "Country" : guru_country_controller.text.trim(),
                        "LinkedIn" : guru_linkedin_controller.text.trim(),
                        "Highest Degree Obtained" : guru_highest_degree_controller.text.trim(),
                        "University Name" : guru_university_controller.text.trim(),
                        "Year of Graduation" : guru_graduation_year_controller.text.trim(),
                        "Current Job Title" : guru_current_job_title_controller.text.trim(),
                        "Current Employer" : guru_current_employer_controller.text.trim(),
                        "Previous relevant roles" : guru_prev_roles_controller.text.trim(),
                        "Total Years of Experience" : guru_years_of_experience_controller.text.trim(),
                        "Brief Description of Expertise" : guru_desc_of_experience_controller.text.trim(),
                        "Certifications or Awards" : guru_certification_controller.text.trim(),
                        "Proffesional Affliations" : guru_prof_affliations_controller.text.trim(),
                      };
                      FinalDatatoUpload.addAll(dataToSave);
                      FinalDatatoUpload.addAll(Container3);
                        FirebaseFirestore.instance.collection('Guru_details').add(FinalDatatoUpload).
                          then((DocumentReference doc){
                            FirebaseFirestore.instance.collection('Guru_details')..doc(doc.id).update({"Guru_id": doc.id});
                          });
                        Navigator.pop(context);
                        print(Container3);
                      },
                      );
                      print('Complete');
                    } else {
                    setState(() {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500), 
                        curve: Curves.easeIn
                      );
                      currentStep += 1; 
                    });
                    }
                    }, 
                    child: Text(currentStep == 6 ? 'Confirm' : 'Next', style: TextStyle(color: Color.fromARGB(255, 9, 125, 214)),)
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}