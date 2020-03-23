import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_screen_title.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  CalendarController _calendarController;
  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void markAttendance() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      DigiCampusAppbar(
        icon: Icons.close,
        onDrawerTapped: () {
          Navigator.of(context).pop();
        },
      ),
      SizedBox(height: 12),
      DigiScreenTitle(text: 'Attendance'),
      SizedBox(height: 12),
      Card(
        child: Container(
          padding: EdgeInsets.all(12),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(children: <Widget>[
            Container(child: Text('In-Time : 9:00 a.m.')),
            Container(child: Text('Out-Time : 3:30 p.m. ')),
          ]),
        ),
      ),
      TableCalendar(
          calendarController: _calendarController,
          formatAnimation: FormatAnimation.scale,
          availableGestures: AvailableGestures.horizontalSwipe,
          calendarStyle: CalendarStyle(
            //outsideStyle:TextStyle(color:Colors.grey,fontStyle: FontStyle.italic) ,
            selectedColor: Theme.of(context).primaryColor,
          ),
          builders: CalendarBuilders(
            dayBuilder: (context, date, _data) => Container(
                alignment: Alignment.center,
                // decoration:
                //     BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: Text(
                  date.day.toString(),
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w600),
                )),
          )),
      SizedBox(height: 12),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(onPressed: () {}, child: Text('Request Leave')),
          RaisedButton(onPressed: () {}, child: Text('Contact Teacher'))
        ],
      ),
    ]));
  }
}
