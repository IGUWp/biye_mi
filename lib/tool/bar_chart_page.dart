import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartPage extends StatefulWidget {
  const BarChartPage({super.key});

  @override
  State<BarChartPage> createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  static const double barWidth = 22;
  static const shadowOpacity = 0.2;
  static const mainItems = <int, List<double>>{
    0: [2, 3, 2.5, 8],
    1: [-1.8, -2.7, -3, -6.5],
    2: [1.5, 2, 3.5, 6],
    3: [1.5, 1.5, 4, 6.5],
    4: [-2, -2, -5, -9],
    5: [-1.2, -1.5, -4.3, -10],
    6: [1.2, 4.8, 5, 5],
  };
  int touchedIndex = -1;

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Mon';
        break;
      case 1:
        text = 'Tue';
        break;
      case 2:
        text = 'Wed';
        break;
      case 3:
        text = 'Thu';
        break;
      case 4:
        text = 'Fri';
        break;
      case 5:
        text = 'Sat';
        break;
      case 6:
        text = 'Sun';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(meta: meta, child: Text(text, style: style));
  }

  BarChartGroupData generateGroup(
    int x,
    double value1,
    double value2,
    double value3,
    double value4,
  ) {
    final isTop = value1 > 0;
    final sum = value1 + value2 + value3 + value4;
    final isTouched = touchedIndex == x;
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: isTouched ? [0] : [],
      barRods: [
        BarChartRodData(
          toY: sum,
          width: barWidth,
          borderRadius:
              isTop
                  ? const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  )
                  : const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
          rodStackItems: [
            BarChartRodStackItem(0, value1, Colors.green),
            BarChartRodStackItem(value1, value1 + value2, Colors.yellow),
            BarChartRodStackItem(
              value1 + value2,
              value1 + value2 + value3,
              Colors.pink,
            ),
            BarChartRodStackItem(value1 + value2 + value3, sum, Colors.blue),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('柱状图页面')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            maxY: 20,
            minY: -20,
            groupsSpace: 12,
            barTouchData: BarTouchData(
              touchCallback: (FlTouchEvent event, barTouchResponse) {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  setState(() {
                    touchedIndex = -1;
                  });
                  return;
                }
                setState(() {
                  touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
                });
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  getTitlesWidget: bottomTitles,
                ),
              ),
            ),
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (value) => value % 5 == 0,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.5),
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(show: false),
            barGroups:
                mainItems.entries
                    .map(
                      (e) => generateGroup(
                        e.key,
                        e.value[0],
                        e.value[1],
                        e.value[2],
                        e.value[3],
                      ),
                    )
                    .toList(),
          ),
        ),
      ),
    );
  }
}
