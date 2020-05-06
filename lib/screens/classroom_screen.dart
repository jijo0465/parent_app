import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassroomScreen extends StatelessWidget {
  const ClassroomScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                color: Colors.black,
              ),
              SizedBox(height: 12),
              Container(child: Text(
                'Discussions',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),),
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('books').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return new Text('Loading...');
                  return new ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return new ListTile(
                        title: new Text(document['title']),
                        subtitle: new Text(document['author']),
                      );
                    }).toList(),
                  );
                },
              )
            ],
          ),
    );
  }
}