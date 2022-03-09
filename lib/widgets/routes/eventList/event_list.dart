import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'dart:math' as math show pi;

import 'package:web_plan/responsive_layout.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  State<EventList> createState() => _EventList();
}

class _EventList extends State<EventList> {
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

  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('../assets/logoWeb.png');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Search',
        icon: Icons.search,
        onPressed: () => setState(() => _headline = 'Search'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Notifications',
        icon: Icons.notifications,
        onPressed: () => setState(() => _headline = 'Notifications'),
      ),
      CollapsibleItem(
        text: 'Settings',
        icon: Icons.settings,
        onPressed: () => setState(() => _headline = 'Settings'),
      ),
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => setState(() => _headline = 'Home'),
      ),
      CollapsibleItem(
        text: 'Event',
        icon: Icons.event,
        onPressed: () => setState(() => _headline = 'Event'),
      ),
      CollapsibleItem(
        text: 'Email',
        icon: Icons.email,
        onPressed: () => setState(() => _headline = 'Email'),
      ),
      CollapsibleItem(
        text: 'Face',
        icon: Icons.face,
        onPressed: () => setState(() => _headline = 'Face'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
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
        child: CollapsibleSidebar(
          isCollapsed: true,
          items: _items,
          avatarImg: _avatarImg,
          title: 'Dashboard',
          onTitleTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Yay! Flutter Collapsible Sidebar!')));
          },
          body: _body(size, context),
          backgroundColor: Colors.white,
          selectedTextColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: Colors.black,
          ),
          titleStyle: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          // toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
        elevation: 0.0,
        title: const Text(
          'Accueil',
          style: TextStyle(
              fontSize: 35,
              fontFamily: 'Roboto',
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
      body:
          //ResponsiveLayout(
          // mobileBody: MyCustomMobileContent(),
          // desktopBody: MyCustomDesktopContent()),

          Container(
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
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),

            // ---------- Container De l'event ----------
            //
            Container(
              height: 230,
              margin: const EdgeInsets.only(left: 25.0, right: 25.0),
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
                        children: const [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                          ),
                          Text(
                            "Titre de l'event",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black),
                          ),
                        ],
                      ),

                      // ---------- Container des informations de l'event ----------
                      //
                      Container(
                        height: 185,
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
                                  Row(children: const [
                                    Icon(Icons.calendar_today_rounded),
                                    Text(
                                      "25/01/2022",
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ]),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.people_alt),
                                      Text("28",
                                          style: TextStyle(fontSize: 16)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.place),
                                      Text("adresse de l'événement",
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200],
                                    ),
                                    child: Column(
                                      children: const [
                                        Text(
                                          "Ceci est la description de l’événement,  il peut s’agir d’un marché de noel également une brocante organisé par la ville ou encore des fêtes locale.",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.more),
                                        label: const Text("Plus d'infos"),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            const Color.fromRGBO(
                                                140, 140, 140, 1),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      TextButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.check_circle),
                                        label: const Text("S'inscrire"),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            const Color.fromRGBO(3, 110, 20, 1),
                                          ),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
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
            ),
          ],
        ),
      ),

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

// class MyCustomMobileContent extends StatelessWidget {
//   const MyCustomMobileContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.blue);
//   }
// }

// class MyCustomDesktopContent extends StatelessWidget {
//   const MyCustomDesktopContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.red,
//     );
//   }
// }
