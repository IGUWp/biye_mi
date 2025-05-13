import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:biye_mid/power_data_model.dart';

class PowerMonitoringPage extends StatefulWidget {
  const PowerMonitoringPage({super.key});

  @override
  State<PowerMonitoringPage> createState() => _PowerMonitoringPageState();
}

class _PowerMonitoringPageState extends State<PowerMonitoringPage> {
  // 使用 PowerData 模型存储发电数据
  final List<PowerData> powerData = [
    PowerData(
      date: DateTime(2023, 5, 1),
      powerGenerated: 2000,
      efficiency: 90,
      co2Reduction: 50,
    ),
    PowerData(
      date: DateTime(2023, 5, 2),
      powerGenerated: 2100,
      efficiency: 92,
      co2Reduction: 55,
    ),
    PowerData(
      date: DateTime(2023, 5, 3),
      powerGenerated: 1950,
      efficiency: 88,
      co2Reduction: 48,
    ),
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
                                    maxLines: 1,
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
            // 发电趋势图
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '发电趋势',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots:
                                  powerData
                                      .map(
                                        (data) => FlSpot(
                                          data.date.day.toDouble(),
                                          data.powerGenerated,
                                        ),
                                      )
                                      .toList(),
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
                                  final date = DateTime(2023, 5, value.toInt());
                                  return Text('${date.month}/${date.day}');
                                },
                              ),
                            ),
                          ),
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
