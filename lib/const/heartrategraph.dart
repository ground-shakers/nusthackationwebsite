import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HeartRateChart extends StatelessWidget {
  const HeartRateChart({super.key});

  @override
  Widget build(BuildContext context) {
    final List<double> heartRates = [70, 75, 80, 65, 72, 90, 85, 77, 69, 74];

    return LineChart(
      LineChartData(
        maxY: 100,
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              heartRates.length,
              (index) => FlSpot(index.toDouble(), heartRates[index]),
            ),
            isCurved: true,
            color: Colors.white,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: Color(0xFF009688),
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                ],
              ),
            ),
          ),
        ],
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.white.withOpacity(0.2), strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.7),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  "${value.toInt() + 1}h",
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.7),
                  ),
                );
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        lineTouchData: LineTouchData(enabled: false),
      ),
    );
  }
}
