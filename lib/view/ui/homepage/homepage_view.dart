import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_crud/app/locator.dart';
import 'package:firestore_crud/view/ui/dailog/myDialog.dart';
import 'package:firestore_crud/view/ui/dailog/updateDailog.dart';
import 'package:firestore_crud/view/ui/homepage/homepage_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Stream<QuerySnapshot> notes;

  void refreshdata() {
    HomePageViewModel.getData().then((value) {
      setState(() {
        notes = value;
      });
    }).catchError((e) {});
  }

  @override
  void initState() {
    refreshdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () {
            refreshdata();
          },
        ),
        appBar: AppBar(
          title: Text('Notes'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  addDialog(context, model, "Add a Note");
                }),
          ],
        ),
        body: _noteList(model),
      ),
      viewModelBuilder: () => locator<HomePageViewModel>(),
    );
  }

  Widget _noteList(HomePageViewModel model) {
    if (notes != null) {
      return StreamBuilder(
        stream: notes,
        builder: (context, snapshot) {
          if (snapshot.data == null) return CircularProgressIndicator();
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: snapshot.data.docs.length,
            //padding: EdgeInsets.all(5.0),
            itemBuilder: (context, i) {
              return ListTile(
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      model.deleteData(snapshot.data.docs[i].documentID);
                    }),
                onTap: () {
                  updateDialog(context, model, "Update a Note",
                      snapshot.data.docs[i].documentID);
                },
                title: Text(
                  snapshot.data.docs[i].data()['title'],
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(snapshot.data.docs[i].data()['description']),
              );
            },
          );
        },
      );
    } else {
      return Text('No Data Found');
    }
  }
}
