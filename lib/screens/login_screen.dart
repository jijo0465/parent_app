import 'package:flutter/material.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text('Login Screen'),
            ),
            Consumer<LoginState>(
              builder: (context, value, child) {
                return RaisedButton(
                    child: Text('Log in'),
                    onPressed: () {
                      value.signIn('a', 'b');
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
