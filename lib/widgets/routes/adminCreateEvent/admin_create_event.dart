// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:web_plan/services/auth.dart';
import 'package:web_plan/widgets/routes/adminEventList/admin_event_list.dart';
import 'package:web_plan/widgets/routes/eventList/event_list.dart';
import 'package:web_plan/widgets/routes/menuConnexion/menu_connexion.dart';
import 'package:web_plan/widgets/routes/participationsPage/participations_page.dart';
import 'package:web_plan/widgets/routes/profilePage/profile_page.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final formKey = GlobalKey<FormState>();
  late DropzoneViewController controller1;
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final adressController = TextEditingController();
  final peopleController = TextEditingController();
  /* String message1 = 'Drop something here'; */
  String messageError = "";
  bool highlighted1 = false;
  late DateTime pickedDate;
  late TimeOfDay time;
  int _currentHorizontalIntValue = 10;
  var WhitelistingTextInputFormatter;

  late List<CollapsibleItem> _items;
  final AssetImage _avatarImg = const AssetImage('web/assets/logoWeb.png');
  final AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
    _items = _generateItems;
  }

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
                  const EventList(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
      ),
      CollapsibleItem(
        text: 'Mes participations',
        icon: Icons.event,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const ParticipationPage(),
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
                  const ProfilePage(),
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
                  const CreateEventScreen(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
        isSelected: true,
      ),
      CollapsibleItem(
        text: '(A) Liste événement',
        icon: Icons.manage_search,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AdminEventList(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
      ),
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
          'Creation d\'un événement :',
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
                    MaterialPageRoute(builder: (context) => const EventList()),
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
          maxWidth: 600,
        ),
        alignment: Alignment.center,
        key: formKey,
        child: ListView(children: <Widget>[
          const SizedBox(height: 50),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "Titre",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: detailController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: adressController,
                    decoration: const InputDecoration(
                      labelText: "Lieu de déroulement",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                ),
                /* Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100.0,
                    color: highlighted1 ? Colors.grey[400] : Colors.transparent,
                    child: Stack(
                      children: [
                        buildZone1(context),
                        Center(child: Text(message1)),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () /*async */ {
                    /*print(await controller1
                        .pickFiles(mime: ['image/jpeg', 'image/png']));*/
                  },
                  child: const Text('Pick file'),
                ), */
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            "Date :  ${pickedDate.day}/${pickedDate.month}/${pickedDate.year}"),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        onTap: _pickDate,
                      ),
                      /* ListTile(
                        title: Text("Hour :  ${time.hour}:${time.minute}"),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        onTap: _pickTime,
                      ), */
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: peopleController,
                    decoration: const InputDecoration(
                      labelText: "Places disponibles",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ),
                ),
                Text(
                  messageError,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(30, 64, 175, 1),
                    ),
                    onPressed: () {
                      if (titleController.text.isNotEmpty &&
                          detailController.text.isNotEmpty &&
                          adressController.text.isNotEmpty &&
                          peopleController.text.isNotEmpty) {
                        var people = int.parse(peopleController.text);
                        addEvent(titleController.text, detailController.text,
                            adressController.text, people, pickedDate);
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.pushNamed(
                            context,
                            '/event/list/user',
                          );
                        });
                      } else {
                        setState(() {});
                        messageError = "Tous les champs doivent être remplis";
                      }
                    },
                    child: const Text('Envoyer'),
                  ),
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ]));
  }

  _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      locale: const Locale("fr", "FR"),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        pickedDate = date;
      });
  }

  /* Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => controller1 = ctrl,
          onLoaded: () => print('Zone 1 loaded'),
          onError: (ev) => print('Zone 1 error: $ev'),
          onHover: () {
            setState(() => highlighted1 = true);
            print('Zone 1 hovered');
          },
          onLeave: () {
            setState(() => highlighted1 = false);
            print('Zone 1 left');
          },
          onDrop: (ev) async {
            print('Zone 1 drop: ${ev.name}');
            setState(() {
              message1 = '${ev.name} dropped';
              highlighted1 = false;
            });
            final bytes = await controller1.getFileData(ev);
            print(bytes.sublist(0, 20));
          },
          onDropMultiple: (ev) async {
            print('Zone 1 drop multiple: $ev');
          },
        ),
      ); */
}

Future<void> addEvent(title, description, location, peopleLimit, date) {
  CollectionReference users = FirebaseFirestore.instance.collection('Event');
  return users
      .doc()
      .set({
        'Title': title,
        'Description': description,
        'Location': location,
        'Date': date,
        'Picture': "",
        'PeopleLimit': peopleLimit,
        'Users': FieldValue.arrayUnion([]),
      })
      .then((value) => print("User Event"))
      .catchError((error) => print("Failed to add event: $error"));
}
