import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartPage extends StatefulWidget {
  const LineChartPage({super.key});

  @override
  State<LineChartPage> createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  final List<FlSpot> allSpots = const [
    FlSpot(0, 1),
    FlSpot(1, 1),
    FlSpot(2, 16),
    FlSpot(3, 8),
    FlSpot(4, 9),
    FlSpot(5, 4),
    FlSpot(6, 13),
    FlSpot(7, 8),
    FlSpot(8, 4),
    FlSpot(9, 11),
  ];

  final List<int> showingTool = [3];

  @override
  Widget build(BuildContext context) {
    final LineBarsData = [
      LineChartBarData(
        showingIndicators: showingTool,
        spots: allSpots,
        isCurved: true,
        color: Colors.blue,
        barWidth: 4,
        isStrokeCapRound: true,
        belowBarData: BarAreaData(show: false),
      ),
    ];

    final tooltipsonbar = LineBarsData[0];

    return Scaffold(
      appBar: AppBar(title: const Text('折线图页面')),
      body: Center(
        child: Container(
          height: 350,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchCallback: (
                  FlTouchEvent event,
                  LineTouchResponse? response,
                ) {
                  if (response == null || response.lineBarSpots == null) {
                    return;
                  }
                  if (event is FlTapUpEvent) {
                    final spotIndex = response.lineBarSpots!.first.spotIndex;
                    showingTool.clear();
                    setState(() {
                      showingTool.add(spotIndex);
                    });
                  }
                },
                getTouchedSpotIndicator: (
                  LineChartBarData barData,
                  List<int> spotIndexes,
                ) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      FlLine(color: Colors.red),
                      FlDotData(
                        show: true,
                        getDotPainter:
                            (spot, percent, barData, index) =>
                                FlDotCirclePainter(
                                  radius: 3,
                                  color: Colors.white,
                                  strokeWidth: 3,
                                  strokeColor: const Color(0xffC58BF2),
                                ),
                      ),
                    );
                  }).toList();
                },
                mouseCursorResolver: (
                  FlTouchEvent event,
                  LineTouchResponse? response,
                ) {
                  if (response == null || response.lineBarSpots == null) {
                    return SystemMouseCursors.basic;
                  }
                  return SystemMouseCursors.click;
                },
                touchTooltipData: LineTouchTooltipData(
                  tooltipRoundedRadius: 8,
                  getTooltipItems: (List<LineBarSpot> lineBarSpot) {
                    return lineBarSpot.map((spot) {
                      return LineTooltipItem(
                        'X: ${spot.x}, Y: ${spot.y}',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
              ),
              showingTooltipIndicators:
                  showingTool.map((index) {
                    return ShowingTooltipIndicators([
                      LineBarSpot(
                        tooltipsonbar,
                        LineBarsData.indexOf(tooltipsonbar),
                        tooltipsonbar.spots[0],
                      ),
                    ]);
                  }).toList(),
              lineBarsData: LineBarsData,
            ),
          ),
        ),
      ),
    );
  }
}
