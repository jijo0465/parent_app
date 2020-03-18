import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_menu_card.dart';
import 'package:parent_app/screens/result_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  static final List<IconData> _menuIcons = [
    Icons.accessibility_new,
    Icons.account_balance,
    Icons.account_box,
    Icons.add_a_photo,
    Icons.adjust,
    Icons.airplanemode_active
  ];
  static final List<Map<String, String>> _menuInfo = [
    {'title': 'Academics', 'subtitle': '90%', 'value': 'Check Result'},
    {'title': 'Bus No', 'subtitle': '15', 'value': 'Track School Bus'},
    {'title': 'Exam', 'subtitle': 'Mar 8th', 'value': 'Upcoming Exams'},
    {'title': 'Remarks', 'subtitle': '12', 'value': 'Write Remarks to Teacher'},
    {'title': 'Tasks', 'subtitle': '8', 'value': 'Digital School Diary'},
    {'title': 'Due Date', 'subtitle': 'Jan 12', 'value': 'Pay School Fees'}
  ];
  Widget build(BuildContext context) {
    //return SliverAppBar()
    return Scaffold(
        body: 
        Column(children: [
      DigiAppbar(),
      Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          children: 
            List.generate(6, (index){
              return DigiMenuCard(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/result');
                  },
                  menuIcon: _menuIcons[index], //_menuIcons(index),
                  title: _menuInfo[index]['title'], //'Bus No',
                  subtitle: _menuInfo[index]['subtitle'],
                  value: _menuInfo[index]['value']);
            }),
        ),
      )

      // StaggeredGridView.countBuilder(
      //   crossAxisCount: 2,
      //   itemCount: _menuIcons.length,
      //   reverse: true,
      //   physics: ScrollPhysics(),
      //   itemBuilder: (BuildContext context, int index) => new Container(
      //       child: DigiMenuCard(
      //           menuIcon: _menuIcons[index], //_menuIcons(index),
      //           title: _menuInfo[index]['title'], //'Bus No',
      //           subtitle: _menuInfo[index]['subtitle'],
      //           value: _menuInfo[index]['value'])),
      //   staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 1),
      //   //mainAxisSpacing: 5.0,
      //   //crossAxisSpacing: 5.0,
      //   shrinkWrap: true,
      // ),
      //   SliverGrid.count(
      //     crossAxisCount: 2,
      //     childAspectRatio: 4,
      //     children:[DigiMenuCard(
      //             menuIcon: _menuIcons[0], //_menuIcons(index),
      //             title: _menuInfo[0]['title'], //'Bus No',
      //             subtitle: _menuInfo[0]['subtitle'],
      //             value: _menuInfo[0]['value']),
      //             DigiMenuCard(
      //             menuIcon: _menuIcons[1], //_menuIcons(index),
      //             title: _menuInfo[1]['title'], //'Bus No',
      //             subtitle: _menuInfo[1]['subtitle'],
      //             value: _menuInfo[1]['value']),
      //             DigiMenuCard(
      //             menuIcon: _menuIcons[2], //_menuIcons(index),
      //             title: _menuInfo[2]['title'], //'Bus No',
      //             subtitle: _menuInfo[2]['subtitle'],
      //             value: _menuInfo[2]['value']),
      //             DigiMenuCard(
      //             menuIcon: _menuIcons[3], //_menuIcons(index),
      //             title: _menuInfo[3]['title'], //'Bus No',
      //             subtitle: _menuInfo[3]['subtitle'],
      //             value: _menuInfo[3]['value'])])
    ]));
  }
  // DigiMenuCard(
  //     menuIcon: Icons.account_balance,
  //     title: 'Bus No',
  //     subtitle: '15',
  //     value: 'Track School Bus'),
  // DigiMenuCard(
  //     menuIcon: Icons.add_box,
  //     title: 'Bus No',
  //     subtitle: '15',
  //     value: 'Track School Bus'),}
}
