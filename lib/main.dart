import 'package:flutter/material.dart';
import 'package:parent_app/components/digi_chat.dart';
import 'package:parent_app/redirect.dart';
import 'package:parent_app/screens/attendance_screen.dart';
import 'package:parent_app/screens/chat_screen.dart';
import 'package:parent_app/screens/events_screen.dart';
import 'package:parent_app/screens/exams_screen.dart';
import 'package:parent_app/screens/fee_payment_screen.dart';
import 'package:parent_app/screens/result_screen.dart';
import 'package:parent_app/screens/schoolbus_screen.dart';
import 'package:parent_app/screens/student_details_screen.dart';
import 'package:parent_app/screens/in_out_screen.dart';
import 'package:parent_app/screens/timetable_screen.dart';
import 'package:parent_app/screens/homeworks_screen.dart';
import 'package:parent_app/states/login_state.dart';
import 'package:parent_app/states/parent_state.dart';
import 'package:parent_app/states/student_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(ParentApp());

class ParentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginState>(
              create: (_) => LoginState.instance()),
          ChangeNotifierProvider<ParentState>(
              create: (_) => ParentState.instance()),
          ChangeNotifierProvider<StudentState>(
              create: (_) => StudentState.instance()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Theme.of(context).primaryColor,
              accentColor: Colors.deepOrange,
              fontFamily: 'Montserrat'),
          supportedLocales: const [Locale('en')],
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: Redirect(),
          routes: <String, WidgetBuilder>{
            '/home': (context) => Redirect(),
            '/result': (context) => ResultScreen(),
            '/attendance':(context) => AttendanceScreen(),
            '/schoolbus':(context) => SchoolBusScreen(),
            '/studentdetails':(context) => StudentDetailsScreen(),
            '/inOut': (context) => InOutScreen(),
            '/timetable': (context) => TimetableScreen(),
            '/feePayment': (context) => FeePaymentScreen(),
            '/chat': (context) => ChatScreen(),
            '/digiChat': (context) => DigiChat(),
            '/exams': (context) => ExamScreen(),
            '/homeworks': (context) => HomeworksScreen(),
            '/events': (context) => EventsScreen(),
            // 'login': (context) => PhoneLoginScreen(),
            // 'owner_form': (context)=> OwnerFormScreen(),
            // 'buyer_form': (context)=> BuyerFormScreen(),
          },
        ));
  }
}
