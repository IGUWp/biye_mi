import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  // 设备状态数据
  final List<Map<String, dynamic>> deviceStatus = [
    {'name': '风机1号', 'status': '正常', 'power': 2000, 'speed': 12.5},
    {'name': '风机2号', 'status': '警告', 'power': 1800, 'speed': 11.8},
    {'name': '风机3号', 'status': '正常', 'power': 2100, 'speed': 13.2},
    {'name': '风机4号', 'status': '故障', 'power': 0, 'speed': 0},
  ];

  // 设备参数趋势数据
  final List<FlSpot> powerData = [
    const FlSpot(0, 2000),
    const FlSpot(1, 2100),
    const FlSpot(2, 1950),
    const FlSpot(3, 2200),
    const FlSpot(4, 2050),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('运维监控中心'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 设备状态卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '设备状态概览',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...deviceStatus.map((device) => ListTile(
                          title: Text(device['name']),
                          subtitle: Text('功率: ${device['power']}kW'),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: device['status'] == '正常'
                                  ? Colors.green
                                  : device['status'] == '警告'
                                      ? Colors.orange
                                      : Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              device['status'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 功率趋势图
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '功率趋势',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                              spots: powerData,
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 3,
                              dotData: FlDotData(show: true),
                            ),
                          ],
                        ),
                      ),
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