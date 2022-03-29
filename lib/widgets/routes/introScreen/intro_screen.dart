import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:web_plan/widgets/routes/introScreen/verif_email.dart';
import 'package:web_plan/widgets/routes/menuConnexion/menu_connexion.dart';
import '../eventList/event_list.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return VerifyEmail();
          } else {
            return ChoiceLogin();
          }
        });
  }
}
