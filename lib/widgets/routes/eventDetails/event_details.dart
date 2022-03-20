import 'package:flutter/material.dart';
import 'package:web_plan/responsive_layout.dart';
import 'package:web_plan/widgets/slideBar/slide_bar.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
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
                  minWidth:100,
                ),
              // color : Colors.green,
                child: SlideBar()
            ),
            Expanded(
                flex: 1, 
            child :Container(
              alignment: const FractionalOffset(0.3, 0.4),
              // color : Colors.purple,
              height: MediaQuery.of(context).size.height * 1.0,
              // child: Padding(
                // padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child : _body(size, context),
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
  Widget _body(Size size, BuildContext context) {
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
                margin: const EdgeInsets.all(16.0),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 49, 49, 49),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            )),
                        width: double.maxFinite,
                        child: const Center(
                          child: Text(
                            'Brocante d\'instruments',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                  'https://media.discordapp.net/attachments/902535167850197022/935814927443165254/unknown.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  height:
                                      MediaQuery.of(context).size.width * 0.50,
                                ),
                              ),

                              // SizedBox(width: MediaQuery.of(context).size.width * 0.10),

                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    width: 4,
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.location_on),
                                    Text(
                                      "7 rue du bois à Montpellier",
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    width: 4,
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.calendar_today),
                                    Text(' Du '
                                        '05/03/2022'
                                        ' au '
                                        '05/03/2022'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    width: 4,
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.person),
                                    Text('26 / 40'),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 235, 235, 235),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 235, 235, 235),
                                    width: 4,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.50,
                                padding: const EdgeInsets.all(10),
                                child: const Text(
                                  'Vous possèdez des instruments que vous n\'utilisez plus ? Alors vous êtes au bon endroit, venez vendre vos instruments à la brocante organisée par l\'association, vous vous débarassez et vous faites plaisir à quelqu\'un !',
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              ElevatedButton(
                                onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    title: const Text('Désinscription'),
                                    content:
                                        const Text('Quitter cet événement ?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Oui...'),
                                        child: const Text('Oui...'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Non !'),
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
                              ),
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
