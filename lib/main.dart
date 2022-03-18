import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_plan/widgets/routes/IntroScreen/intro_screen.dart';
import 'package:web_plan/widgets/routes/adminCreateEvent/admin_create_event.dart';
import 'package:web_plan/widgets/routes/adminEventList/admin_event_list.dart';
import 'package:web_plan/widgets/routes/adminModifyEvent/admin_modify_event.dart';
import 'package:web_plan/widgets/routes/eventDetails/event_details.dart';
import 'package:web_plan/widgets/routes/eventList/event_list.dart';
import 'package:web_plan/widgets/routes/profilePage/profile_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // ignore: prefer_const_constructors
      options: FirebaseOptions(
          apiKey: "AIzaSyBol5HwITYnRCjmhqUM9XzgWwFT0s71YUs",
          authDomain: "planification-8efe7.firebaseapp.com",
          projectId: "planification-8efe7",
          storageBucket: "planification-8efe7.appspot.com",
          messagingSenderId: "18890479583",
          appId: "1:18890479583:web:e3201f338b83f2af07966a"));
  runApp(const MyApp());
  // ignore: prefer_const_constructors
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application de planification',
      theme: ThemeData(),
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => IntroScreen());

      case '/profile':
        return MaterialPageRoute(builder: (context) => const ProfilePage());

      case '/event/create':
        return MaterialPageRoute(builder: (context) => CreateEventScreen());

      case '/event/edit':
        return MaterialPageRoute(builder: (context) => EditEventScreen());

      case '/event/list/admin':
        return MaterialPageRoute(builder: (context) => const AdminEventList());

      case '/event/list/user':
        return MaterialPageRoute(builder: (context) => const EventList());

      case '/event/details':
        return MaterialPageRoute(builder: (context) => const EventDetails());

      default:
        return pageNotFound();
    }
  }

  static MaterialPageRoute pageNotFound() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
            appBar: AppBar(title: const Text("Error"), centerTitle: true),
            body: const Center(
              child: Text("Page not found"),
            )));
  }
}
