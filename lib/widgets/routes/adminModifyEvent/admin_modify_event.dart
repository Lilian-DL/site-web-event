// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:web_plan/widgets/slideBar/slide_Bar.dart';

class EditEventScreen extends StatefulWidget {
  EditEventScreen({Key? key}) : super(key: key);

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
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

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  @override
  void dispose() {
    titleController.dispose();
    detailController.dispose();
    adressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(36, 45, 165, 1),
        elevation: 0.0,
        title: const Text(
          'Edition d\'un événement :',
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
              alignment: const FractionalOffset(0.2, 0.4),
              // color : Colors.purple,
              height: MediaQuery.of(context).size.height * 1.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child : _body(size, context),
                ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _body(Size size, BuildContext context) {
        return Container(
            constraints:const BoxConstraints(
              minHeight: 500.0,
              minWidth: 500.0,
              maxHeight: 800.0,
              maxWidth: 600,
            ),
            alignment: Alignment.center,
            key: formKey,
            child: ListView(children: <Widget>[
              SizedBox(height: 50),
        Container(
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                hintText: "Detail",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                hintText: "Adress",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                  title: Text("Hour :  ${time.hour}:${time.minute}"),
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
                hintText: "People Max",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
          ),
        SizedBox(height: 30.0),
        ],
        
      ),
    ),
    ]));
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
