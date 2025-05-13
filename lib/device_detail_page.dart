import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DeviceDetailPage extends StatelessWidget {
  final Map<String, dynamic> device;

  const DeviceDetailPage({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${device['name']} 详情')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '设备状态: ${device['status']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              '功率: ${device['power']} kW',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              '转速: ${device['speed']} m/s',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            const Text(
              '功率趋势图',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      color:
                          device['status'] == '正常'
                              ? Colors.green
                              : device['status'] == '警告'
                              ? Colors.orange
                              : Colors.red,
                      spots: [
                        const FlSpot(0, 2000),
                        const FlSpot(1, 2100),
                        const FlSpot(2, 1950),
                        const FlSpot(3, 2200),
                        const FlSpot(4, 2050),
                      ],
                      isCurved: true,
                      barWidth: 2,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
