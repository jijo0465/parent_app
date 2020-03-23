import 'package:flutter/material.dart';

class DigiCampusAppbar extends StatelessWidget {
  final VoidCallback onDrawerTapped;
  final IconData icon;
  const DigiCampusAppbar({Key key, this.onDrawerTapped, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: GestureDetector(
              onTap: onDrawerTapped,
              child: Container(
                child: Icon(icon, color: Colors.white),
              ),
            ),
          ),
          Text(
            'DigiCampus',
            style: TextStyle(
                letterSpacing: 1,
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Icon(
              Icons.notification_important,
              color: Colors.white,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50))),
      height: 100,
      width: MediaQuery.of(context).size.width,
    );
  }
}
