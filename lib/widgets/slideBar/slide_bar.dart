import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:web_plan/services/auth.dart';
import 'package:web_plan/widgets/routes/adminCreateEvent/admin_create_event.dart';
import 'package:web_plan/widgets/routes/adminEventList/admin_event_list.dart';
import 'package:web_plan/widgets/routes/adminModifyEvent/admin_modify_event.dart';
import 'package:web_plan/widgets/routes/eventDetails/event_details.dart';
import 'package:web_plan/widgets/routes/eventList/event_list.dart';
import 'package:web_plan/widgets/routes/menuConnexion/menu_connexion.dart';
import 'package:web_plan/widgets/routes/participationsPage/participations_page.dart';
import 'package:web_plan/widgets/routes/profilePage/profile_page.dart';

class SlideBar extends StatefulWidget {
  SlideBar({Key? key}) : super(key: key);

  @override
  State<SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  final AuthService auth = AuthService();
  final formKey = GlobalKey<FormState>();

  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('../assets/logoWeb.png');

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
        onPressed: ()
            {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const EventList(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
        },
        isSelected: true,
      ),
      CollapsibleItem(
          text: 'Mes participations',
          icon: Icons.event,
          onPressed: ()
              {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ParticipationPage(),
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          }),
      CollapsibleItem(
          text: '(A) Création événement',
          icon: Icons.create,
          onPressed: ()
              {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                   CreateEventScreen(),
                transitionDuration: const Duration(seconds: 0),
              ),
            );
          }),
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
          }),
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
          }),

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
    return
        
        CollapsibleSidebar(
      isCollapsed: false,
      items: _items,
      avatarImg: _avatarImg,
      title: 'Navigation',
      onTitleTap: () 
      {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const EventList(),
              transitionDuration: const Duration(seconds: 0),
            ),
          );
      },
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
    );

  }

}
