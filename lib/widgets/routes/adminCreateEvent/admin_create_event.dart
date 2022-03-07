import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';


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
  String message1 = 'Drop something here';
  bool highlighted1 = false;


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
                  child: Expanded(
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

                ),
                ElevatedButton(
                onPressed: () async {
                  print(await controller1.pickFiles(mime: ['image/jpeg', 'image/png']));
                },
                child: const Text('Pick file'),
              ),
                SizedBox(height: 8.0),
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
