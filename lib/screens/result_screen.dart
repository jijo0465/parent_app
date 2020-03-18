import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_subject_bar.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //     title: Text('Result',
        //         style: TextStyle(
        //             backgroundColor: Colors.blue,
        //             color: Colors.black87,
        //             fontWeight: FontWeight.bold))),
        body: Column(children: <Widget>[
      DigiAppbar(),
      Expanded(
        child: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              //height: 500,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return DigiSubjectBar(index: index);
                    }),
                  ))),
          Container(
              margin: EdgeInsets.only(top: 10),
              height: 30,
              alignment: Alignment.topCenter,
              child: Text(
                'Overall Performance',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.black26,
                    color: Colors.deepPurpleAccent),
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 250,
            width: (MediaQuery.of(context).size.width) - 20,
            decoration: BoxDecoration(
                color: Colors.indigoAccent,
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black87, width: 2.5)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 250,
            width: (MediaQuery.of(context).size.width) - 20,
            decoration: BoxDecoration(
                color: Colors.indigoAccent,
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.black87, width: 2.5)),
          )
        ]),
      )
    ]));
  }
}
