import 'package:flutter/material.dart';
import 'download_button.dart';

class ChoiceLogin extends StatefulWidget {
  const ChoiceLogin({Key? key}) : super(key: key);

  @override
  State<ChoiceLogin> createState() => _ChoiceLogin();
}

class _ChoiceLogin extends State<ChoiceLogin> {
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
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: SizedBox(
            width: 400,
            height: 500,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 14.0),
                  child: Text(
                    "Identifiez-vous",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 26),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Column(
                  children: [
                    SizedBox(
                      height: 75,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: const Text(
                            "Connexion",
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/login',
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(36, 45, 165, 1)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    SizedBox(
                      height: 75,
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: const Text("S'inscrire",
                              style: TextStyle(fontSize: 18)),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/inscription',
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(36, 45, 165, 1)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    const DownloadButton(
                        url:
                            "https://firebasestorage.googleapis.com/v0/b/planification-8efe7.appspot.com/o/apk_mobile%2Fapp-release.apk?alt=media&token=9a58a996-e76b-41c3-8494-7f887d9cf73c"),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
