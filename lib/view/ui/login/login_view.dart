import 'package:firestore_crud/app/locator.dart';
import 'package:firestore_crud/view/ui/login/login_viewmodel.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                //color: Colors.green,
                height: 150,
                width: 150,
                child: Image(image: AssetImage(model.logoUrl)),
              ),
              SizedBox(height: 100),
              SignInButton(
                Buttons.Google,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                onPressed: () async {
                  bool _result = await model.signInWithGoogle();
                  if (_result) {
                    print('result:  $_result');
                    Navigator.pushReplacementNamed(context, '/home-page');
                  }
                },
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => locator<LoginViewModel>(),
    );
  }
}
