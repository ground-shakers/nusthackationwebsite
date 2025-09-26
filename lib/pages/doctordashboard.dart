import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';

class DoctorDashboardPage extends StatefulWidget {
  const DoctorDashboardPage({super.key});

  @override
  State<DoctorDashboardPage> createState() => _DoctorDashboardPageState();
}

class _DoctorDashboardPageState extends State<DoctorDashboardPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF009688),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage("assets/doctor.png"), // replace with network or asset
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Dr. Sarah Johnson",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      Text("Cardiologist, 12 yrs exp.",
                          style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 6),
                      Text("“Caring for patients, one heartbeat at a time”",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Upcoming Appointments
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF009688),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Upcoming Appointments",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  const SizedBox(height: 8),
                  const Text("Next appointment in 2 hours",
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 12),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) =>
                        isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(color: Colors.white),
                      leftChevronIcon:
                          Icon(Icons.chevron_left, color: Colors.white),
                      rightChevronIcon:
                          Icon(Icons.chevron_right, color: Colors.white),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                        weekdayStyle: TextStyle(color: Colors.white),
                        weekendStyle: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Patient Queue
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF009688),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Patient Queue",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: ListView(
                      children: const [
                        ListTile(
                          leading: CircleAvatar(child: Icon(Icons.person)),
                          title: Text("John Doe",
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text("10:30 AM - Cardiology",
                              style: TextStyle(color: Colors.white70)),
                        ),
                        ListTile(
                          leading: CircleAvatar(child: Icon(Icons.person)),
                          title: Text("Jane Smith",
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text("11:15 AM - General Checkup",
                              style: TextStyle(color: Colors.white70)),
                        ),
                        ListTile(
                          leading: CircleAvatar(child: Icon(Icons.person)),
                          title: Text("Alex Johnson",
                              style: TextStyle(color: Colors.white)),
                          subtitle: Text("12:00 PM - Pediatrics",
                              style: TextStyle(color: Colors.white70)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Ratings / Performance Chart
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF009688),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Performance & Ratings",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 22,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 1:
                                    return const Text("Mon",
                                        style: TextStyle(color: Colors.white));
                                  case 2:
                                    return const Text("Tue",
                                        style: TextStyle(color: Colors.white));
                                  case 3:
                                    return const Text("Wed",
                                        style: TextStyle(color: Colors.white));
                                  case 4:
                                    return const Text("Thu",
                                        style: TextStyle(color: Colors.white));
                                  case 5:
                                    return const Text("Fri",
                                        style: TextStyle(color: Colors.white));
                                }
                                return const Text("");
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            spots: const [
                              FlSpot(1, 4.5),
                              FlSpot(2, 4.2),
                              FlSpot(3, 4.8),
                              FlSpot(4, 4.9),
                              FlSpot(5, 4.6),
                            ],
                            color: Colors.white,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text("⭐ Average Rating: 4.7",
                      style: TextStyle(color: Colors.white)),
                  const Text("Highest: 4.9 | Lowest: 4.2",
                      style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Quick Actions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF009688),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  _QuickActionCard(
                      icon: Icons.add_circle, label: "Create Appointment"),
                  _QuickActionCard(
                      icon: Icons.description, label: "View Reports"),
                  _QuickActionCard(
                      icon: Icons.chat, label: "Messages"),
                  _QuickActionCard(
                      icon: Icons.medical_services, label: "Prescriptions"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickActionCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
