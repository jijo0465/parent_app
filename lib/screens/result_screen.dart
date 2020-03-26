import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digi_subject_bar.dart';
import 'package:parent_app/components/digi_graph_chart.dart';
import 'package:parent_app/components/digi_time_line.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
  //String percentTitle = titleList.first;
  int subjectIndex = 0;
  double percentValue = 0.65;
  double percentage;
  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    _pageController.addListener(() {
      print('gasd');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    percentage=percentValue*100;
    return Scaffold(
        // appBar: AppBar(
        //     title: Text('Result',
        //         style: TextStyle(
        //             backgroundColor: Colors.blue,
        //             color: Colors.black87,
        //             fontWeight: FontWeight.bold))),
        body: Stack(
      children: <Widget>[
        PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                SizedBox(height: 100),
                DigiScreenTitle(text: 'Mark History'),
                SizedBox(height: 12),
                Container(
                    child: LinearPercentIndicator(
                  percent: percentValue,
                  center: Text(title+'\t:\t$percentage%',
                      style: TextStyle(fontSize: 12.0)),
                  width: MediaQuery.of(context).size.width-10,
                  lineHeight: 15.0,
                  animation: true,
                  animationDuration: 600,
                  backgroundColor: Colors.grey,
                  progressColor: (percentValue >= 0.90)
                      ? Colors.green[900]
                      : (percentValue >= 0.80
                          ? Colors.green[700]
                          : (percentValue >= 0.70)
                              ? Colors.orangeAccent
                              : (percentValue >= 0.60)
                                  ? Colors.yellow[400]
                                  : Colors.red),
                )),
                SizedBox(height: 12),
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
                              isSelected: index == subjectIndex,
                              onPressed: () {
                                title = titleList.elementAt(index);
                                switch (index) {
                                  case 0:
                                    setState(() {
                                      selectedSubject = Subjects.All;
                                      subjectIndex = 0;
                                    });
                                    break;
                                  case 1:
                                    setState(() {
                                      selectedSubject = Subjects.Mathematics;
                                      subjectIndex = 1;
                                    });
                                    break;
                                  case 2:
                                    setState(() {
                                      selectedSubject = Subjects.English;
                                      subjectIndex = 2;
                                    });
                                    break;
                                  case 3:
                                    setState(() {
                                      selectedSubject = Subjects.Social;
                                      subjectIndex = 3;
                                    });
                                    break;
                                  case 4:
                                    setState(() {
                                      selectedSubject = Subjects.Science;
                                      subjectIndex = 4;
                                    });
                                    break;
                                  case 5:
                                    setState(() {
                                      selectedSubject = Subjects.Malayalam;
                                      subjectIndex = 5;
                                    });
                                    break;
                                  case 6:
                                    setState(() {
                                      selectedSubject = Subjects.Hindi;
                                      subjectIndex = 6;
                                    });
                                    break;
                                }
                              },
                            );
                          }),
                        ))),
                SizedBox(height: 12),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 30,
                    alignment: Alignment.topCenter,
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          //backgroundColor: Colors.black26,
                          color: Colors.blue[900]),
                    )),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      height: 250,
                      width: (MediaQuery.of(context).size.width) - 20,
                      child: Charts(index: subjectIndex),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear);
                  },
                  child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      alignment: Alignment.center,
                      child: Text(
                        '${selectedSubject.toString().replaceFirst('Subjects.', '')} History',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                ),
              ]),
            ),
            Column(
              children: <Widget>[
                Container(
                  height: 120 - MediaQuery.of(context).padding.top,
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                ),
                SizedBox(
                  height: 12,
                ),
                DigiScreenTitle(
                    text:
                        '${selectedSubject.toString().replaceFirst('Subjects.', '')} History'),
                SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  width: (MediaQuery.of(context).size.width),
                  height: MediaQuery.of(context).size.height - 120 - 30 - 12,
                  child: TimelinePage(
                    title: 'Last Month Results',
                    onDismissed: () {
                      _pageController.animateToPage(0,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.linear);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        DigiCampusAppbar(
          icon: Icons.close,
          onDrawerTapped: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ));
  }
}
