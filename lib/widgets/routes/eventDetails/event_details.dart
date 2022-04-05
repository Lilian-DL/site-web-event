import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_plan/services/auth.dart';
import 'package:web_plan/widgets/routes/adminCreateEvent/admin_create_event.dart';
import 'package:web_plan/widgets/routes/adminEventList/admin_event_list.dart';
import 'package:web_plan/widgets/routes/eventList/event_list.dart';
import 'package:web_plan/widgets/routes/menuConnexion/menu_connexion.dart';
import 'package:web_plan/widgets/routes/participationsPage/participations_page.dart';
import 'package:web_plan/widgets/routes/profilePage/profile_page.dart';
import 'package:web_plan/widgets/slideBar/slide_bar.dart';

class EventDetails extends StatefulWidget {
  final String id;
  const EventDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('web/assets/logoWeb.png');
  final AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    _items = _generateUserItems;
    CheckItem();
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  Future CheckItem() async {
    bool boolean = await checkItemBool();
    if (boolean == true) {
      setState(() {
        _items = _generateItems;
      });
    } else {
      setState(() {
        _items = _generateUserItems;
      });
    }
  }

  Future<bool> checkItemBool() async {
    User? result = FirebaseAuth.instance.currentUser;
    bool boolean = await FirebaseFirestore.instance
        .collection('User')
        .doc(result!.uid)
        .get()
        .then((value) {
      if (value['Admin'] == true) {
        return true;
      } else {
        return false;
      }
    });
    return boolean;
  }

  @override
  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Liste des events',
        icon: Icons.search,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  EventList(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Mes participations',
        icon: Icons.event,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ParticipationPage(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
      ),
      CollapsibleItem(
        text: 'Mon Profil',
        icon: Icons.face,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ProfilePage(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
      ),
      CollapsibleItem(
        text: '(A) Création événement',
        icon: Icons.create,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  CreateEventScreen(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
      ),
      CollapsibleItem(
        text: '(A) Liste événement',
        icon: Icons.manage_search,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  AdminEventList(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
      ),
      // CollapsibleItem(
      //   text: 'Face',
      //   icon: Icons.face,
      //   onPressed: () => setState(() => _headline = 'Face'),
      // ),

      CollapsibleItem(
        text: 'Déconnexion',
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
  List<CollapsibleItem> get _generateUserItems {
    return [
      CollapsibleItem(
        text: 'Liste des events',
        icon: Icons.search,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  EventList(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Mes participations',
        icon: Icons.event,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ParticipationPage(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
      ),
      CollapsibleItem(
        text: 'Mon Profil',
        icon: Icons.face,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ProfilePage(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
      ),

      // CollapsibleItem(
      //   text: 'Face',
      //   icon: Icons.face,
      //   onPressed: () => setState(() => _headline = 'Face'),
      // ),

      CollapsibleItem(
        text: 'Déconnexion',
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
          'Plus de détails :',
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
                child: _body(size, context, widget.id.toString()),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MyCustomMobileScreen extends StatelessWidget {
//   const MyCustomMobileScreen({Key? key}) : super(key: key);

@override
Widget _body(Size size, BuildContext context, String id) {
  CollectionReference event = FirebaseFirestore.instance.collection('Event');
  return FutureBuilder<DocumentSnapshot>(
      future: event.doc(id.toString()).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.2,
                      0.6,
                      0.8,
                    ],
                    colors: <Color>[
                      Color.fromRGBO(36, 45, 165, 1.0),
                      Color.fromRGBO(39, 50, 185, 1.0),
                      Color.fromRGBO(13, 19, 132, 1.0)
                    ]),
              ),
              child: ListView(
                children: [
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(
                      top: 25,
                      left: 50.0,
                      right: 25,
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 245, 245, 245),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                )),
                            width: double.maxFinite,
                            child: Center(
                              child: Text(
                                '${data['Title']}',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /*ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: AssetImage('bergues_beffroi.jpeg'),
                                    ),*/
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.40,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.40,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                          image: AssetImage(
                                              "web/assets/bergues_beffroi.jpeg"),
                                          fit: BoxFit.fill,
                                        ))),

                                    // SizedBox(width: MediaQuery.of(context).size.width * 0.10),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 235, 235, 235),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 235, 235, 235),
                                                  width: 4,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.location_on),
                                                  Text(
                                                    "${data['Location']}",
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 235, 235, 235),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 235, 235, 235),
                                                  width: 4,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.person),
                                                  Text(
                                                      " ${data['Users'].length}/${data['PeopleLimit']}"),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 235, 235, 235),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 235, 235, 235),
                                              width: 4,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.calendar_today),
                                              Text(
                                                  ' ${data['Date'].toDate().toString().split(" ")[0]} '
                                                  '${data['Date'].toDate().toString().split(" ")[1].substring(0, 5)}'),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 235, 235, 235),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 235, 235, 235),
                                              width: 4,
                                            ),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                          padding: const EdgeInsets.all(10),
                                          child: Text(
                                            '${data['Description']}',
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 50,
                                        ),
                                        myEvent(idEvent: id.toString()),
                                      ],
                                    ),

                                    /*ElevatedButton(
                                      onPressed: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          title: const Text('Désinscription'),
                                          content: const Text(
                                              'Quitter cet événement ?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Oui...'),
                                              child: const Text('Oui...'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Non !'),
                                              child: const Text('Non !'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      child: const Text("Se désinscrire"),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  const Color.fromARGB(
                                                      255, 245, 23, 23))),
                                    ),*/
                                    const SizedBox(
                                      height: 30,
                                    )
                                  ],
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        }
        return const CircularProgressIndicator();
      });
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


// }

// class MyCustomDesktopScreen extends StatelessWidget {
//   const MyCustomDesktopScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: [
//                 0.2,
//                 0.6,
//                 0.8,
//               ],
//               colors: <Color>[
//                 Color.fromRGBO(36, 45, 165, 1.0),
//                 Color.fromRGBO(39, 50, 185, 1.0),
//                 Color.fromRGBO(13, 19, 132, 1.0)
//               ]),
//         ),
//         child: Card(
//           elevation: 5,
//           margin: const EdgeInsets.all(16.0),
//           color: Colors.white,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           child: Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.10,
//                 decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 49, 49, 49),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(30),
//                       topRight: Radius.circular(30),
//                     )),
//                 width: double.maxFinite,
//                 child: const Center(
//                   child: Text(
//                     'Brocante d\'instruments',
//                     textAlign: TextAlign.start,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 36,
//                     ),
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(5),
//                         child: Image.network(
//                           'https://media.discordapp.net/attachments/902535167850197022/935814927443165254/unknown.png',
//                           width: MediaQuery.of(context).size.width * 0.40,
//                           height: MediaQuery.of(context).size.width * 0.30,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(width: MediaQuery.of(context).size.width * 0.10),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 235, 235, 235),
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(
//                             color: const Color.fromARGB(255, 235, 235, 235),
//                             width: 4,
//                           ),
//                         ),
//                         child: Row(
//                           children: const [
//                             Icon(Icons.location_on),
//                             Text(
//                               "7 rue du bois à Montpellier",
//                               textAlign: TextAlign.start,
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 235, 235, 235),
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(
//                             color: const Color.fromARGB(255, 235, 235, 235),
//                             width: 4,
//                           ),
//                         ),
//                         child: Row(
//                           children: const [
//                             Icon(Icons.calendar_today),
//                             Text(' Du ' '05/03/2022' ' au ' '05/03/2022'),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 235, 235, 235),
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(
//                             color: const Color.fromARGB(255, 235, 235, 235),
//                             width: 4,
//                           ),
//                         ),
//                         child: Row(
//                           children: const [
//                             Icon(Icons.person),
//                             Text('26 / 40'),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 235, 235, 235),
//                           borderRadius: BorderRadius.circular(5),
//                           border: Border.all(
//                             color: const Color.fromARGB(255, 235, 235, 235),
//                             width: 4,
//                           ),
//                         ),
//                         width: MediaQuery.of(context).size.width * 0.30,
//                         padding: const EdgeInsets.all(10),
//                         child: const Text(
//                           'Vous possèdez des instruments que vous n\'utilisez plus ? Alors vous êtes au bon endroit, venez vendre vos instruments à la brocante organisée par l\'association, vous vous débarassez et vous faites plaisir à quelqu\'un !',
//                           textAlign: TextAlign.start,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       ElevatedButton(
//                         onPressed: () => showDialog<String>(
//                           context: context,
//                           builder: (BuildContext context) => AlertDialog(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(5)),
//                             title: const Text('Désinscription'),
//                             content: const Text('Quitter cet événement ?'),
//                             actions: <Widget>[
//                               TextButton(
//                                 onPressed: () =>
//                                     Navigator.pop(context, 'Oui...'),
//                                 child: const Text('Oui...'),
//                               ),
//                               TextButton(
//                                 onPressed: () =>
//                                     Navigator.pop(context, 'Non !'),
//                                 child: const Text('Non !'),
//                               ),
//                             ],
//                           ),
//                         ),
//                         child: const Text("Se désinscrire"),
//                         style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 const Color.fromARGB(255, 245, 23, 23))),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }