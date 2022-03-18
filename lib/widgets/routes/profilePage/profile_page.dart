import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';

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
  int _selectedIndex = 2;

  late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Search',
        icon: Icons.search,
        onPressed: () => setState(() => _headline = 'Search'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Settings',
        icon: Icons.settings,
        onPressed: () => setState(() => _headline = 'Settings'),
      ),
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => setState(() => _headline = 'Home'),
      ),
      CollapsibleItem(
        text: 'Event',
        icon: Icons.event,
        onPressed: () => setState(() => _headline = 'Event'),
      ),
      CollapsibleItem(
        text: 'Face',
        icon: Icons.face,
        onPressed: () => setState(() => _headline = 'Face'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: CollapsibleSidebar(
          isCollapsed: true,
          items: _items,
          avatarImg: _avatarImg,
          title: 'Dashboard',
          onTitleTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Yay! Flutter Collapsible Sidebar!')));
          },
          body: _body(size, context),
          backgroundColor: Colors.white,
          selectedTextColor: Colors.white,
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
    );
  }

  @override
  Widget _body(Size size, BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://media.discordapp.net/attachments/902535167850197022/935551661001302026/Clem.jpg?width=661&height=663"),
                    radius: 72.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            // ---------- Nom/Prénom ---------- //
            const Text(
              "Clément Blaizel",
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blueGrey,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            // ---------- Statut ---------- //
            const Text(
              "Flûtiste",
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            // ---------- Situation ---------- //
            const Text(
              "Étudiant en LP DIM à Calais",
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black45,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            // ---------- Email ---------- //
            const Card(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                elevation: 2.0,
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    child: Text(
                      "clément.blaizel@gmail.com",
                      style: TextStyle(
                          letterSpacing: 2.0, fontWeight: FontWeight.w300),
                    ))),
            const SizedBox(
              height: 30,
            ),
            // ---------- Nombre de participations ---------- //
            Card(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: const [
                          Text(
                            "Participations à venir :",
                            style: TextStyle(
                                color: Color.fromRGBO(36, 45, 165, 1),
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "3",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300),
                          )
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
      // ---------- BottomNavBar ---------- //
    );
  }
}
