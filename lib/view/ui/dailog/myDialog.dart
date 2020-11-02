import 'package:firestore_crud/view/ui/homepage/homepage_viewmodel.dart';
import 'package:flutter/material.dart';

Future<void> addDialog(
    BuildContext context, HomePageViewModel model, String dialogTitle) async {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(dialogTitle),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty)
                      return "Enter Title";
                    else
                      return null;
                  },
                  controller: _titleController,
                  decoration: InputDecoration(hintText: 'Enter Note Title'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) return "Enter Description";
                  },
                  controller: _descController,
                  decoration:
                      InputDecoration(hintText: 'Enter Note Description'),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          OutlineButton(
            child: Text('cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          OutlineButton(
            child: Text('Submit'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                model.addData(_titleController.text, _descController.text);
                // refreshdata();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
