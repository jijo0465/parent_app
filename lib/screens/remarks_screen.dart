import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/models/remark.dart';
import 'package:parent_app/models/teacher.dart';

class RemarksScreen extends StatefulWidget {
  const RemarksScreen({Key key}) : super(key: key);

  @override
  _RemarksScreenState createState() => _RemarksScreenState();
}

class _RemarksScreenState extends State<RemarksScreen> {
  List<Remark> remark = [];
  static Map<String, dynamic> teacherDetails = {
    "id": 005,
    "teacherId": 1010,
    "name": "Bhanumathi"
  };
  static Teacher teacher = Teacher.fromMap(teacherDetails);

  Map<String, dynamic> remarkDetails = {
    "id": 001,
    "remarks": "Classil mulli vachu!!",
    "teacher": teacher
  };
  @override
  void initState() {
    remark.add(Remark.fromMap(remarkDetails));
    remark.add(Remark.fromMap(remarkDetails));
    remark.add(Remark.fromMap(remarkDetails));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              DigiCampusAppbar(
                  icon: Icons.close,
                  onDrawerTapped: () {
                    Navigator.of(context).pop();
                  }),
              SizedBox(height: 12),
              DigiScreenTitle(text: 'Student Remarks'),
              SizedBox(height: 12),
              Expanded(
                child: ListView.builder(itemCount: remark.length,itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(child: Text('${index + 1}.')),
                                Container(
                                    child: Text('${remark[index].remarks}',
                                        overflow: TextOverflow.ellipsis))
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  child: Text('Remark from ${remark[index].teacher.name}')),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          )),
    );
  }
}
