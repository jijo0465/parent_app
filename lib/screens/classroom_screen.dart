import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent_app/models/grade.dart';
import 'package:parent_app/models/student.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

class ClassroomScreen extends StatefulWidget {
  // final Grade grade = Grade();
  // final Student student;

  const ClassroomScreen({Key key}) : super(key: key);

  @override
  _ClassroomScreenState createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  // final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  // var _key;
  // ListModel<int> _list;
  Student _selectedStudent;
  List<Widget> discussionListWidget = [];
  List<DocumentSnapshot> _items;
  DocumentSnapshot addItem;
  Grade grade = Grade.empty();
  int id = 4001;
  int widgetIndex;

  @override
  void initState() {
    // TODO: implement initState
    widgetIndex = 0;
    grade.setId(id);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    discussionListWidget.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StudentState state = Provider.of<StudentState>(context, listen: true);
    _selectedStudent = state.selectedstudent;
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
        height: 300,
        width: double.infinity,
        color: Colors.black,
      ),
      SizedBox(height: 12),
      Container(
        height: 40,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.blue),
        alignment: Alignment.center,
        child: Text(
          'Discussions',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      SizedBox(height: 12,),
      Container(
        height: 40,
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.start,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: 'add to discussions...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),  
          ),
          autofocus: true,
          onSubmitted: (text){
            print('submit');
            _addToDiscussions(text);
            text = '';
          },
        ),      
      ),
      StreamBuilder<QuerySnapshot>(
          // key: _key,
          stream: Firestore.instance
              .collection('classroom_${grade.id}')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              );
            else {
              _items = snapshot.data.documents;
              listItem(_items);
              print('item: ${_items[0]}');
              // setState(() {
              // AnimatedList.of(context).insertItem(0);
              // Future.delayed(Duration(milliseconds: 200))
              //     .then((value) => _listKey.currentState.insertItem(0));

              // });
              // return listItem(_items[0]);
              return Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: discussionListWidget.reversed.toList())
                      // child: listItem(_items[0]['disussion'])
                      ));
            }
          }),
    ]));
  }

  listItem(List<DocumentSnapshot> item) {
    for (; widgetIndex < item[0]['disussion'].length; widgetIndex++) {
      print('itemval: ${item[0]['disussion'][widgetIndex]['comment']}');
      discussionListWidget.add(Column(children: <Widget>[
        Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 5 / 6,
          child: Row(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                // margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: 
                      // AssetImage(''),
                        NetworkImage(
                          'https://www.sean-christopher.com/seanchristopher/wp-content/uploads/2014/10/hotforteacher.png'),
                      fit: BoxFit.fill),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(item[0]['disussion'][widgetIndex]['comment']),
                ),
              )),
            ],
          ),
        ),
        Divider(
          color: Colors.black,
          thickness: 2,
        )
      ]));
    }
  }

  _addToDiscussions(String text)
  {
    widgetIndex++;
    Firestore.instance.runTransaction((transaction) async {
    await transaction.update(Firestore.instance.collection('classroom_${grade.id}').document('session_1'), {
        'disussion' : {
          [widgetIndex] : {
            'comment': text,
            'date': DateTime.now().toUtc(),
          }
        }
      });
    });
  }
}