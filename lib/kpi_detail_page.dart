import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class KPIDetailPage extends StatelessWidget {
  final MapEntry<String, dynamic> kpi;

  const KPIDetailPage({super.key, required this.kpi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${kpi.key} 详情')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${kpi.key}: ${kpi.value}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const Text(
              'KPI 趋势图',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: kpi.value is double ? kpi.value : 0,
                          color: Colors.blue,
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(show: true),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
