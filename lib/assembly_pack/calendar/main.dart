import 'dart:convert';

import 'package:flutter_text/assembly_pack/management/home_page/theme.dart';
import 'package:flutter_text/init.dart';
import 'package:intl/intl.dart';
import 'package:self_utils/init.dart';
import 'package:table_calendar/table_calendar.dart';

import 'add_form.dart';
import 'method.dart';

class WinCalendarPage extends StatefulWidget {
  const WinCalendarPage({Key? key}) : super(key: key);

  @override
  State<WinCalendarPage> createState() => _WinCalendarPageState();
}

class _WinCalendarPageState extends State<WinCalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _listenTheme();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    List<Event> res = EventHelper.getEvents(day);
    res.sort((a, b) => b.type.compareTo(a.type));
    return res;
  }

  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final DateTime d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  void _listenTheme() {
    EventBusHelper.listen<EventBusM>((EventBusM event) {
      if (event.theme != '') {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlobalStore.isMobile
          ? Column()
          : Row(
              children: [
                Expanded(
                  child: TableCalendar<Event>(
                    firstDay: DateTime(2000),
                    lastDay: DateTime(2100),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (DateTime day) =>
                        isSameDay(_selectedDay, day),
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                    ),
                    rangeSelectionMode: _rangeSelectionMode,
                    eventLoader: _getEventsForDay,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    calendarStyle: const CalendarStyle(
                      outsideDaysVisible: false,
                    ),
                    onDaySelected: _onDaySelected,
                    onRangeSelected: _onRangeSelected,
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin:
                            const EdgeInsets.only(left: 12, bottom: 5, top: 8),
                        child: Text(
                            '${DateFormat('yyyy-MM-dd').format(_selectedDay ?? DateTime.now())} 日常事项'),
                      ),
                      Visibility(
                        visible: _rangeStart == null &&
                            _rangeEnd == null,
                        child: AddFormWidget(
                        time: _selectedDay ?? DateTime.now(),
                        refresh: () {
                          _selectedEvents.value =
                              _getEventsForDay(_selectedDay ?? DateTime.now());
                        },
                      ),),
                      Expanded(
                        child: ValueListenableBuilder<List<Event>>(
                          valueListenable: _selectedEvents,
                          builder: (context, value, _) {
                            return ListView.builder(
                              itemCount: value.length,
                              itemBuilder: (context, index) {
                                final Event event = value[index];
                                return Container(
                                  height: 50,
                                  margin:
                                      const EdgeInsets.only(right: 20, top: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: GlobalStore.theme == 'light'
                                          ? HomeTheme.lightBorderLineColor
                                          : HomeTheme.darkBorderLineColor
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: event.type ==
                                                      EventType
                                                          .expire.enumToString
                                                  ? null
                                                  : event.type.stringToEnum ==
                                                      EventType.finish,
                                              tristate: event.type ==
                                                  EventType.expire.enumToString,
                                              onChanged: (bool? value) {
                                                if (event.type ==
                                                    EventType.expire.enumToString) {
                                                  return;
                                                }
                                                if (event.type ==
                                                    EventType
                                                        .finish.enumToString) {
                                                  event.type = EventType
                                                      .normal.enumToString;
                                                } else {
                                                  event.type = EventType
                                                      .finish.enumToString;
                                                }
                                                EventHelper.changeOneEvent(
                                                    event);
                                                if (_rangeStart != null &&
                                                    _rangeEnd != null) {
                                                  _selectedEvents.value =
                                                      _getEventsForRange(
                                                          _rangeStart!,
                                                          _rangeEnd!);
                                                } else {
                                                  _selectedEvents.value =
                                                      _getEventsForDay(
                                                          _selectedDay!);
                                                }
                                                setState(() {});
                                              },
                                            ),
                                            Text(
                                              '${event.desc}',
                                              style: event.type ==
                                                      EventType
                                                          .expire.enumToString
                                                  ? const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    )
                                                  : null,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            // IconButton(
                                            //   onPressed: () {},
                                            //   icon: const Icon(Icons.edit),
                                            // ),
                                            Visibility(
                                              child: IconButton(
                                                onPressed: () {
                                                  ModalText.tipToast(context,
                                                      onFunc: () {
                                                    event.type = EventType
                                                        .expire.enumToString;
                                                    EventHelper.changeOneEvent(
                                                        event);
                                                    if (_rangeStart != null &&
                                                        _rangeEnd != null) {
                                                      _selectedEvents.value =
                                                          _getEventsForRange(
                                                              _rangeStart!,
                                                              _rangeEnd!);
                                                    } else {
                                                      _selectedEvents.value =
                                                          _getEventsForDay(
                                                              _selectedDay!);
                                                    }
                                                    setState(() {});
                                                  });
                                                },
                                                icon: const Icon(Icons.delete),
                                              ),
                                              visible: event.type !=
                                                  EventType.expire.enumToString,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
