import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent_app/models/grade.dart';
import 'package:parent_app/models/student.dart';

class ClassroomScreen extends StatefulWidget {
  // final Grade grade = Grade();
  // final Student student;

  const ClassroomScreen({Key key}) : super(key: key);

  @override
  _ClassroomScreenState createState() => _ClassroomScreenState();
}

class _ClassroomScreenState extends State<ClassroomScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  var _key;
  // ListModel<int> _list;
  List<DocumentSnapshot> _items;
  Grade grade = Grade.empty();
  int id = 3001;

  @override
  void initState() {
    // TODO: implement initState
    grade.setId(id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: <Widget>[
      Container(
        height: 300,
        width: double.infinity,
        color: Colors.black,
      ),
      SizedBox(height: 12),
      Container(
        child: Text(
          'Discussions',
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
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
              print(_items.length);
              // setState(() {
              // AnimatedList.of(context).insertItem(0);
              Future.delayed(Duration(milliseconds: 200))
                  .then((value) => _listKey.currentState.insertItem(0));

              // });
              return Container();
            }
          }),
      // AnimatedList.of(context).insertItem(_items.length+1);
      AnimatedList(
        key: _listKey,
        initialItemCount: 0,
        // reverse: true,
        shrinkWrap: true,
        itemBuilder: (context, index, animation) {
          // var documentReference = snapshot;
          // var document = snapshot.data.documents.map(DocumentSnapshot document);
          // return ListTile(
          //   title: Text(document['title']),
          //   subtitle: Text(document['author']),
          // );
          // var discussion = documentReference[index];
          // _items = documentReference[index];
          return listItem(_items[index]);
          // Column(children: <Widget>[
          //   Container(
          //     height: 50,
          //     width: MediaQuery.of(context).size.width * 5 / 6,
          //     child: Row(
          //       children: <Widget>[
          //         Container(
          //           height: 40,
          //           width: 40,
          //           // margin: EdgeInsets.only(left: 20),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             image: DecorationImage(
          //                 image: NetworkImage(
          //                     'https://www.sean-christopher.com/seanchristopher/wp-content/uploads/2014/10/hotforteacher.png'),
          //                 fit: BoxFit.fill),
          //           ),
          //         ),
          //         Expanded(
          //             child: Container(
          //           padding: EdgeInsets.only(left: 20, right: 20),
          //           height: 50,
          //           width: MediaQuery.of(context).size.width,
          //           child: Align(
          //             alignment: Alignment.centerLeft,
          //             child: Text(discussion['discussion']),
          //           ),
          //         )),
          //       ],
          //     ),
          //   ),
          //   Divider(
          //     color: Colors.black,
          //     thickness: 2,
          //   )
          // ]);
        },
      ),
    ]));
  }

  Widget listItem(DocumentSnapshot item) {
    return Column(children: <Widget>[
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
                    image: NetworkImage(
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
                child: Text(item['discussion']),
              ),
            )),
          ],
        ),
      ),
      Divider(
        color: Colors.black,
        thickness: 2,
      )
    ]);
  }
}
