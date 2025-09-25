import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  DateTime? eventDay = DateTime.utc(2025, 9, 30);
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(
          fontFamily: "ClarendonBold",
          fontSize: 20,
          color: Colors.white.withOpacity(0.9),
        ),
        formatButtonVisible: false,
        titleCentered: true,
      ),

      // Text styles for days
      calendarStyle: CalendarStyle(
        defaultTextStyle: const TextStyle(
          fontFamily: "PoppinsM",
          fontSize: 14,
          color: Colors.white,
        ),
        weekendTextStyle: const TextStyle(
          fontFamily: "PoppinsM",
          fontSize: 14,
          color: Colors.white,
        ),
        todayTextStyle: const TextStyle(
          fontFamily: "PoppinsM",
          fontSize: 14,
          color: Colors.white,
        ),
        selectedTextStyle: const TextStyle(
          fontFamily: "MontserratBold",
          fontSize: 14,
          color: Colors.white,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),

      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: today,
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) {
        return isSameDay(day, eventDay);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          eventDay = selectedDay;
          today = focusedDay;
        });
      },
    );
  }
}
