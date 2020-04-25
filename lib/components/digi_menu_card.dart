import 'package:flutter/material.dart';

class DigiMenuCard extends StatelessWidget {
  const DigiMenuCard(
      {Key key,
      this.onPressed,
      this.imagePath})
      : super(key: key);
  //final IconData menuIcon;
  //final String title, subtitle, value;
  final VoidCallback onPressed;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        // height: 100,
        // width: 100,
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: new BorderRadius.circular(12),
          image: DecorationImage(
              image: AssetImage(
                imagePath,
              ),
              fit: BoxFit.cover),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black54,
          //     offset: Offset(0.0, 1.0), //(x,y)
          //     blurRadius: 4.0,
          //   ),
          // ],
        ),
      ),
    );
  }
}
