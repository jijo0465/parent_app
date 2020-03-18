import 'package:flutter/material.dart';

class DigiAppbar extends StatelessWidget {
  const DigiAppbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: BackgroundClipper(),
        child: Container(
          padding: EdgeInsets.only(top: 35),
          color: Colors.blue[800],
          height: 200,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      child: Text(
                        'Christ Nagar Public School Nalanchira',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      )),
                  Container(
                    padding: EdgeInsets.only(right: 12),
                    child: IconButton(
                      onPressed: () {
                        print('Pressed');
                      },
                      icon: Icon(Icons.notifications),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 12),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hi Parent',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      )),
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/sir.jpg',
                          ),
                        ),
                        shape: BoxShape.circle
                        ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 35.0;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height - roundnessFactor, roundnessFactor,
        size.height - roundnessFactor);
    path.lineTo(size.width - roundnessFactor, size.height - roundnessFactor);
    path.quadraticBezierTo(
        size.width, size.height - roundnessFactor, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}