import 'package:flutter/material.dart';
import 'package:parent_app/components/menu_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen
  ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return SliverAppBar()
    return Scaffold(
      appBar: AppBar(
        title: Text('Parent App'),
      ),
      body:Column(
      children:[MenuCard(menuIcon:Icons.accessibility_new,title:'Bus No',subtitle:'15',value:'Track School Bus'),
        MenuCard(menuIcon:Icons.account_balance,title:'Bus No',subtitle:'15',value:'Track School Bus'),
        MenuCard(menuIcon:Icons.add_box,title:'Bus No',subtitle:'15',value:'Track School Bus'),
        MenuCard(menuIcon:Icons.add_to_photos,title:'Bus No',subtitle:'15',value:'Track School Bus')
      ]));
  }
}