import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_key_value_display.dart';
import 'package:parent_app/components/digicampus_appbar.dart';

class HomeworksScreen extends StatefulWidget {
  const HomeworksScreen({Key key}) : super(key: key);

  @override
  _HomeworksScreenState createState() => _HomeworksScreenState();
}

class _HomeworksScreenState extends State<HomeworksScreen> {
  final List<Map> worksList = [
    {
      "create": "Homework",
      "topic": "Mjiv sahfbgu asvhbszhv",
      "subject": "Java",
      "subdate": "2020-06-02",
    },
    {
      "create": "HomeWork",
      "topic": "Dcgavsc hiWGBF IY",
      "subject": "Android",
      "subdate": "2020-05-05",
    },
    {
      "create": "HomeWork",
      "topic": "Edfutwf uyqrwtf yqwugfrrw as",
      "subject": "Java",
      "subdate": "2020-06-07",
    },
    {
      "create": "Assignment",
      "topic": "Ey ede r ewfaaef",
      "subject": "Java",
      "subdate": "2020-06-06",
    },
    {
      "create": "Homework",
      "topic": "Wer tdfas gakfjsrhrfar",
      "subject": "Java",
      "subdate": "2020-06-08",
    },
    {
      "create": "Assignment",
      "topic": "Lsuiudgrf waifeguwe",
      "subject": "Java",
      "subdate": "2020-06-12",
    },
    {
      "create": "Homework",
      "topic": "eOWIG FBVqduywu wrfESdc",
      "subject": "Java",
      "subdate": "2020-06-12",
    }
  ];

  final List<Map> assignments = [];
  final List<Map> homeworks = [];
  // bool assignment = false;
  bool assignmentTapped = false;
  bool homeworksTapped = false;
  Comparator<dynamic> dateComparator =
      (a, b) => DateTime.parse(a['subdate']).compareTo(DateTime.parse(b['subdate']));

  @override
  void initState() {
    // TODO: implement initState
    // worksList.forEach((create) {
    //   if (create.containsValue("Assignment")) {
    //     setState(() {
    //       assignment = true;
    //     });
    //   }
    // });
    // print(assignment);
    worksList.sort(dateComparator);
    print(worksList);
    List.generate(worksList.length, (index) {
      (worksList[index]['create'] == 'Assignment')
          ? assignments.add(worksList[index])
          : homeworks.add(worksList[index]);
    });
    // worksList.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
                child: Column(
              children: <Widget>[
                DigiCampusAppbar(
                  icon: Icons.close,
                  onDrawerTapped: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      assignmentTapped = !assignmentTapped;
                    });
                  },
                  child: Column(
                    children: (assignments.isEmpty)
                        ? <Widget> [Container()]
                        : <Widget>[
                            Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      Colors.blue[400],
                                      Colors.blue[600],
                                      Colors.blue[200]
                                    ])),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Assignments',
                                      style: TextStyle(
                                          color: Colors.green[900],
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                        width: (MediaQuery.of(context)
                                                .size
                                                .width) /
                                            3),
                                    Icon(Icons.details,
                                        color: Colors.green[600], size: 24)
                                  ],
                                )),
                            Container(
                                color: Colors.white,
                                height: (assignmentTapped) ? null : 0,
                                child: Column(
                                  children: List.generate(
                                      assignments.length,
                                      (index) => new Card(
                                            color: Colors.grey,
                                            child: Column(
                                              children: <Widget>[
                                                DigiKeyValueDisplay(
                                                    textKey: 'Subject ',
                                                    textValue:
                                                        ' ${assignments[index]['subject']}'),
                                                DigiKeyValueDisplay(
                                                    textKey: 'Topic ',
                                                    textValue:
                                                        ' ${assignments[index]['topic']}'),
                                                DigiKeyValueDisplay(
                                                    textKey: 'Submission Date ',
                                                    textValue:
                                                        ' ${assignments[index]['subdate']}'),
                                              ],
                                            ),
                                          )),
                                ))
                          ],
                  ),
                )
              ],
            )),
            GestureDetector(
              onTap: () {
                setState(() {
                  homeworksTapped = !homeworksTapped;
                });
              },
              child: Container(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(colors: [
                            Colors.blue[400],
                            Colors.blue[600],
                            Colors.blue[200]
                          ])),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Homeworks',
                            style: TextStyle(
                                color: Colors.green[900], fontSize: 20),
                          ),
                          SizedBox(
                              width: (MediaQuery.of(context).size.width) / 3),
                          Icon(Icons.details,
                              color: Colors.green[600], size: 24)
                        ],
                      )),
                  Container(
                      height: (homeworksTapped) ? null : 0,
                      color: Colors.black,
                      child: Column(
                          children: List.generate(
                              homeworks.length,
                              (index) => new Card(
                                    color: Colors.grey,
                                    child: Column(
                                      children: <Widget>[
                                        DigiKeyValueDisplay(
                                            textKey: 'Subject ',
                                            textValue:
                                                ' ${homeworks[index]['subject']}'),
                                        DigiKeyValueDisplay(
                                            textKey: 'Topic ',
                                            textValue:
                                                ' ${homeworks[index]['topic']}'),
                                        DigiKeyValueDisplay(
                                            textKey: 'Submission Date ',
                                            textValue:
                                                ' ${homeworks[index]['subdate']}'),
                                      ],
                                    ),
                                  ))))
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
