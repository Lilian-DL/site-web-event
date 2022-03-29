import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_plan/widgets/slideBar/slide_bar.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: ResponsiveLayout(
//           mobileBody: MyCustomMobileContent(),
//           desktopBody: MyCustomDesktopContent()),
//     );
//   }
// }

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

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? result = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 2;

  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('');

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
          'Page de Profile :',
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

  @override
  Widget _body(Size size, BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('User');
    final myControllerPrenom = TextEditingController();
    final myControllerNom = TextEditingController();

    Future<void> updateUser(idUser, prenom, nom) {
      return user
          .doc(idUser)
          .update({'FirstName': prenom, 'LastName': nom})
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }

    return FutureBuilder<DocumentSnapshot>(
        future: user.doc(result!.uid).get(),
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
            return ListView(children: [
              Container(
                constraints: const BoxConstraints(
                  minHeight: 500.0,
                  minWidth: 300.0,
                  maxHeight: 800.0,
                  maxWidth: 400,
                ),
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                    top: 20, left: 60, right: 60, bottom: 20),
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
                alignment: Alignment.center,
                child: SafeArea(
                  child: Column(
                    children: [
                      // ---------- Bannière ---------- //
                      Container(
                        margin: const EdgeInsets.only(left: 50, right: 50),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://media.discordapp.net/attachments/902535167850197022/935552865894793236/hoymille_brocante_7.jpg?width=1178&height=662"),
                                fit: BoxFit.cover)),
                        child: SizedBox(
                          width: double.infinity,
                          height: 200,
                          // ---------- Photo de profil ---------- //
                          child: Container(
                            alignment: const Alignment(0.0, 2.5),
                            child: GestureDetector(
                              onTap: () {},
                              child: const CircleAvatar(
                                backgroundImage: AssetImage('user.png'),
                                radius: 72.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      // ---------- Nom/Prénom ---------- //
                      Text(
                        "${data['FirstName']} ${data['LastName']} ",
                        style: const TextStyle(
                            fontSize: 25.0,
                            color: Colors.blueGrey,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        title: const Text(
                                            "Modifier ses informations"),
                                        actions: <Widget>[
                                          TextFormField(
                                            controller: myControllerPrenom,
                                            decoration: const InputDecoration(
                                                label: Text("Prénom")),
                                          ),
                                          TextFormField(
                                            controller: myControllerNom,
                                            decoration: const InputDecoration(
                                                label: Text("Nom")),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    updateUser(
                                                        result!.uid,
                                                        myControllerPrenom.text,
                                                        myControllerNom.text);
                                                    setState(() {});
                                                    Navigator.pop(
                                                        context, 'Oui !');
                                                    setState(() {});
                                                  },
                                                  child: const Text("Changer")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(
                                                        context, 'Oui !');
                                                  },
                                                  child: const Text("Annuler"))
                                            ],
                                          )
                                        ]));
                          },
                          icon: const Icon(Icons.edit)),
                      const SizedBox(
                        height: 10,
                      ),
                      // ---------- Statut ---------- //
                      const SizedBox(
                        height: 10,
                      ),
                      // ---------- Email ---------- //
                      Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          elevation: 2.0,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 30),
                              child: Text(
                                "${data['Email']}",
                                style: const TextStyle(
                                    letterSpacing: 2.0,
                                    fontWeight: FontWeight.w300),
                              ))),
                      const SizedBox(
                        height: 30,
                      ),
                      // ---------- Nombre de participations ---------- //
                      Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Column(
                                  children: const [
                                    Text(
                                      "Ceci est une description de ma personne",
                                      style: TextStyle(
                                          color: Color.fromRGBO(36, 45, 165, 1),
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      // ---------- Informations ---------- //
                      const Text(
                        "En cas de besoin de modification des informations ci-dessus, merci de contacter un administrateur.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black45,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              )
            ]);
            ;
          }
          return const CircularProgressIndicator();
        });
  }
}
