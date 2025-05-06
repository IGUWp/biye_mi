import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExecutiveDashboard extends StatefulWidget {
  const ExecutiveDashboard({super.key});

  @override
  State<ExecutiveDashboard> createState() => _ExecutiveDashboardState();
}

class _ExecutiveDashboardState extends State<ExecutiveDashboard> {
  // 关键指标数据
  final Map<String, dynamic> keyMetrics = {
    '总发电量': 12600000,
    '总收入': 7560000,
    '设备利用率': 95.8,
    '投资回报率': 18.5,
  };

  // 经济效益数据
  final List<BarChartGroupData> economicData = [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 80,
          color: Colors.blue,
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 65,
          color: Colors.green,
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 90,
          color: Colors.orange,
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    ),
    BarChartGroupData(
      x: 3,
      barRods: [
        BarChartRodData(
          toY: 75,
          color: Colors.purple,
          width: 20,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
        ),
      ],
    ),
  ];

  // 预警信息
  final List<Map<String, dynamic>> alerts = [
    {
      'title': '设备维护提醒',
      'content': '3号风机需要定期维护',
      'level': 'warning',
    },
    {
      'title': '发电效率异常',
      'content': '本周发电效率低于预期',
      'level': 'error',
    },
    {
      'title': '成本控制良好',
      'content': '本月维护成本在预算范围内',
      'level': 'success',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('领导决策中心'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 关键指标卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '关键指标总览',
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
                      children: keyMetrics.entries.map((entry) {
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
                                entry.key == '总发电量'
                                    ? '${entry.value.toString()}kWh'
                                    : entry.key == '总收入'
                                        ? '¥${entry.value.toString()}'
                                        : '${entry.value.toString()}%',
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
            // 经济效益分析图表
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '经济效益分析',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 100,
                          barGroups: economicData,
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const titles = ['发电', '收入', '效率', '成本'];
                                  return Text(
                                    titles[value.toInt()],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: true),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 预警信息卡片
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '重要预警信息',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...alerts.map((alert) {
                      Color color;
                      switch (alert['level']) {
                        case 'warning':
                          color = Colors.orange;
                          break;
                        case 'error':
                          color = Colors.red;
                          break;
                        case 'success':
                          color = Colors.green;
                          break;
                        default:
                          color = Colors.grey;
                      }
                      return ListTile(
                        title: Text(alert['title']),
                        subtitle: Text(alert['content']),
                        leading: Icon(Icons.warning, color: color),
                      );
                    }),
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