import 'package:flutter/material.dart';

class DigiScreenTitle extends StatelessWidget {
  final String text;
  const DigiScreenTitle({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 12,
                        ),
                        Text(text,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[900]),
                        ),
                        Icon(Icons.arrow_drop_down_circle,color: Colors.blue[900])
                      ],
                    ));
  }
}