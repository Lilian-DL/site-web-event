// AdminEventList

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'dart:math' as math show pi;

import 'package:web_plan/responsive_layout.dart';

import '../../slideBar/slide_Bar.dart';

class AdminEventList extends StatefulWidget {
  const AdminEventList({Key? key}) : super(key: key);

  @override
  State<AdminEventList> createState() => _AdminEventList();
}

class _AdminEventList extends State<AdminEventList> {
  // int _selectedIndex = 0;
  // // static const TextStyle optionStyle =
  // //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  //   if (index == 1) {
  //     Navigator.pushReplacement(
  //         // à remplacer par la page "mes participations"
  //         context,
  //         MaterialPageRoute(builder: (context) => ParticipationPage()));
  //   }
  //   if (index == 2) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => ProfilePage()));
  //   }
  // }

  late String _headline;
  AssetImage _avatarImg = AssetImage('../assets/logoWeb.png');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
        elevation: 0.0,
        title: const Text(
          'Accueil :',
          style: TextStyle(
              fontSize: 35,
              fontFamily: 'Roboto',
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(36, 45, 165, 1),
                Color.fromRGBO(39, 50, 207, 1),
                Color.fromRGBO(13, 19, 102, 1)
              ]),
        ),
        child: Row(
          children: <Widget>[
            Container(
                constraints: const BoxConstraints(
                  maxWidth: double.infinity,
                  minWidth: 100,
                ),
                // color : Colors.green,
                child: SlideBar()),
            Expanded(
              flex: 1,
              child: Container(
                alignment: const FractionalOffset(0.3, 0.4),
                // color : Colors.purple,
                height: MediaQuery.of(context).size.height * 1.0,
                // child: Padding(
                // padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: _body(size, context),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 500.0,
        minWidth: 500.0,
        maxHeight: 800.0,
        maxWidth: 10000,
      ),

      child: const ResponsiveLayout(
          mobileBody: MyCustomMobileContent(),
          desktopBody: MyCustomDesktopContent()),

      //---------- Le footer de l'appli ----------
      //
      //
      // bottomNavigationBar: BottomNavigationBar(
      //   // backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
      //   iconSize: 30,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home_rounded,
      //         // color: Colors.white,
      //       ),
      //       label: 'Accueil',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.check_circle,
      //         // color: Colors.white,
      //       ),
      //       label: 'Mes participations',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.account_circle_rounded,
      //         // color: Colors.white,
      //       ),
      //       label: 'Mon compte',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: const Color.fromARGB(255, 0, 110, 255),
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

class MyCustomMobileContent extends StatelessWidget {
  const MyCustomMobileContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _events =
        FirebaseFirestore.instance.collection('Event');
    return StreamBuilder(
        stream: _events.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> Streamsnapshot) {
          if (Streamsnapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (Streamsnapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(36, 45, 165, 1),
                      Color.fromRGBO(39, 50, 207, 1),
                      Color.fromRGBO(13, 19, 102, 1)
                    ]),
              ),
              child: ListView.builder(
                  itemCount: Streamsnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // ---------- Container De l'event ----------
                    final DocumentSnapshot documentSnapshot =
                        Streamsnapshot.data!.docs[index];
                    return Container(
                      height: 260,
                      margin: const EdgeInsets.only(
                          left: 25.0, right: 25.0, top: 25, bottom: 15),
                      padding: const EdgeInsets.only(
                        top: 2,
                        bottom: 2,
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              spreadRadius: 5,
                              blurRadius: 29,
                              offset: Offset(0, 0))
                        ],
                      ),
                      child: Column(children: [
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.black,
                                  ),
                                  Text(
                                    "${documentSnapshot['Title']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                ],
                              ),

                              // ---------- Container des informations de l'event ----------
                              //
                              Container(
                                height: 225,
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(
                                    top: 2, left: 5, right: 5, bottom: 2),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Row(children: [
                                            const Icon(
                                                Icons.calendar_today_rounded),
                                            Text(
                                              " ${documentSnapshot['Date'].toDate().toString().split(" ")[0]}",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            )
                                          ]),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.people_alt),
                                              Text(
                                                  " ${documentSnapshot['Users'].length}/${documentSnapshot['PeopleLimit']}",
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(Icons.place),
                                              Text(
                                                  "${documentSnapshot['Location']}",
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey[200],
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${documentSnapshot['Description']}",
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton.icon(
                                                onPressed: () {
                                                  print(documentSnapshot.id);
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/event/edit',
                                                    arguments:
                                                        documentSnapshot.id,
                                                  );
                                                },
                                                icon: const Icon(Icons.edit),
                                                label: const Text("Gérer"),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    const Color.fromARGB(
                                                        255, 11, 17, 105),
                                                  ),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              TextButton.icon(
                                                onPressed: () {},
                                                icon: const Icon(Icons
                                                    .remove_circle_outline),
                                                label: const Text("Supprimer"),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    const Color.fromARGB(
                                                        255, 199, 16, 16),
                                                  ),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                    );
                  }),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}

class MyCustomDesktopContent extends StatelessWidget {
  const MyCustomDesktopContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference _events =
        FirebaseFirestore.instance.collection('Event');
    return StreamBuilder(
        stream: _events.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> Streamsnapshot) {
          if (Streamsnapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (Streamsnapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(36, 45, 165, 1),
                      Color.fromRGBO(39, 50, 207, 1),
                      Color.fromRGBO(13, 19, 102, 1)
                    ]),
              ),
              child: ListView.builder(
                  itemCount: Streamsnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // ---------- Container De l'event ----------
                    final DocumentSnapshot documentSnapshot =
                        Streamsnapshot.data!.docs[index];
                    // ---------- Container De l'event ----------
                    //
                    return Container(
                      height: 400,
                      margin: const EdgeInsets.only(
                          left: 18.0, right: 18.0, top: 25, bottom: 15),
                      padding: const EdgeInsets.only(
                        top: 2,
                        bottom: 2,
                      ),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              spreadRadius: 5,
                              blurRadius: 29,
                              offset: Offset(0, 0))
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "${documentSnapshot['Title']}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),

                                // ---------- Container des informations de l'event ----------
                                //
                                Container(
                                  height: 350,
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(
                                      top: 2, left: 5, right: 5, bottom: 2),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 450,
                                            height: 300,
                                            decoration: const BoxDecoration(
                                                color: Colors.black),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.calendar_today_rounded),
                                              Text(
                                                " ${documentSnapshot['Date'].toDate().toString().split(" ")[0]}",
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(Icons.people_alt),
                                              Text(
                                                  " ${documentSnapshot['Users'].length}/${documentSnapshot['PeopleLimit']}",
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(Icons.place),
                                              Text(
                                                  "${documentSnapshot['Location']}",
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                width: 400,
                                                height: 150,
                                                margin: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 50,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.grey[200],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "${documentSnapshot['Description']}",
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton.icon(
                                                onPressed: () {
                                                  print(documentSnapshot.id);
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/event/edit',
                                                    arguments:
                                                        documentSnapshot.id,
                                                  );
                                                },
                                                icon: const Icon(Icons.edit),
                                                label: const Text("Gérer"),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    const Color.fromARGB(
                                                        255, 11, 17, 105),
                                                  ),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              TextButton.icon(
                                                onPressed: () {},
                                                icon: const Icon(Icons
                                                    .remove_circle_outline),
                                                label: const Text("Supprimer"),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    const Color.fromARGB(
                                                        255, 199, 16, 16),
                                                  ),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}

Future<void> deleteEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance
      .collection('Event')
      .doc(result!.uid)
      .collection('MyEvent');
  return users
      .doc(idEvent)
      .delete()
      .then((value) => print("IdEvent delete"))
      .catchError((error) => print("Failed to delete : $error"));
}
