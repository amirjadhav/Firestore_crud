import 'package:auto_route/auto_route_annotations.dart';
import 'package:firestore_crud/view/ui/homepage/homepage_view.dart';
import 'package:firestore_crud/view/ui/login/login_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: HomePage),

    //MaterialRoute(page: UsersScreen, ..config),
  ],
)
class $Router {}
