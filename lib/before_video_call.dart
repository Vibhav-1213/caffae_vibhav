import 'dart:math';

import 'package:caffae_vibhav/before_video_call.dart';
import 'package:caffae_vibhav/call_page.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:zego_express_engine/zego_express_engine.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'Search.dart';

class BeforeVideoCallPage extends StatefulWidget {
  String guru_name, guru_email, doc_id;
  BeforeVideoCallPage({required this.guru_name, required this.guru_email, required this.doc_id});

  @override
  State<BeforeVideoCallPage> createState() => _BeforeVideoCallPageState();
}

class _BeforeVideoCallPageState extends State<BeforeVideoCallPage> {
  
  final _callIdController = TextEditingController();
  final _GeneratingMeetingIdController = TextEditingController();

  late List<CameraDescription> cameras;
  late CameraController cameraController;
  // int direction = 1;

  String authenticatedEmail = '';

  bool _isPreviewing = false;

  
  String name = '';

  int camera_to_focus_in_video_preview = 1;

  String final_user_name = '';
  String final_user_email = '';

  @override
  void initState(){
    fetchUserName();
    startCamera();
    super.initState();
    // ZegoExpressEngine.instance.setFrontCam(true);
  }

  Future<void> _loaddata() async {
    await Future.delayed(Duration(seconds: 3));
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
            name = querySnapshot.docs.first.get('firstname');
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

  Future<void> startCamera() async {

    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[camera_to_focus_in_video_preview], 
      ResolutionPreset.high,
      enableAudio: false
    );

    await cameraController.initialize().then((value){
      if(!mounted){
        return;
      }
      setState(() {
        _isPreviewing = true;
      });
    }).catchError((e){
      print(e);
    });
  }

  String generateMeetingID(){
    final length = 19;
    final lettersLowerCase = 'abcdefghijklmnopqrstuvwxyz';
    final lettersUpperCase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '0123456789';
    final special = '!@#%^&*';

    String chars = '';
    chars += '$lettersLowerCase$lettersUpperCase';
    chars += '$numbers';
    chars += '$special';

    return List.generate(length, (index){
      final indexRandom = Random().nextInt(chars.length);
    
      return chars[indexRandom];
    }).join('');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(cameraController.value.isInitialized){
      return FutureBuilder(
        future: _loaddata(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: Lottie.asset(
                'images/Meeting.json',
                width: 250,
                height: 250,
                fit: BoxFit.cover
              ),
            );
          } else {
            return DefaultTabController(
          length: 2,
          child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            toolbarHeight: 200,
            flexibleSpace: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 8),
                      child: IconButton(
                        icon: Image.asset('images/back.png', height: 22,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 17.5,
                  ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Text("Meetings", style: TextStyle(color: Colors.white, fontFamily: 'Nagoda', fontSize: 30),),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  color: Color.fromARGB(255, 9, 125, 214),
                  height: 10,
                  thickness: 3,
                ),
                const SizedBox(
                  height: 17.5,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  color: Colors.black,
                  child: TabBar(
                    physics: ClampingScrollPhysics(),
                    // unselectedLabelColor: Color.fromARGB(62, 0, 76, 134),
                    indicatorSize: TabBarIndicatorSize.label,
                    padding: EdgeInsets.symmetric(horizontal: 5,),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.blue
                    ),
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30),),
                            border: Border.all(color: Color.fromARGB(255, 0, 47, 84), width: 1)
                          ),
                          child: Center(
                            child: Text(
                              "Join a meeting",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30),),
                            border: Border.all(color: Color.fromARGB(255, 0, 47, 84), width: 1)
                          ),
                          child: Center(
                            child: Text(
                              "New meeting",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: TabBarView(
              children: [
                Column(
                  children: [
                    Center(
                    child: Container(
                      height: 355.6,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: CameraPreview(cameraController)),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text("Video Preview", 
                    style: TextStyle(
                      color: Color.fromARGB(207, 255, 255, 255), 
                      fontSize: 15.5, 
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 139,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Container(
                            width: 1000,
                            child: TextField(
                              style: TextStyle(color: Colors.white),
                              controller: _callIdController,
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
                              fillColor: Colors.white12,
                              filled: true,
                              hintText: 'Enter Meeting ID',
                              hintStyle: TextStyle(color: Colors.grey[300])
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
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
                              checkUserExists(authenticatedEmail).then((exists){
                              if (exists) {
                                setState(() {
                                  final_user_name = widget.guru_name;
                                  final_user_email = widget.guru_email;
                                });
                              } else {
                                setState(() {
                                  final_user_name = name;
                                  final_user_email = authenticatedEmail;
                                });
                              }
                            });
                            cameraController.dispose();
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            CallPage(callID: _callIdController.text, guru_name_call: final_user_name, guru_email_call: final_user_email, user_id: widget.doc_id,) 
                            )).then((value){
                              initState();
                            });
                            }, child: const Text('Join Meeting', style: TextStyle(color: Colors.white70),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                    child: Container(
                      height: 355.6,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: CameraPreview(cameraController)),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  const Text("Video Preview", 
                    style: TextStyle(
                      color: Color.fromARGB(207, 255, 255, 255), 
                      fontSize: 15.5, 
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 139,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              child: Container(
                                width: 1000,
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  controller: _GeneratingMeetingIdController,
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
                                  fillColor: Colors.white12,
                                  filled: true,
                                  hintText: 'Create Meeting ID',
                                  hintStyle: TextStyle(color: Colors.grey[300])
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 55),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: (){}, 
                                  icon: Image.asset('images/share.png', height: 21.5,)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: (){
                                    Clipboard.setData(ClipboardData(text: _GeneratingMeetingIdController.text));
        
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Copied!')
                                      )
                                    );
                                  }, 
                                  icon: Icon(Icons.copy, color: Colors.white,)
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 33.0),
                          child: Row(
                            children: [
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
                                    final meeting_id = generateMeetingID();
        
                                    _GeneratingMeetingIdController.text = meeting_id;
        
                                  }, child: const Text('Generate Meeting ID', style: TextStyle(color: Colors.white70),),
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
                                  onPressed: () async {
                                    setState(() {
                                      _isPreviewing = false;  
                                    });
                                    checkUserExists(
                                      authenticatedEmail).then((exists){
                                      if (exists) {
                                        setState(() {
                                          final_user_name = widget.guru_name;
                                          final_user_email = widget.guru_email;
                                        });
                                      } else {
                                        setState(() {
                                          final_user_name = name;
                                          final_user_email = authenticatedEmail;
                                        });
                                      }
                                    });
                                    cameraController.dispose();
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                    CallPage(callID: _GeneratingMeetingIdController.text, guru_name_call: final_user_name, guru_email_call: final_user_email, user_id: widget.doc_id,) 
                                    )).then((value){
                                      initState();
                                    });
                                  }, child: const Text('Join', style: TextStyle(color: Colors.white70),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              ]
            ),
          ),
          ),
        );
          };
        },
      );
    } else {
      return const SizedBox();
    }
  }
}