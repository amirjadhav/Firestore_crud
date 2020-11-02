import 'package:auto_route/auto_route.dart';
import 'package:firestore_crud/app/locator.dart';
import 'package:firestore_crud/app/router.gr.dart' as approute;
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: ExtendedNavigator.builder(
            router: approute.Router(),
            initialRoute: approute.Routes.loginView,
            //observers:
            navigatorKey: locator<NavigationService>().navigatorKey,
            onUnknownRoute: (RouteSettings settings) {
              return MaterialPageRoute<void>(
                settings: settings,
                builder: (BuildContext context) =>
                    Scaffold(body: Center(child: Text('Not Found'))),
              );
            }),
      ),
    );
  }
}
