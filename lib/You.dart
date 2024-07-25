import 'dart:io';
import 'dart:typed_data';

import 'package:caffae_vibhav/Guru_Form.dart';
import 'package:caffae_vibhav/Guru_Form_Pageview.dart';
import 'package:caffae_vibhav/Settings.dart';
import 'package:caffae_vibhav/Utils.dart';
import 'package:caffae_vibhav/Wallet.dart';
import 'package:caffae_vibhav/add_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

// Youtube link used for Image picker : https://www.youtube.com/watch?v=BjowvNSdWYE 
// Youtube link used for bottom sheet : https://www.youtube.com/watch?v=aEEat94RHLw


class YouPage extends StatefulWidget {
  const YouPage({super.key});

  @override
  State<YouPage> createState() => _YouPageState();
}

class _YouPageState extends State<YouPage> {

  Uint8List? _image;
  String imageUrl = '';
  String User_id = '';

  String Guru_id_you_page = '';

  String User_firstname = '';
  String User_lastname = '';
  String User_email = '';
  String User_image = '';

  List all_Guru_Results = [];
  List showResults = [];

  @override
  void initState(){
    fetchUserName();
    getClientStream();
    super.initState();
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance.collection('Guru_details').get();

    setState(() {
      List all_Guru_Results = data.docs;
    });
  }

  Future selectImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    FirebaseAuth auth_1 = FirebaseAuth.instance;
    FirebaseFirestore firestore_1 = FirebaseFirestore.instance;
    // Uint8List img = await pickImage(ImageSource.gallery); 

    User? user_1 = auth_1.currentUser;

    if(file == null) return;

    // import dart:core
    String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString(); 
    
    // Get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref(); 
    Reference referenceDirImages = referenceRoot.child('Profileimages'); 

    // Create a reference for the image to be stored
    Reference referenceImagetoUpload = referenceDirImages.child(uniqueFilename); 

    for (var clientSnapShot in all_Guru_Results){
      var guru_name_you_page = clientSnapShot['Full Name'].toString().toLowerCase();
      if (guru_name_you_page.contains(User_firstname.toLowerCase())){
        showResults.add(clientSnapShot);
        setState(() {
          Guru_id_you_page = clientSnapShot['Guru_id'].toString();
        });
      }
    }

    try{

      // Store the file
      await referenceImagetoUpload.putFile(File(file!.path));
      // Success: get the download URL
      imageUrl = await referenceImagetoUpload.getDownloadURL();
      await FirebaseFirestore.instance.collection('Users').doc(User_id).update({
        'User_image': imageUrl 
      });
      if(showResults.isNotEmpty){
        await FirebaseFirestore.instance.collection('Guru_details').doc(Guru_id_you_page).update({
          'Guru_image': imageUrl 
        });
      }
      
    } catch (error) {

    }
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
            User_firstname = querySnapshot.docs.first.get('firstname');
            User_lastname = querySnapshot.docs.first.get('lastname');
            User_email = querySnapshot.docs.first.get('email');
            User_id = querySnapshot.docs.first.get('uid');
            User_image = querySnapshot.docs.first.get('User_image');
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

  // Future<bool> updateDocument( String id, Map<String, String> uploadimageurl, String method) async {

  //   bool isErrorOccured = false;
  //   if (method == 'Set Method'){
  //     await FirebaseFirestore.instance.collection('Users').doc(id).set(uploadimageurl).
  //       then((value) => isErrorOccured = false, onError: (err){
  //       isErrorOccured = true;
  //     });
  //     if (isErrorOccured){
  //       return Future.error(isErrorOccured);
  //     }
  //     return Future.value(isErrorOccured);
  //   }

  //   await FirebaseFirestore.instance.collection('Users').doc(id).
  //   update(uploadimageurl).then((value) => isErrorOccured = false, onError: (err){
  //     isErrorOccured = true;
  //   });
  //   if (isErrorOccured){
  //       return Future.error(isErrorOccured);
  //     }
  //     return Future.value(isErrorOccured);
  // }

  // void saveProfile() async {
  //   String resp = await StoreData().saveData(file: _image!);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LiquidPullToRefresh(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
        },
        color: Color.fromARGB(255, 0, 46, 84),
        height: 150,
        backgroundColor: Colors.blue,
        animSpeedFactor: 10,
        showChildOpacityTransition: false,
        child: ListView(
          children: [
            Padding(
            padding: const EdgeInsets.only(left: 300, top: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  }, 
                  icon: Icon(Icons.settings), iconSize: 30,color: Colors.white70,)
              ],
            ),
          ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                                backgroundColor: Color.fromARGB(255, 19, 19, 19),
                                constraints: const BoxConstraints(maxHeight: 250, minWidth: 500),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                                ),
                                context: context, 
                                builder: (context){
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          height: 8,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(5))
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton.icon(
                                            style: TextButton.styleFrom(
                                            ),
                                            onPressed: (){}, 
                                            icon: Image.asset('images/camera.png', height: 30,), 
                                            label: Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Text('Take a photo', style: TextStyle(color: Colors.white, fontSize: 18),),
                                            )
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton.icon(
                                            onPressed: (){
                                              selectImage();
                                              
                                              Navigator.pop(context);
                                            }, 
                                            icon: Image.asset('images/gallery.png', height: 30,), 
                                            label: Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Text('Add image from gallery', style: TextStyle(color: Colors.white, fontSize: 18),),
                                            )
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextButton.icon(
                                            style: TextButton.styleFrom(
                                            ),
                                            onPressed: () async {
                                              await FirebaseFirestore.instance.collection('Users').doc(User_id).update({
                                                'User_image': imageUrl 
                                              });
                                              Navigator.pop(context);
                                            }, 
                                            icon: Image.asset('images/delete.png', height: 30,), 
                                            label: Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: Text('Delete profile photo', style: TextStyle(color: Colors.red, fontSize: 18),),
                                            )
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              );
                          },
                          child: Row(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: 
                                User_image != '' ?
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(User_image),
                                ) : 
                                CircleAvatar(
                                  backgroundColor: Colors.white10,
                                  radius: 40,
                                  child: Container(
                                    child: Center(child: Image.asset('images/Profile_Photo.png', height: 53,)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15.0),
                                child: Container(
                                  height: 60,
                                  width: 235,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        User_firstname + User_lastname, 
                                        style: TextStyle( 
                                          fontSize: 21.5, 
                                          color: Colors.white, 
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      Text(
                                        User_email, 
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle( 
                                          fontSize: 12, 
                                          color: Colors.white, 
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GuruFormPage2()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: AssetImage('images/become_a_guru_2.png'),
                            fit: BoxFit.fill
                          ),
                          //color: Colors.white10,
                        ),
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                  ),
                  Container(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 30,right: 2.5),
                          child: InkWell(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WalletPage()));
                              },
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white10,
                                  image: DecorationImage(image: AssetImage('images/wallet.jpg'), fit: BoxFit.fill)
                                ),
                                child: Wrap(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 9.0, left: 20),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Image.asset("images/coin.png", height: 30,),
                                            Padding(padding: 
                                              EdgeInsets.only(left: 10, top: 10),
                                              child: Text("Wallet", style: TextStyle(color: Colors.white, fontSize: 23, fontFamily: "Nagoda"),),
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
                          padding: const EdgeInsets.only(left: 2.5, top: 30, right: 10),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white10
                              ),
                              // child: Wrap(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Padding(padding: 
                              //           EdgeInsets.only(left: 8, top: 8),
                              //           child: Text("Example"),
                              //         ),
                              //       ],
                              //     )
                              //   ],
                              // ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5, right: 2.5),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white10
                              ),
                              // child: Wrap(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Padding(padding: 
                              //           EdgeInsets.only(left: 8, top: 8),
                              //           child: Text("Example"),
                              //         ),
                              //       ],
                              //     )
                              //   ],
                              // ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.5, top: 5, right: 10),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white10
                              ),
                              // child: Wrap(
                              //   children: [
                              //     Row(
                              //       children: [
                              //         Padding(padding: 
                              //           EdgeInsets.only(left: 8, top: 8),
                              //           child: Text("Example"),
                              //         ),
                              //       ],
                              //     )
                              //   ],
                              // ),
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
      )



          // return Center(
          //   child: Text('Name: $name', style: TextStyle(color: Colors.white, fontSize: 16),),
          // );
    );
  }
}