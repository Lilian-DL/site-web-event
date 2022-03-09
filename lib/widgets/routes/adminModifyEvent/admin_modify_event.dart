// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

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
    return Scaffold(
        body: Form(
            key: formKey,
            child: ListView(
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
                            "Date of event :  ${pickedDate.day}, ${pickedDate.month}, ${pickedDate.year}"),
                        trailing: Icon(Icons.keyboard_arrow_down),
                        onTap: _pickDate,
                      ),
                      ListTile(
                        title: Text(
                            "Hour of event :  ${time.hour}:${time.minute}"),
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
                SizedBox(height: 50.0),
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
            )));
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
