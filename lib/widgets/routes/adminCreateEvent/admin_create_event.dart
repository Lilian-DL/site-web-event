// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({Key? key}) : super(key: key);

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
  String message1 = 'Drop something here';
  bool highlighted1 = false;
  late DateTime pickedDate;
  late TimeOfDay time;
  int _currentHorizontalIntValue = 10;

  var WhitelistingTextInputFormatter;

late List<CollapsibleItem> _items;
  late String _headline;
  AssetImage _avatarImg = AssetImage('../assets/logoWeb.png');
  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  @override
  void dispose() {
    titleController.dispose();
    detailController.dispose();
    adressController.dispose();

    super.dispose();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
        elevation: 0.0,
        title: const Text(
          'Création d\'un événement :',
          style: TextStyle(
              fontSize: 35,
              fontFamily: 'Roboto',
              color: Colors.white,
              fontWeight: FontWeight.w900),
        ),
      ),
        body: Container(
          alignment: Alignment.center,
          // padding: const EdgeInsets.all(50),
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


Widget _body(Size size, BuildContext context) {
    return Scaffold(
      
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
        padding: const EdgeInsets.only(left:75,right:75,top:0,bottom:0),
        alignment: Alignment.center,
        key: formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(height:50),
                Container(
            width: 800,
            height: 700,
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
              child :Column(
                
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: detailController,
                    decoration: const InputDecoration(
                      labelText: 'Detail',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a detail';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: adressController,
                    decoration: const InputDecoration(
                      labelText: 'Adress',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a adress ';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
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
                  onPressed: () async {
                    print(await controller1
                        .pickFiles(mime: ['image/jpeg', 'image/png']));
                  },
                  child: const Text('Pick file'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                            "Date :  ${pickedDate.day}, ${pickedDate.month}, ${pickedDate.year}"),
                        trailing: Icon(Icons.keyboard_arrow_down),
                        onTap: _pickDate,
                      ),
                      ListTile(
                        title: Text(
                            "Hour :  ${time.hour}:${time.minute}"),
                        trailing: Icon(Icons.keyboard_arrow_down),
                        onTap: _pickTime,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: peopleController,
                    decoration: const InputDecoration(
                      labelText: 'People Max',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a max people on this event ';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Recipe recipe = Recipe(titleController.value.text, detailController.value.text, adressController.value.text,);
                      }
                    },
                    child: Text('Save'),
                  ),
                )
              ],
            ),
            ),
              ]
            ) 
            ),
    );
}

_pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
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
  _pickTime() async {
    TimeOfDay? t = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (t != null)
      // ignore: curly_braces_in_flow_control_structures
      setState(() {
        time = t;
      });
  }

  Widget buildZone1(BuildContext context) => Builder(
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
      );
}
