import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RadarChartPage extends StatefulWidget {
  const RadarChartPage({super.key});

  @override
  State<RadarChartPage> createState() => _RadarChartPageState();
}

class _RadarChartPageState extends State<RadarChartPage> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;
  bool relativeAngleMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('雷达图页面')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1.3,
              child: RadarChart(
                RadarChartData(
                  radarTouchData: RadarTouchData(
                    touchCallback: (FlTouchEvent event, response) {
                      if (!event.isInterestedForInteractions) {
                        setState(() {
                          selectedDataSetIndex = -1;
                        });
                        return;
                      }
                      setState(() {
                        selectedDataSetIndex =
                            response?.touchedSpot?.touchedDataSetIndex ?? -1;
                      });
                    },
                  ),
                  dataSets: showingDataSets(),
                  radarBackgroundColor: Colors.transparent,
                  borderData: FlBorderData(show: false),
                  radarBorderData: const BorderSide(color: Colors.transparent),
                  titlePositionPercentageOffset: 0.2,
                  titleTextStyle: const TextStyle(fontSize: 14),
                  getTitle: (index, angle) {
                    final usedAngle =
                        relativeAngleMode ? angle + angleValue : angleValue;
                    switch (index) {
                      case 0:
                        return RadarChartTitle(text: '手机端人数', angle: usedAngle);
                      case 1:
                        return RadarChartTitle(text: '桌面端人数', angle: usedAngle);
                      case 2:
                        return RadarChartTitle(text: '电视', angle: usedAngle);
                      default:
                        return const RadarChartTitle(text: '');
                    }
                  },
                  tickCount: 1,
                  ticksTextStyle: const TextStyle(color: Colors.transparent),
                  tickBorderData: const BorderSide(color: Colors.transparent),
                  gridBorderData: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                duration: const Duration(milliseconds: 400),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected =
          index == selectedDataSetIndex
              ? true
              : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        fillColor:
            isSelected
                ? rawDataSet.color.withOpacity(0.2)
                : rawDataSet.color.withOpacity(0.05),
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3 : 2,
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
        borderWidth: isSelected ? 2.3 : 2,
      );
    }).toList();
  }

  List<RawDataSet> rawDataSets() {
    return [
      RawDataSet(title: '时尚', color: Colors.red, values: [300, 50, 250]),
      RawDataSet(title: '艺术', color: Colors.cyan, values: [250, 100, 200]),
      RawDataSet(title: '娱乐', color: Colors.white, values: [200, 150, 50]),
      RawDataSet(title: '游戏', color: Colors.yellow, values: [150, 200, 150]),
      RawDataSet(title: '运动', color: Colors.green, values: [100, 250, 100]),
    ];
  }
}

class RawDataSet {
  RawDataSet({required this.title, required this.color, required this.values});

  final String title;
  final Color color;
  final List<double> values;
}
