import 'package:caffae_vibhav/before_video_call.dart';
import 'package:caffae_vibhav/call_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'Search.dart';

class GuruProfilePage extends StatefulWidget {
  String guru_name, guru_email, guru_image,  doc_id;
  GuruProfilePage({required this.guru_name, required this.guru_email, required this.guru_image, required this.doc_id});

  @override
  State<GuruProfilePage> createState() => _GuruProfilePageState();
}

class _GuruProfilePageState extends State<GuruProfilePage> with SingleTickerProviderStateMixin{

  final _callIdController = TextEditingController();

  late final AnimationController _lottie_animation_controller;

  String authenticatedEmail = '';

  List<String> Guru_Expertise = [];
  
  String name = '';

  String final_user_name = '';
  String final_user_email = '';

  String Guru_firstname = '';
  String Guru_email = '';
  String Guru_id = '';
  String Guru_image = '';
  String Guru_degree = '';
  String Guru_university = '';
  String Guru_graduation = '';
  String Guru_job = '';
  String Guru_employer = '';
  String Guru_relevant_roles = '';
  String Guru_years_of_experience = '';
  String Guru_entrepreneurship = '';
  String Guru_career_growth = '';
  String Guru_education = '';
  String Guru_technology = '';
  String Guru_finance = '';
  String Guru_health_and_wellness = '';
  String Guru_others = '';
  String Guru_description = '';
  String Guru_Image = '';

  @override
  void initState(){
    fetchGuruName();
    super.initState();
  }

  Future<void> fetchGuruName() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the currently authenticated user
      User? user = auth.currentUser;

      if (user != null) {
        String authenticatedEmail = widget.guru_email!;

        // Query Firestore to find a document with the authenticated email
        QuerySnapshot querySnapshot_image = await firestore
            .collection('Users')  // Replace with your Firestore collection
            .where('Email', isEqualTo: authenticatedEmail)
            .get();

        if(querySnapshot_image.docs.isNotEmpty){
          // Document(s) found with the authenticated email
          setState(() {
            Guru_Image = querySnapshot_image.docs.first.get('User_image');
          });
          
        }

        // Query Firestore to find a document with the authenticated email
        QuerySnapshot querySnapshot = await firestore
            .collection('Guru_details')  // Replace with your Firestore collection
            .where('Email', isEqualTo: authenticatedEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty){
          // Document(s) found with the authenticated email
          setState(() {
            Guru_firstname = querySnapshot.docs.first.get('Full Name');
            Guru_email = querySnapshot.docs.first.get('Email');
            Guru_degree = querySnapshot.docs.first.get('Highest Degree Obtained');
            Guru_university = querySnapshot.docs.first.get('University Name');
            Guru_graduation = querySnapshot.docs.first.get('Year of Graduation');
            Guru_job = querySnapshot.docs.first.get('Current Job Title');
            Guru_employer = querySnapshot.docs.first.get('Current Employer');
            Guru_relevant_roles = querySnapshot.docs.first.get('Previous relevant roles');
            Guru_years_of_experience = querySnapshot.docs.first.get('Total Years of Experience');
            Guru_entrepreneurship = querySnapshot.docs.first.get('Entrepreneurship');
            Guru_career_growth = querySnapshot.docs.first.get('Career Growth');
            Guru_education = querySnapshot.docs.first.get('Education');
            Guru_technology = querySnapshot.docs.first.get('Technology');
            Guru_finance = querySnapshot.docs.first.get('Finance');
            Guru_health_and_wellness = querySnapshot.docs.first.get('Health and Wellness');
            Guru_others = querySnapshot.docs.first.get('Others');
            Guru_description = querySnapshot.docs.first.get('Brief Description of Expertise');

            if (Guru_entrepreneurship == 'Yes'){
              Guru_Expertise.add("Entrepreneurship");
            }
            if (Guru_entrepreneurship == 'Yes'){
              Guru_Expertise.add("Career Growth");
            }
            if (Guru_entrepreneurship == 'Yes'){
              Guru_Expertise.add("Education");
            }
            if (Guru_entrepreneurship == 'Yes'){
              Guru_Expertise.add("Technology");
            }
            if (Guru_entrepreneurship == 'Yes'){
              Guru_Expertise.add("Finance");
            }
            if (Guru_entrepreneurship == 'Yes'){
              Guru_Expertise.add("Health and Wellness");
            }
            if (Guru_entrepreneurship == 'Yes'){
              Guru_Expertise.add("Others");
            }
            // Guru_id = querySnapshot.docs.first.get('uid');
            // Guru_image = querySnapshot.docs.first.get('User_image');
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

  Future<bool> checkUserExists(String userEmail) async {
    try {
      // Query Firestore to check if user document exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users') // Replace with your collection name
          .where('email', isEqualTo: userEmail) // Assuming 'email' is a field in your documents
          .get();

      return querySnapshot.docs.isNotEmpty; // Returns true if user document exists
    } catch (e) {
      print('Error checking user: $e');
      return false; // Return false in case of error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 13, 13),
      body: LiquidPullToRefresh(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        color: Color.fromARGB(255, 0, 46, 84),
        height: 150,
        backgroundColor: Colors.blue,
        animSpeedFactor: 10,
        showChildOpacityTransition: false,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('images/guruprofilebg.png'), fit: BoxFit.cover)
                          ),
                          child: Container(
                            height: 10,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 13, 13, 13),
                                  Colors.transparent
                                ] 
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 11.75, top: 13),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, 
                                  icon: Image.asset('images/back.png', height: 25,)
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 19, top: 130),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              child: widget.guru_image != '' ?
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(widget.guru_image),
                                ) : 
                                CircleAvatar(
                                  backgroundColor: Color.fromARGB(255, 29, 29, 29),
                                  radius: 50,
                                  child: Container(
                                    child: Center(child: Image.asset('images/Profile_Photo.png', height: 53,)),
                                  ),
                                ), 
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 3),
                                shape: BoxShape.circle
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28, top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${widget.guru_name}', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),),
                          // Text('${widget.guru_email}', style: TextStyle(color: Colors.white, fontSize: 15),),
                          // Text('${widget.doc_id}', style: TextStyle(color: Colors.white, fontSize: 15),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Container(
                        height: 50,
                        width: 400,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Container(
                                      height: 41,
                                      width: 120,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(255, 0, 46, 84),
                                          animationDuration: Duration(seconds:2)
                                        ),
                                        onPressed: (){},
                                        child: const Text('Follow', style: TextStyle(color: Colors.white, fontSize: 14),)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromARGB(255, 0, 46, 84),
                                        animationDuration: Duration(seconds: 2)
                                      ),
                                      onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          BeforeVideoCallPage(guru_name: widget.guru_name, guru_email: final_user_email, doc_id: widget.doc_id,) 
                                        ));
                                      },
                                      child: const Text('Schedule a Call', style: TextStyle(color: Colors.white, fontSize: 14),)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Container(
                                      height: 41,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 0, 46, 84),
                                      ),
                                      child: IconButton(
                                        icon: Image.asset("images/vertical_ellipsis.png", height: 21,),
                                        onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            BeforeVideoCallPage(guru_name: widget.guru_name, guru_email: final_user_email, doc_id: widget.doc_id,) 
                                          ));
                                        },
                                                              ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 15),
                            child: Text(
                              'Educational  Background', 
                              style: TextStyle(
                                color: Color.fromARGB(238, 255, 255, 255), 
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                    child: StaggeredGrid.count(
                      crossAxisCount: 1,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                          child: InkWell(
                            child: GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                  backgroundColor: Color.fromARGB(255, 19, 19, 19),
                                  constraints: const BoxConstraints(maxHeight: 450, minWidth: 500),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                  ),
                                  context: context, 
                                  builder: (context){
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(17.0),
                                            child: Container(
                                              height: 8,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5, left: 16),
                                          child: Text('Highest Degree Obtained', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 15, fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                          width: 350,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 16),
                                            child: Text(Guru_degree,
                                              style: TextStyle(
                                                color: Colors.white, 
                                                fontSize: 16, 
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18, left: 13),
                                      child: Image.asset('images/graduation.png', height: 32.5,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 275,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 15.5),
                                              child: Text('Highest Degree Obtained', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 15.5),
                                              child: Text(Guru_degree,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 16, 
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                          child: InkWell(
                            child: GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                  backgroundColor: Color.fromARGB(255, 19, 19, 19),
                                  constraints: const BoxConstraints(maxHeight: 450, minWidth: 500),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                  ),
                                  context: context, 
                                  builder: (context){
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(17.0),
                                            child: Container(
                                              height: 8,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5, left: 16),
                                          child: Text('University Name', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 15, fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                          width: 350,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 16),
                                            child: Text(Guru_university,
                                              style: TextStyle(
                                                color: Colors.white, 
                                                fontSize: 16, 
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18, left: 13),
                                      child: Image.asset('images/university.png', height: 32.5,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 275,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 15.5),
                                              child: Text('University Name', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 15.5),
                                              child: Text(Guru_university,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 16, 
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                          child: InkWell(
                            child: GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                  backgroundColor: Color.fromARGB(255, 19, 19, 19),
                                  constraints: const BoxConstraints(maxHeight: 450, minWidth: 500),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                  ),
                                  context: context, 
                                  builder: (context){
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(17.0),
                                            child: Container(
                                              height: 8,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(5))
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5, left: 16),
                                          child: Text('Year of Graduation', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 15, fontWeight: FontWeight.w500),),
                                        ),
                                        Container(
                                          width: 350,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 16),
                                            child: Text(Guru_graduation,
                                              style: TextStyle(
                                                color: Colors.white, 
                                                fontSize: 16, 
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                );
                              },
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18, left: 13),
                                      child: Image.asset('images/degree.png', height: 32.5,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 275,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 15.5),
                                              child: Text('Year of Graduation', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 15.5),
                                              child: Text(Guru_graduation,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 16, 
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 15),
                            child: Text(
                              'Proffesional Experience', 
                              style: TextStyle(
                                color: Color.fromARGB(238, 255, 255, 255), 
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: StaggeredGrid.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                    backgroundColor: Color.fromARGB(255, 19, 19, 19),
                                    constraints: const BoxConstraints(maxHeight: 450, minWidth: 500),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                    ),
                                    context: context, 
                                    builder: (context){
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(17.0),
                                              child: Container(
                                                height: 8,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 16),
                                            child: Text('Current Job Title', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 15, fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                            width: 350,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text(Guru_job,
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 16, 
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18, left: 13),
                                        child: Image.asset('images/job.png', height: 30,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:5.0),
                                        child: Container(
                                          height: 60,
                                          width: 275,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 16),
                                                child: Text('Current Job Title', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 16),
                                                child: Text(Guru_job,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white, 
                                                    fontSize: 16, 
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                    backgroundColor: Color.fromARGB(255, 19, 19, 19),
                                    constraints: const BoxConstraints(maxHeight: 450, minWidth: 500),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                    ),
                                    context: context, 
                                    builder: (context){
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(17.0),
                                              child: Container(
                                                height: 8,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 16),
                                            child: Text('Current Employer', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 15, fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                            width: 350,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text(Guru_employer,
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 16, 
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18, left: 13),
                                        child: Image.asset('images/boss.png', height: 30,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:5.0),
                                        child: Container(
                                          height: 60,
                                          width: 275,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 16),
                                                child: Text('Current Employer', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 16),
                                                child: Text(Guru_employer,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white, 
                                                    fontSize: 16, 
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                    backgroundColor: Color.fromARGB(255, 19, 19, 19),
                                    constraints: const BoxConstraints(maxHeight: 450, minWidth: 500),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                    ),
                                    context: context, 
                                    builder: (context){
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(17.0),
                                              child: Container(
                                                height: 8,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 16),
                                            child: Text('Previous Relevant Roles', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 15, fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                            width: 350,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text(Guru_relevant_roles,
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 16, 
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18, left: 13),
                                        child: Image.asset('images/roles.png', height: 32.5,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:5.0),
                                        child: Container(
                                          height: 60,
                                          width: 275,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 15.5),
                                                child: Text('Previous Relevant Roles', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 15.5),
                                                child: Text(Guru_relevant_roles,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white, 
                                                    fontSize: 16, 
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                    backgroundColor: Color.fromARGB(255, 19, 19, 19),
                                    constraints: const BoxConstraints(maxHeight: 450, minWidth: 500),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                    ),
                                    context: context, 
                                    builder: (context){
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(17.0),
                                              child: Container(
                                                height: 8,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 16),
                                            child: Text('Total Years of Experience', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 15, fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                            width: 350,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text(Guru_years_of_experience,
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 16, 
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18, left: 13),
                                        child: Image.asset('images/experience.png', height: 33,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:5.0),
                                        child: Container(
                                          height: 60,
                                          width: 275,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 16),
                                                child: Text('Total Years of Experience', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 16),
                                                child: Text(Guru_years_of_experience,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white, 
                                                    fontSize: 16, 
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 15, bottom: 13),
                            child: Text(
                              'Expertise and Domains', 
                              style: TextStyle(
                                color: Color.fromARGB(238, 255, 255, 255), 
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 440,
                      child: Column(
                        children: [
                          Container(
                            height: 350,
                            child: ListView.builder(
                              itemCount: Guru_Expertise.length,
                              itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8, left: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        Guru_Expertise[index], 
                                        style: TextStyle(
                                          color: Colors.white, 
                                          fontSize: 16, 
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: GestureDetector(
                                onTap: (){
                                  showModalBottomSheet(
                                    backgroundColor: Color.fromARGB(255, 19, 19, 19),
                                    constraints: const BoxConstraints(maxHeight: 450, minWidth: 500),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                    ),
                                    context: context, 
                                    builder: (context){
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(17.0),
                                              child: Container(
                                                height: 8,
                                                width: 45,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5, left: 16),
                                            child: Text('Description', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 15, fontWeight: FontWeight.w500),),
                                          ),
                                          Container(
                                            width: 350,
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text(Guru_description,
                                                style: TextStyle(
                                                  color: Colors.white, 
                                                  fontSize: 16, 
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white10,
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 18, left: 14),
                                        child: Image.asset('images/description.png', height: 30,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top:5.0),
                                        child: Container(
                                          height: 60,
                                          width: 275,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 15),
                                                child: Text('Description', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5, left: 16),
                                                child: Text(Guru_description,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: Colors.white, 
                                                    fontSize: 16, 
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 15),
                            child: Text(
                              'Availability and Preferences', 
                              style: TextStyle(
                                color: Color.fromARGB(238, 255, 255, 255), 
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: StaggeredGrid.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 15,right: 5),
                            child: InkWell(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 17, left: 13),
                                      child: Image.asset('images/graduation.png', height: 32.5,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 250,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Current Job Title', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Current Job Title', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18, left: 13),
                                      child: Image.asset('images/university.png', height: 30,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 250,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Current Employer', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Current Employer', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18, left: 13),
                                      child: Image.asset('images/degree.png', height: 30,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 250,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Previous Relevant Roles', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Previous Relevant Roles', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18, left: 13),
                                      child: Image.asset('images/degree.png', height: 30,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 250,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Total Years of Experience', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Total Years of Experience', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25, left: 15),
                            child: Text(
                              'Payment and Rates', 
                              style: TextStyle(
                                color: Color.fromARGB(238, 255, 255, 255), 
                                fontSize: 18,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: StaggeredGrid.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 15,right: 5),
                            child: InkWell(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 17, left: 13),
                                      child: Image.asset('images/graduation.png', height: 32.5,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 250,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Current Job Title', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Current Job Title', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18, left: 13),
                                      child: Image.asset('images/university.png', height: 30,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 250,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Current Employer', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Current Employer', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5),
                            child: InkWell(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18, left: 13),
                                      child: Image.asset('images/degree.png', height: 30,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 250,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Previous Relevant Roles', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Previous Relevant Roles', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10,right: 5, bottom: 20),
                            child: InkWell(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 18, left: 13),
                                      child: Image.asset('images/degree.png', height: 30,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0),
                                      child: Container(
                                        height: 60,
                                        width: 250,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Total Years of Experience', style: TextStyle(color: const Color.fromARGB(191, 255, 255, 255), fontSize: 12, fontWeight: FontWeight.w500),),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5, left: 16),
                                              child: Text('Total Years of Experience', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}