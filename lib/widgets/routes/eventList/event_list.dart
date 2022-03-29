import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_plan/responsive_layout.dart';
import 'package:web_plan/services/auth.dart';
import 'package:web_plan/widgets/routes/adminCreateEvent/admin_create_event.dart';
import 'package:web_plan/widgets/routes/adminEventList/admin_event_list.dart';
import 'package:web_plan/widgets/routes/menuConnexion/menu_connexion.dart';
import 'package:web_plan/widgets/routes/participationsPage/participations_page.dart';
import 'package:web_plan/widgets/routes/profilePage/profile_page.dart';

class EventList extends StatefulWidget {
  const EventList({Key? key}) : super(key: key);

  @override
  State<EventList> createState() => _EventList();
}

class _EventList extends State<EventList> {
  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('../assets/logoWeb.png');
  final AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  @override
  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Liste des events',
        icon: Icons.search,
        onPressed: () {
          setState(() => _headline);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventList()),
          );
        },
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Mes participations',
        icon: Icons.event,
        onPressed: () {
          setState(() => _headline);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ParticipationPage()),
          );
        },
      ),
      CollapsibleItem(
        text: '(A) Création événement',
        icon: Icons.create,
        onPressed: () {
          setState(() => _headline = ('create Event'));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateEventScreen()),
          );
        },
      ),
      CollapsibleItem(
        text: '(A) Liste événement',
        icon: Icons.manage_search,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminEventList()),
          );
        },
      ),
      CollapsibleItem(
        text: 'Mon Profil',
        icon: Icons.face,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        },
      ),

      // CollapsibleItem(
      //   text: 'Face',
      //   icon: Icons.face,
      //   onPressed: () => setState(() => _headline = 'Face'),
      // ),

      CollapsibleItem(
        text: 'Deconexion',
        icon: Icons.exit_to_app,
        onPressed: () {
          auth.signOut();
          Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const ChoiceLogin(),
              transitionDuration: const Duration(seconds: 0),
            ),
            (Route<dynamic> route) => false,
          );
        },
      ),
    ];
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
              child: CollapsibleSidebar(
                isCollapsed: false,
                items: _items,
                avatarImg: _avatarImg,
                title: 'Navigation',
                onTitleTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventList()),
                  );
                },
                // onTitleTap: () {
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //       content: Text('Yay! Flutter Collapsible Sidebar!')));
                // },
                body: const Center(child: Center()),
                toggleTitle: 'Fermer',
                backgroundColor: Colors.white,
                selectedTextColor: Colors.white,
                selectedIconBox: const Color.fromRGBO(30, 64, 175, 1),
                selectedIconColor: const Color(0xffF3F7F7),
                unselectedIconColor: const Color(0xff2B3138),
                unselectedTextColor: const Color(0xff2B3138),

                sidebarBoxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    spreadRadius: 0.01,
                    offset: Offset(3, 3),
                  ),
                ],

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
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/event/details',
                                                    arguments:
                                                        documentSnapshot.id,
                                                  );
                                                },
                                                icon: const Icon(Icons.more),
                                                label:
                                                    const Text("Plus d'infos"),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    const Color.fromRGBO(
                                                        140, 140, 140, 1),
                                                  ),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              myEvent(
                                                  idEvent: documentSnapshot.id
                                                      .toString()),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              TextButton.icon(
                                                onPressed: () {
                                                  print("arguments: " +
                                                      documentSnapshot.id);
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/event/details',
                                                    arguments:
                                                        documentSnapshot.id,
                                                  );
                                                },
                                                icon: const Icon(Icons.more),
                                                label:
                                                    const Text("Plus d'infos"),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    const Color.fromRGBO(
                                                        140, 140, 140, 1),
                                                  ),
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              myEvent(
                                                  idEvent: documentSnapshot.id
                                                      .toString()),
                                              // TextButton.icon(
                                              //   onPressed: () => {},
                                              //   icon: const Icon(
                                              //       Icons.check_circle),
                                              //   label: const Text("S'inscrire"),
                                              //   style: ButtonStyle(
                                              //     backgroundColor:
                                              //         MaterialStateProperty.all<
                                              //                 Color>(
                                              //             const Color.fromRGBO(
                                              //                 3, 110, 20, 1)),
                                              //     foregroundColor:
                                              //         MaterialStateProperty.all<
                                              //             Color>(Colors.white),
                                              //   ),
                                              // ),
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
                    );
                  }),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}

class myEvent extends StatefulWidget {
  String? idEvent;
  myEvent({Key? key, required this.idEvent}) : super(key: key);

  @override
  State<myEvent> createState() => _myEventState();
}

class _myEventState extends State<myEvent> {
  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    CollectionReference userRef = FirebaseFirestore.instance.collection('User');

    Text dialog = const Text('');
    Text unsubDialog = const Text('Désinscription');
    Text subDialog = const Text('Inscription');

    Text question = const Text('');
    Text unsubQuestion = const Text('Quitter cet événement ?');
    Text subQuestion = const Text('S\'inscrire à cet évenement ?');

    Text buttonText = const Text('');
    Text unsubButtonText = const Text('Se désinscrire');
    Text subButtonText = const Text('S\'inscire');

    Icon icon = const Icon(Icons.circle);
    Icon subIcon = const Icon(Icons.check_circle_rounded);
    Icon unsubIcon = const Icon(Icons.remove_circle_outlined);

    var buttonColor =
        MaterialStateProperty.all<Color>(Color.fromARGB(255, 172, 160, 160));

    var subButtonColor =
        MaterialStateProperty.all<Color>(const Color.fromARGB(255, 7, 194, 54));

    var unsubButtonColor = MaterialStateProperty.all<Color>(
        const Color.fromARGB(255, 233, 17, 17));

    bool contains(data, idEvent) {
      bool boolean = false;
      for (var d in data) {
        if (d == idEvent) {
          boolean = true;
        }
      }
      return boolean;
    }

    return FutureBuilder(
        future: userRef.doc(result!.uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            if (contains(data['MyEvent'], widget.idEvent)) {
              dialog = unsubDialog;
              question = unsubQuestion;
              buttonText = unsubButtonText;
              buttonColor = unsubButtonColor;
              icon = unsubIcon;
              return TextButton.icon(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: dialog,
                    content: question,
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          deleteEvent(widget.idEvent);
                          deleteCountEvent(widget.idEvent);
                          Navigator.pop(context, 'Oui !');
                          setState(() {});
                        },
                        child: const Text('Oui...'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Non !'),
                        child: const Text('Non !'),
                      ),
                    ],
                  ),
                ),
                icon: icon,
                label: buttonText,
                style: ButtonStyle(
                  backgroundColor: buttonColor,
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              );
            } else {
              dialog = subDialog;
              question = subQuestion;
              buttonText = subButtonText;
              buttonColor = subButtonColor;
              icon = subIcon;
              return TextButton.icon(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: dialog,
                    content: question,
                    actions: <Widget>[
                      TextButton(
                        onPressed: () async {
                          addEvent(widget.idEvent);
                          addCountEvent(widget.idEvent);
                          Navigator.pop(context, 'Oui !');
                          setState(() {});
                        },
                        child: const Text('Oui...'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Non !'),
                        child: const Text('Non !'),
                      ),
                    ],
                  ),
                ),
                icon: icon,
                label: buttonText,
                style: ButtonStyle(
                  backgroundColor: buttonColor,
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

Future<void> addEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  return users
      .doc(result!.uid)
      .update({
        'MyEvent': FieldValue.arrayUnion([idEvent]),
      })
      .then((value) => print("IdEvent Added"))
      .catchError((error) => print("Failed to add : $error"));
}

Future<void> addCountEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference event = FirebaseFirestore.instance.collection('Event');
  return event
      .doc(idEvent)
      .update({
        'Users': FieldValue.arrayUnion([result!.uid])
      })
      .then((value) => print("Event Updated User"))
      .catchError((error) => print("Failed to update event: $error"));
  ;
}

Future<void> deleteEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  return users
      .doc(result!.uid)
      .update({
        'MyEvent': FieldValue.arrayRemove([idEvent])
      })
      .then((value) => print("IdEvent delete"))
      .catchError((error) => print("Failed to delete : $error"));
}

Future<void> deleteCountEvent(idEvent) {
  User? result = FirebaseAuth.instance.currentUser;
  CollectionReference event = FirebaseFirestore.instance.collection('Event');
  return event
      .doc(idEvent)
      .update({
        'Users': FieldValue.arrayRemove([result!.uid])
      })
      .then((value) => print("Event Updated User"))
      .catchError((error) => print("Failed to update event: $error"));
}
