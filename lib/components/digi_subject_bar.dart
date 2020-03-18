import 'package:flutter/material.dart';

class DigiSubjectBar extends StatelessWidget {
  const DigiSubjectBar({Key key, this.index}) : super(key: key);

  final int index;
  static List<Map<String,String>> subjects = [
    {'no':'0','sub':'Mathematics'},
    {'no':'1','sub':'English'},
    {'no':'2','sub':'Social'},
    {'no':'3','sub':'Science'},
    {'no':'4','sub':'Malayalam'},
    {'no':'5','sub':'Hindi'}
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
        onTap: (){
            //Individual Subject Performance as per selection from Parent
        },
        child:Container(
          width: 80,
          height: 80,
          margin: EdgeInsets.only(right:5),
          decoration: BoxDecoration(
            color: Colors.brown,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            subjects[index]['sub'],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
          textScaleFactor: 0.60,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
        )));
  }
}
