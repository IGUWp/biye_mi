import 'package:biye_mid/device_detail_page.dart';
import 'package:biye_mid/power_data_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  // 使用 DeviceStatus 模型存储设备状态数据
  final List<DeviceStatus> deviceStatus = [
    DeviceStatus(name: '风机1号', status: '正常', power: 2000, speed: 12.5),
    DeviceStatus(name: '风机2号', status: '警告', power: 1800, speed: 11.8),
    DeviceStatus(name: '风机3号', status: '正常', power: 2100, speed: 13.2),
    DeviceStatus(name: '风机4号', status: '故障', power: 0, speed: 0),
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
      appBar: AppBar(title: const Text('设备维护')),
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
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children:
                          deviceStatus.map((device) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DeviceDetailPage(
                                          device: {
                                            'name': device.name,
                                            'status': device.status,
                                            'power': device.power,
                                            'speed': device.speed,
                                          },
                                        ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color:
                                      device.status == '正常'
                                          ? Colors.green[100]
                                          : device.status == '警告'
                                          ? Colors.orange[100]
                                          : Colors.red[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      device.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '状态: ${device.status}',
                                      style: TextStyle(
                                        color:
                                            device.status == '正常'
                                                ? Colors.green
                                                : device.status == '警告'
                                                ? Colors.orange
                                                : Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                    ),
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
