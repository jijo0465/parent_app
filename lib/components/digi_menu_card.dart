import 'package:flutter/material.dart';

class DigiMenuCard extends StatelessWidget {
  const DigiMenuCard(
      {Key key, this.menuIcon, this.title, this.subtitle, this.value})
      : super(key: key);
  final IconData menuIcon;
  final String title, subtitle, value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 12,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                      width: 75,
                      height: 75,
                      child: Card(
                          elevation: 5,
                          color: Colors.blueGrey,
                          child: Icon(menuIcon))),
                  Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Column(
                          children: <Widget>[Text(title), Text(subtitle)]))
                ],
              ),
              Container(padding: EdgeInsets.only(top: 20), child: Text(value)),
            ],
          )),
    );
  }
}
