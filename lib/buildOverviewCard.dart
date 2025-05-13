import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildOverviewCards() {
  final keyMetrics = {
    '总发电量': '1260万kWh',
    '总收入': '¥756万',
    '设备利用率': '95.8%',
    '投资回报率': '18.5%',
  };

  return GridView.count(
    shrinkWrap: true,
    crossAxisCount: 2,
    mainAxisSpacing: 16,
    crossAxisSpacing: 16,
    childAspectRatio: 2.5,
    physics: const NeverScrollableScrollPhysics(),
    children:
        keyMetrics.entries.map((entry) {
          return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  entry.value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
  );
}

Widget buildBarChart() {
  final barData = [
    BarChartGroupData(
      x: 0,
      barRods: [BarChartRodData(toY: 450, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [BarChartRodData(toY: 500, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [BarChartRodData(toY: 550, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [BarChartRodData(toY: 600, color: Colors.blue)],
    ),
    BarChartGroupData(
      x: 4,
      barRods: [BarChartRodData(toY: 580, color: Colors.blue)],
    ),
  ];

  return SizedBox(
    height: 200,
    child: BarChart(
      BarChartData(
        barGroups: barData,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const titles = ['1月', '2月', '3月', '4月', '5月'];
                return Text(titles[value.toInt()]);
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: false),
      ),
    ),
  );
}

Widget buildPieChart() {
  final pieData = [
    PieChartSectionData(value: 60, color: Colors.green, title: '正常'),
    PieChartSectionData(value: 30, color: Colors.orange, title: '警告'),
    PieChartSectionData(value: 10, color: Colors.red, title: '故障'),
  ];

  return SizedBox(
    height: 200,
    child: PieChart(
      PieChartData(sections: pieData, centerSpaceRadius: 40, sectionsSpace: 2),
    ),
  );
}

Widget buildLineChart() {
  final lineData = [
    FlSpot(0, 90),
    FlSpot(1, 92),
    FlSpot(2, 88),
    FlSpot(3, 91),
    FlSpot(4, 89),
  ];

  return SizedBox(
    height: 200,
    child: LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: lineData,
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            dotData: FlDotData(show: true),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const titles = ['1月', '2月', '3月', '4月', '5月'];
                return Text(titles[value.toInt()]);
              },
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildFunnelChart() {
  final funnelData = [
    {'label': '总发电量', 'value': 12600000, 'color': Colors.blue},
    {'label': '有效发电量', 'value': 12000000, 'color': Colors.green},
    {'label': '高效发电量', 'value': 11000000, 'color': Colors.orange},
    {'label': '最终利用量', 'value': 10000000, 'color': Colors.red},
  ];

  return Column(
    children:
        funnelData.map((data) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 40,
            width: (data['value'] as int) / 12600000 * 300, // 根据比例调整宽度
            color: data['color'] as Color,
            child: Center(
              child: Text(
                '${data['label']}: ${data['value']}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }).toList(),
  );
}
