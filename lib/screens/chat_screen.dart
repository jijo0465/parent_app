import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_chat.dart';
import 'package:parent_app/components/digicampus_appbar.dart';

import 'package:parent_app/models/teacher.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _studentId = Provider.of<StudentState>(context).selectedstudent.id;
    List<Teacher> teachers = [
      Teacher(
          id: 2001,
          name: "Bhanumathi",
          contactNo: "9988667755",
          photoUrl: "assets/images/2001.png"),
      Teacher(
          id: 2002,
          name: "Jagathamma",
          contactNo: "9966442255",
          photoUrl: "assets/images/2002.png"),
      Teacher(
          id: 2003,
          name: "Malarr",
          contactNo: "9977887722",
          photoUrl: "assets/images/2003.png"),
    ];
    return Scaffold(
        body: Column(
      children: <Widget>[
        DigiCampusAppbar(),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // print(teachers.elementAt(index).name);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return DigiChat(teacher: teachers.elementAt(index),studentId:_studentId);
                  }));
                },
                child: Card(
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://www.sean-christopher.com/seanchristopher/wp-content/uploads/2014/10/hotforteacher.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(width: 12,),
                        Container(
                          child: Text(teachers.elementAt(index).name),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}
