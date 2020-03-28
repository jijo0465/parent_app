import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/states/parent_state.dart';
import 'package:provider/provider.dart';

class DigiAppbar extends StatelessWidget {
  final VoidCallback onPressed;
  final ValueChanged<DragEndDetails> onDragEnd;
  final ValueChanged<DragUpdateDetails> onDrag;
  final double height;
  const DigiAppbar({Key key, this.onPressed, this.onDragEnd, this.onDrag, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: onDragEnd,
      onVerticalDragUpdate: onDrag,
      child: ClipPath(
          clipper: BackgroundClipper(),
          child: Container(
            padding: EdgeInsets.only(top: 35),
            //color: Colors.blue[800],
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/school.jpg'),
                    fit: BoxFit.fill)
                ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        onPressed: onPressed,
                        icon: Icon(Icons.dashboard),
                        color: Colors.white,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Christ Nagar',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
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
                Expanded(
                    child: Hero(tag: 'background', child: Container())),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(left: 12),
                        alignment: Alignment.centerLeft,
                        child: Consumer<ParentState>(
                          builder: (BuildContext context, ParentState value,
                              Widget child) {
                            return Text(
                              'Arjun Ajith',
                              style: TextStyle(decoration: TextDecoration.none,
                                  fontSize: 20, color: Colors.white),
                            );
                          },
                        )),
                    Hero(
                      tag: 'studentdetails',
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  Duration(milliseconds: 400),
                              pageBuilder: (_, __, ___) =>
                                  StudentDetailsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  'assets/images/girl.jpg',
                                ),
                              ),
                              shape: BoxShape.circle),
                          //child:Image.asset('images/girl.jpg')
                        ),
                      ),
                    )
                  ],
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                      child: Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.white,
                  )),
                ),
                SizedBox(height: 50)
              ],
            ),
          )),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 50.0;
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
