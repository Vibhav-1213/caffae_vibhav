import 'package:caffae_vibhav/Guru_Form_Pageview.dart';
import 'package:caffae_vibhav/Guru_Profile_Page.dart';
import 'package:caffae_vibhav/Wallet.dart';
import 'package:caffae_vibhav/Your_Schedule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late AnimationController _animationControllerhome;
  String name = '';

  List allResults = [];

  @override
  void initState() {
    super.initState();
    fetchUserName();
    _animationControllerhome = AnimationController(
      duration: Duration(seconds: 1, milliseconds: 500),
      vsync: this,
    );
    _animationControllerhome.forward();

    // Call function to fetch name from Firestore
    
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance.collection('Guru_details').orderBy('Full Name').get();

    setState(() {
      allResults = data.docs;
    });
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

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification notification) {
          notification.disallowIndicator();
          return false;
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset('images/homepagebg2.png', fit: BoxFit.fill,),
              ),
              toolbarHeight: 100,
              backgroundColor: Colors.black,
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 1, top: 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 32),
                                      child: Image(image: AssetImage('images/fin.png'), width: 130,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 105, bottom: 50),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Lottie.asset('images/lamp.json', height: 100)),
                                    ),
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(right: 0.0, bottom: 40),
                              //   child: 
                              // ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 45, left: 37),
                                    child: ElevatedButton.icon(
                                      icon: Image.asset('images/coin.png', height: 25,),
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => WalletPage()));
                                      },
                                      label: Text("0", style: TextStyle(color: Colors.white),),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.only(left: 32, bottom: 40),
                                  //   child: Lottie.asset('images/dots.json', height: 90))
                                ],
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
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 0,),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text("Hey", style: TextStyle(fontFamily: "Nagoda", fontSize: 30, color: Colors.white),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(name, style: TextStyle(fontFamily: "Nagoda", fontSize: 30, color: Color.fromARGB(255, 66, 157, 231), fontWeight: FontWeight.w500),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 1.5),
                          child: Text("!", style: TextStyle(fontFamily: "Nagoda", fontSize: 30, color: Colors.white),),
                        ),
                      ],
                    ),
                    SizedBox(height: 14,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left :15),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text("Schedule", style: TextStyle(fontFamily: "Chivo", fontSize: 18, color: Colors.white),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color.fromARGB(255, 205, 232, 255),
                                  shadowColor: Colors.white,
                                ),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SchedulePage()));
                                }, 
                                child: Text("View", style: TextStyle( color: Colors.blue[500], fontSize: 17, fontWeight: FontWeight.w500)),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 9.0, right: 9, top: 0),
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("No meetings as of now.", 
                                style: TextStyle(color: Colors.white70, fontSize: 18, fontFamily: "Chivo"),
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 15.0, top: 20),
                        //   child: Align(
                        //     alignment: Alignment.topLeft,
                        //     child: Text("Recently Contacted", style: TextStyle(fontFamily: "Chivo", fontSize: 18, color: Colors.white70, fontWeight: FontWeight.normal),),
                        //   ),
                        // ),
                        // SizedBox(height: 7,),
                        // Container(
                        //   height: 220,
                        //   child: ListView(
                        //     scrollDirection: Axis.horizontal,
                        //     children: List.generate(5, (index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.only(left: 10.0),
                        //         child: Container(
                        //           width: 140,
                        //           decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(15), color: Colors.white10,
                        //           ),
                        //           child: Padding(
                        //             padding: EdgeInsets.only(top: 22.5),
                        //             child: Align(
                        //               alignment: Alignment.topCenter,
                        //               child: CircleAvatar(
                        //                 backgroundColor: Colors.grey,
                        //                 radius: 50,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       );
                        //     }),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Recommended for You", style: TextStyle(fontFamily: "Chivo", fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal),),
                          ),
                        ),
                        SizedBox(height: 7,),
                        Container(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: 5,
                            itemBuilder: (context, index){
                              return GestureDetector(
                                onTap: (){
                                  Future.delayed(Duration(milliseconds: 200),(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => GuruProfilePage(
                                      guru_name: allResults[index]['Full Name'], 
                                      guru_email: allResults[index]['Email'],
                                      guru_image: allResults[index]['Guru_image'],
                                      doc_id: allResults[index].id,
                                      )
                                    ));
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 3),
                                  child: InkWell(
                                    borderRadius: BorderRadius.all(Radius.circular(13)),
                                    highlightColor: Colors.blue.withOpacity(0.4),
                                    splashColor: Colors.blue.withOpacity(0.4),
                                    child: Container(
                                      width: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15), color: Colors.white10,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 22.5),
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: allResults[index]['Guru_image'] != '' ?
                                                CircleAvatar(
                                                  radius: 40,
                                                  backgroundImage: NetworkImage(allResults[index]['Guru_image']),
                                                ) : 
                                                CircleAvatar(
                                                  backgroundColor: Colors.white10,
                                                  radius: 40,
                                                  child: Container(
                                                    child: Center(child: Image.asset('images/Profile_Photo.png', height: 53,)),
                                                  ),
                                                ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0, top: 17),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Container(
                                                    height: 60,
                                                    width: 190,
                                                    child: Align(
                                                      alignment: Alignment.topCenter,
                                                      child: Text(
                                                        allResults[index]['Full Name'], 
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'Chivo'),
                                                        ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Align(
                                              //   alignment: Alignment.centerLeft,
                                              //   child: Text(
                                              //     resultList[index]['Email'], 
                                              //     style: TextStyle(fontSize: 15, color: Colors.white),
                                              //     ),
                                              // ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          ),
                          // child: ListView(
                          //   scrollDirection: Axis.horizontal,
                          //   children: List.generate(5, (index) {
                          //     return 
                          //   }),
                          // ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, top: 20),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Become a GURU!", style: TextStyle(fontFamily: "Chivo", fontSize: 18, color: Colors.white, fontWeight: FontWeight.normal),),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
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
                                  fit: BoxFit.fitHeight
                                ),
                                //color: Colors.white10,
                              ),
                              width: double.infinity,
                              height: 185,
                            ),
                          ),
                        ),
                        
                        const SizedBox(
                          height: 30,
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
