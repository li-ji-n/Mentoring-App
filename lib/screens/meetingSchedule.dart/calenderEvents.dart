import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final Map<DateTime, List> mapFetch;
  CalendarScreen({this.mapFetch});
  @override
  State<StatefulWidget> createState() {
    return _CalendarScreenState();
  }
}

class _CalendarScreenState extends State<CalendarScreen> {
  Map<DateTime, List> _events = {};
  List _selectedEvents;
  DateTime _selectedDay = DateTime.now();

  void _handleNewDate(date) {
    //  _events=widget.mapFetch;
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }

  // final Map _events = { widget.mapFetch
  //year,month,date
  // DateTime(2020,06,26): [{'name':'ds','isDone':false}]

  // DateTime(2020, 3, 1): [
  //   {'name': 'Event A', 'isDone': false},
  // ],
  // DateTime(2020, 3, 4): [
  //   {'name': 'Event A', 'isDone': false},
  //   {'name': 'Event B', 'isDone': false},
  // ],
  // DateTime(2020, 3, 5): [
  //   {'name': 'Event A', 'isDone': true},
  //   {'name': 'Event B', 'isDone': true},
  // ],
  // DateTime(2020, 3, 13): [
  //   {'name': 'Event A', 'isDone': true},
  //   {'name': 'Event B', 'isDone': true},
  //   {'name': 'Event C', 'isDone': false},
  // ],
  // DateTime(2020, 3, 15): [
  //   {'name': 'Event A', 'isDone': true},
  //   {'name': 'Event B', 'isDone': true},
  //   {'name': 'Event C', 'isDone': false},
  // ],
  // DateTime(2020, 3, 26): [
  //   {'name': 'Event A', 'isDone': false},
  // ],
  // };

  @override
  void initState() {
    super.initState();

    _events = widget.mapFetch;
    _selectedEvents = _events[_selectedDay] ?? [];
    print(_events);
  }

  @override
  Widget build(BuildContext context) {
    //  _events = widget.mapFetch;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   title: Text('Calendario'),
      // ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Calendar(
                startOnMonday: true,
                weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                events: _events,
                onRangeSelected: (range) =>
                    print("Range is ${range.from}, ${range.to}"),
                onDateSelected: (date) => _handleNewDate(date),
                isExpandable: true,
                // eventDoneColor: Colors.green,
                selectedColor: Colors.pink,
                todayColor: Colors.yellow,
                eventColor: Colors.grey,
                dayOfWeekStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 11),
              ),
            ),
            _buildEventList()
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    //  _events = widget.mapFetch;
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ListTile(
            title: Text(_selectedEvents[index]['name'].toString()),
            onTap: () {},
          ),
        ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}
