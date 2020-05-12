import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final Icon icon;
  final Color color;
  final bool isImportant;
  const HomeCard({Key key, this.icon, this.color, this.isImportant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.ac_unit,size: 40,color: Color(0xff00739e),),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child:Text('This is Menu',style: TextStyle(fontSize: 18,color: Color(0xff00739e)),)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
