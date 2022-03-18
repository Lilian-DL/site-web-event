import 'package:flutter/cupertino.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/material.dart';

class SlideBar extends StatefulWidget {
  SlideBar({Key? key}) : super(key: key);

  @override
  State<SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
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
        text: 'Search',
        icon: Icons.search,
        onPressed: () => setState(() => _headline = 'Search'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Notifications',
        icon: Icons.notifications,
        onPressed: () => setState(() => _headline = 'Notifications'),
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
        text: 'Email',
        icon: Icons.email,
        onPressed: () => setState(() => _headline = 'Email'),
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
    return
        // Container(
        // appBar: AppBar(
        //   backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
        //   elevation: 0.0,
        //   title: const Text(
        //     'Edition d\'un événement :',
        //     style: TextStyle(
        //         fontSize: 35,
        //         fontFamily: 'Roboto',
        //         color: Colors.white,
        //         fontWeight: FontWeight.w900),
        //   ),
        // ),
        // child: Container(
        //   alignment: Alignment.center,
        //   // padding: const EdgeInsets.all(50),
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [
        //           Color.fromRGBO(36, 45, 165, 1),
        //           Color.fromRGBO(39, 50, 207, 1),
        //           Color.fromRGBO(13, 19, 102, 1)
        //         ]),
        //   ),

        //child:
        CollapsibleSidebar(
      isCollapsed: false,
      items: _items,
      avatarImg: _avatarImg,
      title: 'Dashboard',
      // onTitleTap: () {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content: Text('Yay! Flutter Collapsible Sidebar!')));
      // },
      body: const Center(child: Center()),
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
    );
    // ),
    //);
  }

  // Widget body(Size size, BuildContext context) {
  //   return Container(
  //     body: Container(
  // decoration: const BoxDecoration(
  //   gradient: LinearGradient(
  //       begin: Alignment.topCenter,
  //       end: Alignment.bottomCenter,
  //       colors: [
  //         Color.fromRGBO(36, 45, 165, 1),
  //         Color.fromRGBO(39, 50, 207, 1),
  //         Color.fromRGBO(13, 19, 102, 1)
  //       ]),
  // ),
//         padding: const EdgeInsets.only(left: 75, right: 75, top: 0, bottom: 0),
//         alignment: Alignment.center,
//         // key: formKey,
//         child: ListView(
//           children: <Widget>[
//             SizedBox(height: 50),
//             Container(
//               width: 800,
//               height: 700,
//               padding: const EdgeInsets.all(20),
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(25)),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                       color: Color.fromRGBO(0, 0, 0, 0.6),
//                       spreadRadius: 5,
//                       blurRadius: 29,
//                       offset: Offset(0, 0))
//                 ],
//               ),
//             ),
//           ],
//         ),
  // ),
  // );
  // }
}
