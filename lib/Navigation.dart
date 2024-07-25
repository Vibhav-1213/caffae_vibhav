import 'package:caffae_vibhav/Chat.dart';
import 'package:caffae_vibhav/Home.dart';
import 'package:caffae_vibhav/Search.dart';
import 'package:caffae_vibhav/You.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  var pages = [
    HomePage(),
    SearchPage(),
    ChatPage(),
    YouPage(),
  ];
  
  int _selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: Container(  
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.5, vertical: 7),
            child: GNav(
              rippleColor: Color.fromARGB(255, 5, 55, 96),
              hoverColor: Color.fromARGB(255, 22, 118, 198),
              backgroundColor: Colors.black,
              gap: 4.3,
              tabBackgroundColor: Color.fromARGB(255, 2, 53, 95),
              padding: EdgeInsets.all(15),
              tabs: const [
                GButton(icon: Icons.dashboard, text: "Home",iconColor: Colors.white, iconActiveColor: Colors.white,textColor: Colors.white),
                GButton(icon: Icons.search_rounded, text: "Search",iconColor: Colors.white, iconActiveColor: Colors.white,textColor: Colors.white),
                GButton(icon: Icons.chat_rounded, text: "Chats",iconColor: Colors.white, iconActiveColor: Colors.white,textColor: Colors.white),
                GButton(icon: Icons.person, text: "You",iconColor: Colors.white, iconActiveColor: Colors.white, textColor: Colors.white,),
              ],
              selectedIndex: _selectedindex,
              onTabChange: (index){
                setState(() {
                  _selectedindex = index;
                });
              }
            ),
          ),
        ),
        body: pages[_selectedindex]
      );
  }
}