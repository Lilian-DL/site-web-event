import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEventScreen extends StatefulWidget {
  CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final detailController = TextEditingController();
  final adressController = TextEditingController();

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
}
