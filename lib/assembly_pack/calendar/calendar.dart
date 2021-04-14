import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(CalendarDemo());

class CalendarDemo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            const Hero(
              tag: 'calendar',
              child: Icon(Icons.calendar_today),
            ),
            const Text('  日历')
          ],
        ),
      ),
      body: _CalendarDemo(),
    );
  }
}

class _CalendarDemo extends StatefulWidget {
  @override
  _CalendarDemoState createState() => _CalendarDemoState();
}

class _CalendarDemoState extends State<_CalendarDemo> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
