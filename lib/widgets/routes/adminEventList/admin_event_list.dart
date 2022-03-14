import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'dart:math' as math show pi;

import 'package:web_plan/responsive_layout.dart';

class AdminEventList extends StatefulWidget {
  const AdminEventList({Key? key}) : super(key: key);

  @override
  State<AdminEventList> createState() => _AdminEventList();
}

class _AdminEventList extends State<AdminEventList> {
  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('');

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
      body: const ResponsiveLayout(
        mobileBody: MyCustomMobileContent(),
        desktopBody: MyCustomDesktopContent(),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///
/// ----------------------------------------------------- Mobile Screen ------------------------------------///

class MyCustomMobileContent extends StatelessWidget {
  const MyCustomMobileContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),

          // ---------- Container De l'event ----------
          //
          Container(
            height: 230,
            margin: const EdgeInsets.only(left: 18.0, right: 18.0),
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
                                    Text("28", style: TextStyle(fontSize: 16)),
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
                                      icon: const Icon(Icons.edit),
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
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      label: const Text("Supprimer"),
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
    );
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///
/// ----------------------------------------------------- Desktop Screen ------------------------------------///

class MyCustomDesktopContent extends StatelessWidget {
  const MyCustomDesktopContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),

          // ---------- Container De l'event ----------
          //
          Container(
            height: 400,
            margin: const EdgeInsets.only(left: 18.0, right: 18.0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 450,
                                  height: 300,
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 100,
                            ),
                            Column(
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const [
                                      Icon(Icons.calendar_today_rounded),
                                      Text(
                                        "25/01/2022",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ]),
                                Row(
                                  children: const [
                                    Icon(Icons.people_alt),
                                    Text("28", style: TextStyle(fontSize: 16)),
                                    Icon(Icons.place),
                                    Text("adresse de l'événement",
                                        style: TextStyle(fontSize: 16)),
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
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    TextButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit),
                                      label: const Text("Gérer"),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 11, 17, 105),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TextButton.icon(
                                      onPressed: () => {},
                                      icon: const Icon(
                                          Icons.remove_circle_outline),
                                      label: const Text("Supprimer"),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              255, 199, 16, 16),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
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
          ),
        ],
      ),
    );
  }
}
