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
  final TextEditingController _textFieldController =
      new TextEditingController();
  Student _selectedStudent;
  List<Widget> discussionListWidget = [];
  List<DocumentSnapshot> _items;
  List<Map<String, dynamic>> commentData = [];
  DocumentSnapshot addItem;
  Grade grade = Grade.empty();
  int id = 4001;
  int widgetIndex;
  Firestore firestore = Firestore.instance;
  Color color = Colors.grey;

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
        height: 100,
        width: double.infinity,
        color: Colors.black,
      ),
      SizedBox(height: 12),
      Text(
        'Discussions',
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      SizedBox(
        height: 12,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 60,
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: TextField(
              onChanged: (text) {
                if (text == '') {
                  setState(() {
                    color = Colors.grey;
                  });
                } else {
                  setState(() {
                    color = Colors.deepOrange[300];
                  });
                }
              },
              controller: _textFieldController,
              // textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.start,
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: 'add to discussions...',
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    _addToDiscussions(_textFieldController.text);
                    _textFieldController.clear();
                  },
                  icon: Icon(Icons.camera_alt),
                  color: Colors.blue,
                ),
              ),

              // autofocus: true,
              // onSubmitted: (text) {
              //   // print(text);
              //   _addToDiscussions(text);
              //   _textFieldController.clear();
              //   // text = '';
              // },
            ),
          ),
          Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[300]),
              child: GestureDetector(
                child: Icon(Icons.send, color: color),
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _addToDiscussions(_textFieldController.text);
                  _textFieldController.clear();
                  setState(() {
                    color = Colors.grey;
                  });
                },
              ))
        ],
      ),
      SizedBox(height: 12),
      StreamBuilder<QuerySnapshot>(
          // key: _key,
          stream: firestore.collection('classroom_${grade.id}').snapshots(),
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
              // print('item: ${_items[0]}');
              // setState(() {
              // AnimatedList.of(context).insertItem(0);
              // Future.delayed(Duration(milliseconds: 200))
              //     .then((value) => _listKey.currentState.insertItem(0));

              // });
              // return listItem(_items[0]);'
              // commentData.addAll(_items[0]['']['']);
              return Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children: discussionListWidget.reversed.toList())
                      // child: listItem(_items[0]['disussion'])
                      ));
            }
          }),
    ]));
  }

  listItem(List<DocumentSnapshot> item) {
    for (; widgetIndex < item[0]['disussion'].length; widgetIndex++) {
      commentData.insert(widgetIndex, {
        'comment': item[0]['disussion'][widgetIndex]['comment'],
        'date': item[0]['disussion'][widgetIndex]['date']
      });

      print(commentData[widgetIndex]['comment']);
      // print('itemval: ${item[0]['disussion'][widgetIndex]['comment']}');
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
          indent: 5,
          endIndent: 5,
          color: Colors.black38,
          // thickness: 2,
        )
      ]));
    }
  }

  _addToDiscussions(String text) async {
    var comment = [
      {'comment': text, 'date': DateTime.now().toUtc()}
    ];
    DocumentReference documentReference =
        firestore.collection('classroom_${grade.id}').document('Session_1');
    firestore.runTransaction((transaction) async {
      await transaction.update(
          documentReference, {'disussion': FieldValue.arrayUnion(comment)});
    });
    // documentReference.get().then((doc){
    //   if(doc.exists){
    //     documentReference.updateData({'disussion':FieldValue.arrayUnion(comment)});
    //   }else{
    //     documentReference.setData({'disussion':FieldValue.arrayUnion(comment)});
    //   }
    // });
  }
}
