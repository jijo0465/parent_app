import 'package:flutter/material.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:parent_app/components/digi_subject_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parent_app/models/grade.dart';

enum Subjects { Mathematics, English, Social, Science, Malayalam, Hindi }

class KnowledgeBaseScreen extends StatefulWidget {
  const KnowledgeBaseScreen({Key key}) : super(key: key);

  @override
  _KnowledgeBaseScreenState createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends State<KnowledgeBaseScreen> {
  Firestore firestore = Firestore.instance;
  Subjects selectedSubject = Subjects.Mathematics;
  Grade grade = Grade.empty();
  List<DocumentSnapshot> _subjects;
  DocumentSnapshot subjectItem;
  static List<String> titleList = [
    'All',
    'Maths',
    'English',
    'Social',
    'Science',
    'Malayalam',
    'Hindi'
  ];
  String title = titleList.elementAt(1);
  //String percentTitle = titleList.first;
  int subjectIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    grade.setId(4001);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          DigiCampusAppbar(
              icon: Icons.close,
              onDrawerTapped: () {
                Navigator.of(context).pop();
              }),
          SizedBox(height: 12),
          Text('Notes & Discussion Materials'),
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
                      if (index == 0)
                        return Container();
                      else
                        return DigiSubjectBar(
                          index: index,
                          isSelected: index == subjectIndex,
                          onPressed: () {
                            title = titleList.elementAt(index);
                            switch (index) {
                              // case 0:
                              //   setState(() {
                              //     selectedSubject = Subjects.All;
                              //     subjectIndex = 0;
                              //   });
                              //   break;
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                // key: _key,
                // stream: firestore.collection('classroom_${grade.id}').snapshots(),
                stream:
                    firestore.collection('classroom_${grade.id}').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    );
                  else {
                    _subjects = snapshot.data.documents;
                    for (int i = 0; i < _subjects.length; i++)
                      if (_subjects[i].documentID == 'subject_$subjectIndex')
                        subjectItem = _subjects[i];
                    // return viewList(subjectItem);
                    return Column(
                      children:
                          List.generate(subjectItem['chapter'].length, (index) {
                        // print(subjectItem['chapter'].length);
                        // print('${subjectItem['chapter'][index]['name']}');
                        return 
                        subjectItem.documentID=='subject_$subjectIndex'
                        ? GestureDetector(
                          // onTap: ,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 8,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.5),
                                child: IntrinsicHeight(
                                    child: Row(children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            bottomLeft: Radius.circular(12)),
                                        color: Colors.orange[200],
                                      ),
                                      child: Text(
                                        '${index+1} .',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                      // Column(
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.center,
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: <Widget>[
                                      //     Text(
                                      //       "12",
                                      //       style: TextStyle(fontSize: 28),
                                      //     ),
                                      //     Text(
                                      //       "Sep",
                                      //       style: TextStyle(fontSize: 16),
                                      //     )
                                      //   ],
                                      // ),
                                      ),
                                  Expanded(
                                    child: Text(
                                      subjectItem['chapter'][index]['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.deepOrange[300],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]))))
                              : Text('No Inputs Yet!');
                      }),
                    );
                    // _items = snapshot.data.documents;
                    // listItem(_items);
                    // print('item: ${_items[0]}');
                    // setState(() {
                    // AnimatedList.of(context).insertItem(0);
                    // Future.delayed(Duration(milliseconds: 200))
                    //     .then((value) => _listKey.currentState.insertItem(0));

                    // });
                    // return listItem(_items[0]);'
                    // commentData.addAll(_items[0]['']['']);
                    // return (_items.isNotEmpty)
                    //     ? Expanded(
                    //         child: SingleChildScrollView(
                    //             child: Column(
                    //                 children: discussionListWidget.reversed.toList())
                    //             // child: listItem(_items[0]['disussion'])
                    //             ))
                    // : Container(child: Text('No Discussions yet!!'));
                  }
                }),
          ),
          // Expanded(
          //   child: AnimatedList(
          //     itemBuilder: (BuildContext context, int index,
          //         Animation<double> animation) {
          //       // return CardItem(
          //       //   animation: animation,
          //       //   item: _list[index],
          //       //   selected: _selectedItem == _list[index],
          //       //   onTap: () {
          //       //     setState(() {
          //       //       _selectedItem =
          //       //           _selectedItem == _list[index] ? null : _list[index];
          //       //     });
          //       //   },
          //       return Padding(
          //           padding: const EdgeInsets.all(2.0),
          //           child: SizeTransition(
          //               axis: Axis.vertical,
          //               sizeFactor: animation,
          //               child: GestureDetector(
          //                   behavior: HitTestBehavior.opaque,
          //                   onTap: () {
          //                     setState(() {
          //                       subjectIndex = index;
          //                     });
          //                     // setState(() {
          //                     //   _selectedItem = _selectedItem == _list[index]
          //                     //       ? null
          //                     //       : _list[index];
          //                     // });
          //                   },
          //                   child: Card(
          //                     child: ,
          //                   ))));
          //     },
          //     // itemCount: 1,
          //     // itemBuilder: (BuildContext context, int index) {
          //     // return ;
          //     //  },
          //   ),
          // )
        ],
      ),
    );
  }

  Widget viewList(DocumentSnapshot subject) {
    return SingleChildScrollView(
      // controller: controller,
      child: Column(
        children: <Widget>[],
      ),
    );
  }

  // Widget _buildDiscussionList(
  //     BuildContext context, int index, Animation<double> animation) {
  //   return CardItem(
  //     animation: animation,
  //     item: _list[index],
  //     selected: _selectedItem == _list[index],
  //     onTap: () {
  //       setState(() {
  //         _selectedItem = _selectedItem == _list[index] ? null : _list[index];
  //       });
  //     },
  //   );
  // }
}
