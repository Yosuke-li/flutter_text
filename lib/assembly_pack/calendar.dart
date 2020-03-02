import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(CalendarDemo());

class CalendarDemo extends StatelessWidget{
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('日历'),
      ),
      body: _CalendarDemo(),
    );
  }
}

class _CalendarDemo extends StatefulWidget {
  _CalendarDemoState createState() => _CalendarDemoState();
}

class _CalendarDemoState extends State<_CalendarDemo> {
  CalendarController _calendarController;

  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Widget build (BuildContext context) {
    return Column(
      children: <Widget>[
        TableCalendar(
          calendarController: _calendarController,
        ),
        Text('$_calendarController')
      ],
    );
  }
}