import 'package:flutter/material.dart';
import 'package:parent_app/screens/login_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (BuildContext context, LoginState value, Widget child) {
        if(value.status == Status.Unauthenticated){
          return LoginScreen();
        }
        else{
          return Scaffold(
            appBar: AppBar(title:Text('Parent App')),
          );
        }
      },
    );
  }
}
