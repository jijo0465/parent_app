import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_appbar.dart';
import 'package:parent_app/components/digi_subject_bar.dart';
import 'package:parent_app/components/digi_graph_chart.dart';

enum Subjects { All, Mathematics, English, Social, Science, Malayalam, Hindi }

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  Subjects selectedSubject = Subjects.All;
  static List<String> titleList = [
    'Overall Performance',
    'Mathematics',
    'English',
    'Social',
    'Science',
    'Malayalam',
    'Hindi'
  ];
  String title = titleList.first;
  int subjectIndex=0;
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
                    children: List.generate(7, (index) {
                      return DigiSubjectBar(
                        index: index,
                        onPressed: () {
                          title = titleList.elementAt(index);
                          switch (index) {
                            case 0:
                              setState(() {
                                selectedSubject = Subjects.All;
                                subjectIndex=0;
                              });
                              break;
                            case 1:
                              setState(() {
                                selectedSubject = Subjects.Mathematics;
                                subjectIndex=1;
                              });
                              break;
                            case 2:
                              setState(() {
                                selectedSubject = Subjects.English;
                                subjectIndex=2;
                              });
                              break;
                            case 3:
                              setState(() {
                                selectedSubject = Subjects.Social;
                                subjectIndex=3;
                              });
                              break;
                            case 4:
                              setState(() {
                                selectedSubject = Subjects.Science;
                                subjectIndex=4;
                              });
                            break;
                            case 5:
                              setState(() {
                                selectedSubject = Subjects.Malayalam;
                                subjectIndex=5;
                              });
                            break;
                            case 6:
                              setState(() {
                                selectedSubject = Subjects.Hindi;
                                subjectIndex=6;
                              });
                            break;
                          }
                        },
                      );
                    }),
                  ))),
          Container(
              margin: EdgeInsets.only(top: 10),
              height: 30,
              alignment: Alignment.topCenter,
              child: Text(
                title,
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
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Charts(index:subjectIndex)),
            // decoration: BoxDecoration(
            //     color: Colors.indigoAccent,
            //     shape: BoxShape.rectangle,
            //     border: Border.all(color: Colors.black87, width: 2.5)),
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
