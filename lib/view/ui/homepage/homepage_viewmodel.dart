import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_crud/entity/note.dart';
import 'package:firestore_crud/services/login_service.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class HomePageViewModel extends BaseViewModel {
  Note note;
  Map<String, dynamic> details = new Map();

  Future<void> addData(String title, String desc) async {
    print('Add data called');

    if (isLoggedIn()) {
      FirebaseFirestore.instance
          .collection('Data')
          .add(createMapObject(title, desc))
          .catchError((e) {
        print(e);
      });
    } else {
      print('Please login');
    }
  }

  static Future<Stream<QuerySnapshot>> getData() async {
    print('data found on firestore');
    return FirebaseFirestore.instance.collection('Data').snapshots();
  }

  bool updateData(selectedDoc, String title, String desc) {
    bool result = true;
    FirebaseFirestore.instance
        .collection('Data')
        .doc(selectedDoc)
        .update(createMapObject(title, desc))
        .catchError((e) {
      result = false;
      print(e);
    });
    return result;
  }

  bool deleteData(selectedDoc) {
    bool result = true;
    FirebaseFirestore.instance
        .collection('Data')
        .doc(selectedDoc)
        .delete()
        .catchError((e) {
      result = false;
      print(e);
    });
    return result;
  }

  createMapObject(String title, String desc) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    note = new Note(title, formattedDate, desc);
    return note.toMap();
  }
}
