import 'package:flutter/material.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:page_turn/page_turn.dart';
import 'package:parent_app/components/digicampus_appbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class SchoolDiaryScreen extends StatefulWidget {
  const SchoolDiaryScreen({Key key}) : super(key: key);

  @override
  _SchoolDiaryScreenState createState() => _SchoolDiaryScreenState();
}

class _SchoolDiaryScreenState extends State<SchoolDiaryScreen>
    with TickerProviderStateMixin {
  final _pageTurnController = GlobalKey<PageTurnState>();
  DatePickerController _datePickerController = DatePickerController();
  CalendarController _calendarController;
  // AnimationController _animationController;

  Image diaryImage;

  Map<String, dynamic> diary;
  final List<Map> subjectList = [
    {
      "0": "Class Test",
      "1": "2020-06-02",
      "2": "Java",
      "3": "0",
      "4": "<Event detail>",
    },
    {
      "0": "Class Test",
      "1": "2020-05-05",
      "2": "Android",
      "3": "0",
      "4": "<Event detail>",
    },
    {
      "0": "Class Test",
      "1": "2020-06-06",
      "2": "Java",
      "3": "0",
      "4": "<Event detail>",
    },
    {
      "0": "Mid-Term",
      "1": "2020-06-07",
      "2": "Java",
      "3": "1",
      "4": "<Event detail>",
    },
    {
      "0": "Class Test",
      "1": "2020-06-08",
      "2": "Java",
      "3": "0",
      "4": "<Event detail>",
    },
    {
      "0": "Mid-Term",
      "1": "2020-06-12",
      "2": "Java",
      "3": "1",
      "4": "<Event detail>",
    },
    {
      "0": "Class Test",
      "1": "2020-06-15",
      "2": "Java",
      "3": "0",
      "4": "<Event detail>",
    }
  ];

  // DateTime date;
  int i;
  DateTime startDate;
  // DateTime endDate;
  DateTime selectedDate;
  // double x;
  // double x1;
  // double x2;
  // double y;
  // double z;
  // double tempValue;
  Duration duration = Duration(milliseconds: 300);
  int diaryPage;
  // int tweenFlag = 3;
  bool isUnavailableDay = false;
  Comparator<dynamic> dateComparator =
      (a, b) => DateTime.parse(a['1']).compareTo(DateTime.parse(b['1']));
  // List<Widget> childrenPages = <Widget>[];
  // T transform(double t);

  @override
  void initState() {
    initializeDateFormatting();
    diaryImage = Image.asset('assets/images/diary_1.png');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calendarController = CalendarController();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 350),
    // );
    // _animationController.forward();
    startDate = DateTime(2019, 05, 15);
    // endDate = DateTime.now().add(Duration(days: 2));
    selectedDate = DateTime.now();
    // date = selectedDate;
    diaryPage = selectedDate.day % 6;
    print(diaryPage);

    subjectList.sort(dateComparator);
    print(diary);
    setState(() {
      diary = Map<String, dynamic>.from(subjectList.elementAt(diaryPage));
    });
    });
    // x = 0;
    // y = 0;
    // z = 0.002;
    // x1 = -0.010;
    // x2 = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(diaryImage.image, context);
  }

  @override
  void dispose() {
    _calendarController.dispose();
    // _animationController.dispose();
    // _pageTurnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            DigiCampusAppbar(
              icon: Icons.close,
              onDrawerTapped: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 12),
            Container(
              // height: 50,
              margin: EdgeInsets.only(left:20,right:20),
              child: DatePicker(
                selectedDate,
                // initialSelectedDate: selectedDate,
                controller: _datePickerController,
                width: 60,
                height: 80,
                selectedTextColor: Colors.white,
                selectionColor: Colors.red[300],
                onDateChange: (date) {
                  // setState(() {
                  // selectedDate = date;
                  // diaryPage = date.day % 6;
                    _animateDiaryPages(date);
                  // _pageTurnController.currentState.goToPage(diaryPage);
                  // diary = Map<String, dynamic>.from(
                  //     subjectList
                  //         .elementAt(diaryPage));
                  // print(diaryPage);
                // });
                },
              )
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    // alignment: Alignment.topLeft,
                    // height: 500,
                    // width: 20,
                    child: Image(
                      image: diaryImage.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    height: 410,
                    width: MediaQuery.of(context).size.width - 90,
                    margin: EdgeInsets.only(top:55,left: 60, right: 30),
                    child: PageTurn(
                        cutoff: 0.7,
                        duration: Duration(milliseconds: 700),
                        initialIndex: selectedDate.day%6,
                        key: _pageTurnController,
                        backgroundColor: Color(0xffcdbc86),
                        showDragCutoff: false,
                        // lastPage: Container(
                        //     child: Center(
                        //         child: Text('Last Page!'))),
                        children: <Widget>[
                          for (var i = 1; i < 6; i++) _diaryPages(i)
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12)
          ],
        ),
      ),
    );
  }

  _animateDiaryPages(DateTime date) {
    setState(() {
      diaryPage = date.day % 6;
    if(date.month < selectedDate.month) {
      for(i=0;i<3;i++)  {
        _pageTurnController.currentState.previousPage();  }
        _pageTurnController.currentState.goToPage(diaryPage+1);
        _pageTurnController.currentState.previousPage();
     } 
    else if(date.month > selectedDate.month) {
      for(i=0;i<3;i++)  {
        _pageTurnController.currentState.nextPage();  }
        _pageTurnController.currentState.goToPage(diaryPage-1);
        _pageTurnController.currentState.nextPage();
    }
    else {
      if(date.day > selectedDate.day)
      {
        if(date.day - selectedDate.day <5) {
          for(i=0; i<date.day - selectedDate.day; i++)  {
            _pageTurnController.currentState.nextPage();  }
        }
        else {
          for(i=0;i<3;i++)  {
            _pageTurnController.currentState.nextPage();  }
            _pageTurnController.currentState.goToPage(diaryPage-1);
            _pageTurnController.currentState.nextPage();
        }
      }
      else {
        if(date.day - selectedDate.day > -5) {
          for(i=0; i<selectedDate.day - date.day; i++)  {
            _pageTurnController.currentState.previousPage();  }
        }
        else {
          for(i=0;i<3;i++)  {
            _pageTurnController.currentState.previousPage();  }
            _pageTurnController.currentState.goToPage(diaryPage+1);
            _pageTurnController.currentState.previousPage();
        }
      }
    } 
    selectedDate = date;
    });
  }

  // Widget _animateDiary(var i) {
  //   return i == 0
  //       ? Container(
  //           // margin: EdgeInsets.only(left: 12),
  //           padding: EdgeInsets.all(12),
  //           width: MediaQuery.of(context).size.width,
  //           height: 500,
  //           child: Image(
  //             image: AssetImage('assets/images/diary_0.png'),
  //             fit: BoxFit.fill,
  //           ),
  //         )
  //       : _diaryPages();
  // }

  Widget _diaryPages(int i) {
    return Container(
      color: Color(0xffcdbc86),
      // height: 500,
      // width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 20,left: 30, right: 30),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    backgroundBlendMode: BlendMode.overlay
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(selectedDate.month == 1 
                        ? 'JAN' 
                        : selectedDate.month == 2 ? 'FEB'
                        : selectedDate.month == 3 ? 'MAR'
                        : selectedDate.month == 4 ? 'APR'
                        : selectedDate.month == 5 ? 'MAY'
                        : selectedDate.month == 6 ? 'JUN'
                        : selectedDate.month == 7 ? 'JUL'
                        : selectedDate.month == 8 ? 'AUG'
                        : selectedDate.month == 9 ? 'SEP'
                        : selectedDate.month == 10 ? 'OCT'
                        : selectedDate.month == 11 ? 'NOV'
                        : 'DEC',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),),
                        // textScaleFactor: 2,),
                      Text(
                        '${selectedDate.day}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        textScaleFactor: 3,
                      ),
                    ],
                  ),

                )
              ],
            ),
            // width: double.infinity,
            // height: 150,
            // padding: EdgeInsets.all(12),
            // margin: EdgeInsets.only(left: 20, right: 60),
            // child: TableCalendar(
            //   dayHitTestBehavior: HitTestBehavior.translucent,
            //   daysOfWeekStyle: DaysOfWeekStyle(
            //       weekdayStyle: TextStyle(
            //           color: Colors.black, fontWeight: FontWeight.bold),
            //       weekendStyle: TextStyle(
            //           color: Colors.red, fontWeight: FontWeight.bold)),
            //   // rowHeight: 0.25,
            //   // simpleSwipeConfig: ,
            //   // dayHitTestBehavior: null,
            //   calendarController: _calendarController,
            //   formatAnimation: FormatAnimation.slide,
            //   // availableGestures: AvailableGestures.all,
            //   initialCalendarFormat: CalendarFormat.week,
            //   availableCalendarFormats: {
            //     CalendarFormat.week: 'Week',
            //     CalendarFormat.twoWeeks: '2 Weeks'
            //   },
            //   calendarStyle: CalendarStyle(
            //     weekdayStyle: TextStyle(
            //       color: Colors.black,
            //     ),
            //     outsideStyle: TextStyle(
            //       color: Colors.grey,
            //       fontStyle: FontStyle.italic,
            //       decorationStyle: TextDecorationStyle.dotted,
            //     ),
            //     selectedColor: Theme.of(context).primaryColor,
            //     highlightSelected: true,
            //     selectedStyle:
            //         TextStyle(color: Colors.red[300], fontSize: 16),
            //     todayColor: Colors.blue[800],
            //   ),
            //   headerVisible: false,
            //   headerStyle: HeaderStyle(
            //       // centerHeaderTitle: true,
            //       formatButtonTextStyle:
            //           TextStyle(fontSize: 12, color: Colors.white),
            //       titleTextStyle: TextStyle(
            //           fontSize: 17,
            //           fontWeight: FontWeight.w600,
            //           color: Colors.white)),
            //   onHeaderTapped: (date) {
            //     showMonthPicker(
            //             context: context,
            //             initialDate: date,
            //             firstDate: startDate,
            //             lastDate: endDate)
            //         .then((date) {
            //       selectedDate = date;
            //       //updateCalendar();
            //     });
            //   },
            //   onDaySelected: (date, list) {
            //     print('object');
            //     setState(() {
            //       selectedDate = date;
            //       diaryPage = date.day % 6;
            //       _pageTurnController.currentState.goToPage(diaryPage);
            //       // diary = Map<String, dynamic>.from(
            //       //     subjectList
            //       //         .elementAt(diaryPage));
            //       // print(diaryPage);
            //     });
            //   },
            //   onUnavailableDaySelected: () {
            //     setState(() {
            //       isUnavailableDay = true;
            //     });
            //   },
            // ),
          ),
          Expanded(
            child: Container(
              // alignment: Alignment.topLeft,
              // margin: EdgeInsets.only(left: 30, right: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Divider(
                    height: 0,
                    color: Colors.deepOrange[300],
                    thickness: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('0 : ${diary['0']}'),
                  ),
                  Divider(
                    height: 4,
                    color: Colors.deepOrange[300],
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('1 : ${diary['4']}'),
                  ),
                  Divider(
                    height: 4,
                    color: Colors.deepOrange[300],
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('2 : ${diary['2']}'),
                  ),
                  Divider(
                    height: 4,
                    color: Colors.deepOrange[300],
                    thickness: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('3 : ${diary['3']}'),
                  ),
                  Divider(
                    height: 4,
                    color: Colors.deepOrange[300],
                    thickness: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
