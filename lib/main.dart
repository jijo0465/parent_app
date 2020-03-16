import 'package:flutter/material.dart';
import 'package:parent_app/screens/redirect.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/user_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(ParentApp());

class ParentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginState>(
              create: (_) => LoginState.instance()),
          ChangeNotifierProvider<UserState>(
              create: (_) => UserState.instance()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Theme.of(context).primaryColor,
              accentColor: Colors.deepOrange,
              fontFamily: 'Montserrat'),
          supportedLocales: const [Locale('en')],
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: Redirect(),
          routes: <String, WidgetBuilder>{
            '/home': (context) => Redirect(),
            // 'buyer_home': (context) => BuyerHomeScreen(),
            // 'login': (context) => PhoneLoginScreen(),
            // 'owner_form': (context)=> OwnerFormScreen(),
            // 'buyer_form': (context)=> BuyerFormScreen(),
          },
        ));
  }
}
