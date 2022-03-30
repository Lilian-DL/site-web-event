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
                        top: 50,
                        left: 120.0,
                        right: 120,
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'https://media.discordapp.net/attachments/902535167850197022/935814927443165254/unknown.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                      ),
                                    ),

                                    // SizedBox(width: MediaQuery.of(context).size.width * 0.10),

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
                                        borderRadius: BorderRadius.circular(5),
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
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 235, 235, 235),
                                          width: 4,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width *
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
                                )
                              ],
                            ),
                          ],
                        ),
                      ))
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
    Icon unsubIcon = const Icon(Icons.remove_circle_outlined);
    Icon subIcon = const Icon(Icons.remove_circle_outlined);

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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventList()));
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
                icon: const Icon(Icons.remove_circle_outlined),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EventList()));
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
                icon: const Icon(Icons.remove_circle_outlined),
                label: buttonText,
                style: ButtonStyle(
                  backgroundColor: buttonColor,
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              );
            }
          } else {
            return const Text("");
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
