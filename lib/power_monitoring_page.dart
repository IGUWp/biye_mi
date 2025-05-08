import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PowerMonitoringPage extends StatefulWidget {
  const PowerMonitoringPage({super.key});

  @override
  State<PowerMonitoringPage> createState() => _PowerMonitoringPageState();
}

class _PowerMonitoringPageState extends State<PowerMonitoringPage> {
  // 发电功率数据
  final List<FlSpot> powerData = [
    const FlSpot(0, 2000),
    const FlSpot(1, 2100),
    const FlSpot(2, 1950),
    const FlSpot(3, 2200),
    const FlSpot(4, 2050),
    const FlSpot(5, 2300),
    const FlSpot(6, 2150),
  ];

  // 发电量统计数据
  final Map<String, double> powerStats = {
    '今日发电量': 45000,
    '本周发电量': 315000,
    '本月发电量': 1260000,
    '计划完成率': 95.5,
  };

  // 效率分析数据
  final List<RadarEntry> efficiencyData = [
    RadarEntry(value: 90), // 设备效率
    RadarEntry(value: 85), // 发电效率
    RadarEntry(value: 95), // 并网效率
    RadarEntry(value: 88), // 维护效率
    RadarEntry(value: 92), // 调度效率
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('发电监测中心')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 发电量统计卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '发电量统计',
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
                          powerStats.entries.map((entry) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                    entry.key == '计划完成率'
                                        ? '${entry.value.toStringAsFixed(1)}%'
                                        : '${entry.value.toString()}kWh',
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
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 功率曲线图
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '功率曲线',
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
            const SizedBox(height: 16),
            // 效率分析图表
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '效率分析',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: RadarChart(
                        RadarChartData(
                          dataSets: [
                            RadarDataSet(
                              dataEntries: efficiencyData,
                              fillColor: Colors.blue.withOpacity(0.2),
                              borderColor: Colors.blue,
                              entryRadius: 3,
                              borderWidth: 2,
                            ),
                          ],
                          titleTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          getTitle: (index, angle) {
                            const titles = [
                              '设备效率',
                              '发电效率',
                              '并网效率',
                              '维护效率',
                              '调度效率',
                            ];
                            return RadarChartTitle(
                              text: titles[index],
                              angle: angle,
                            );
                          },
                          tickCount: 5,
                          ticksTextStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                          ),
                          tickBorderData: const BorderSide(color: Colors.grey),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(),
                          ),
                          gridBorderData: const BorderSide(color: Colors.grey),
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
