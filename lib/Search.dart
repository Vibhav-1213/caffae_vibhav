import 'package:caffae_vibhav/Guru_Profile_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

// Youtube link used for search feature : https://www.youtube.com/watch?v=S-8v9nOCUfw&t=11s


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  final indexController = TextEditingController();

  List allResults = [];
  List resultList = [];
  int guru_index = 0;
  int counter_lottie = 0;

  @override
  void initState(){
    searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged(){
    print(searchController.text);
    searchResultList();
  }

  Future<void> _loaddata() async {
    await Future.delayed(Duration(seconds: 1, milliseconds: 200));
  }

  searchResultList(){
    var showResults = [];
    if (searchController.text != ""){
      for (var clientSnapShot in allResults){
        var name = clientSnapShot['Full Name'].toString().toLowerCase();
        if (name.contains(searchController.text.toLowerCase())){
          showResults.add(clientSnapShot);
        }
      }
    } else {
      showResults = List.from(allResults);
    }

    setState(() {
      resultList = showResults;
    });
  }
  
  getClientStream() async {
    var data = await FirebaseFirestore.instance.collection('Guru_details').orderBy('Full Name').get();

    setState(() {
      allResults = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose(){
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    indexController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loaddata(), 
      builder: (BuildContext context, AsyncSnapshot<void> snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Padding(
            padding: EdgeInsets.only(top: 275.0),
            child: Lottie.asset(
              'images/Search.json',
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              toolbarHeight: 85,
              backgroundColor: Colors.black,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: Container(
                  height: 55,
                  child: TextField(
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.bottom,
                            style: TextStyle(color: Colors.white),
                            controller: searchController,
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.white38),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.grey.shade400),
                              ),
                              fillColor: Colors.black,
                              filled: true,
                              prefixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.all(20),
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Colors.grey[800])),
                          ),
                ),
              ),
            ),
            body: LiquidPullToRefresh(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
              },
              color: Color.fromARGB(255, 0, 46, 84),
              height: 150,
              backgroundColor: Colors.blue,
              animSpeedFactor: 10,
              showChildOpacityTransition: true,
              child: SingleChildScrollView(
                child: Container(
                    height: 620,
                    width: double.infinity,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: resultList.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(6.5),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.all(Radius.circular(13)),
                              highlightColor: Colors.blue.withOpacity(0.4),
                              splashColor: Colors.blue.withOpacity(0.4),
                              onTap: (){
                                Future.delayed(Duration(milliseconds: 200),(){
                                  setState(() {
                                    guru_index = index;
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => GuruProfilePage(
                                    guru_name: resultList[index]['Full Name'], 
                                    guru_email: resultList[index]['Email'],
                                    guru_image: resultList[index]['Guru_image'],
                                    doc_id: resultList[index].id,
                                    )
                                  ));
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(13)),
                                  color: Colors.white12,
                                ),
                                height: 90,
                                width: double.infinity,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                                        child: 
                                        resultList[index]['Guru_image'] != '' ?
                                          CircleAvatar(
                                            radius: 33,
                                            backgroundImage: NetworkImage(resultList[index]['Guru_image']),
                                          ) : 
                                          CircleAvatar(
                                            backgroundColor: Colors.white10,
                                            radius: 33,
                                            child: Container(
                                              child: Center(child: Image.asset('images/Profile_Photo.png', height: 53,)),
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
                                                child: Text(
                                                  resultList[index]['Full Name'], 
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Chivo'),
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
                                      Padding(
                                        padding: const EdgeInsets.only(right: 17.5),
                                        child: Image.asset('images/next.png', height: 25,),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ) 
                                    // ListTile(
                          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(13))),
                          //   tileColor: Colors.white24,
                          //   title: Text(resultList[index]['Full Name'], style: TextStyle(fontSize: 15, color: Colors.white),),
                          //   subtitle: Text(resultList[index]['Email'], style: TextStyle(fontSize: 15, color: Colors.white),),
                          // ),
                        );
                      }
                    ),
                  ),
              ),
            )
          );  
        }
      }
    ); 
  }
}