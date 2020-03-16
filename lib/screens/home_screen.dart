import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_menu_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return SliverAppBar()
    return Scaffold(
        body: Column(children: [
          DigiAppbar(),
          DigiMenuCard(
              menuIcon: Icons.accessibility_new,
              title: 'Bus No',
              subtitle: '15',
              value: 'Track School Bus'),
          DigiMenuCard(
              menuIcon: Icons.account_balance,
              title: 'Bus No',
              subtitle: '15',
              value: 'Track School Bus'),
          DigiMenuCard(
              menuIcon: Icons.add_box,
              title: 'Bus No',
              subtitle: '15',
              value: 'Track School Bus'),
        ]));
  }
}
