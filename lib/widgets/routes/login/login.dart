import 'package:flutter/material.dart';
import 'package:web_plan/services/auth.dart';




class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  final AuthService auth = AuthService();
  final myControllerEmail = TextEditingController();
  final myControllerPassWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // -------------------------- Screen de l'application -----------------------
    //
    return Scaffold(
      // ------------------------ Entete de l'application -----------------------
      //
      backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
        elevation: 0.0,
        title: const Text(
          'Bienvenue',
          style: TextStyle(
              fontSize: 35,
              fontFamily: 'Roboto',
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),

      // --------------------- Block du Login -------------------------
      //
      body: Center(
        child: Container(
            width: 300,
            height: 400,
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
            child: Form(
              child: Column(
                children: <Widget>[
                  const Text(
                    'Connexion',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Roboto',
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  // ---------- Le Formulaire de Connexion ----------
                  //
                  TextFormField(
                      controller: myControllerEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: myControllerPassWord,
                      decoration: const InputDecoration(
                        labelText: 'Mot de passe',
                        border: OutlineInputBorder(),
                      )),
                  const SizedBox(
                    height: 30,
                  ),

                  // ---------- Bouton de la Connexion ----------
                  //
                  TextButton(
                    child: const Text("Connexion"),
                    onPressed: () {
                      auth.signInWithEmailAndPassword(
                          myControllerEmail.text, myControllerPassWord.text);
                      print(auth.user.toString());
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(36, 45, 165, 1)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),

                  // ---------- Bouton de Réinitialisation de Mot de passe ----------
                  //
                  TextButton(
                      onPressed: () {},
                      child: const Text('Mot de passe oublié ?'))
                ],
              ),
            )),
      ),

      // Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: const [
      //     Text(
      //       'Bienvenue',
      //       style: TextStyle(
      //           fontSize: 35, fontFamily: 'Roboto', color: Colors.black),
      //     ),
      //   ],
      // ),
    );
  }
}