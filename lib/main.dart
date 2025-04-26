import 'package:biye_mid/bar_chart_page.dart';
import 'package:biye_mid/pie_chart_page.dart';
import 'package:biye_mid/radar_chart_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'line_chart_page.dart'; // 导入折线图页面

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LineChartPage(),
                  ),
                );
              },
              child: const Text('打开折线图页面'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PieChartPage()),
                );
              },
              child: const Text('打开饼图页面'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BarChartPage()),
                );
              },
              child: const Text('打开柱状图页面'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RadarChartPage(),
                  ),
                );
              },
              child: const Text('打开雷达图页面'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

List<FlSpot> get allSpots => const [
  FlSpot(0, 1),
  FlSpot(1, 2),
  FlSpot(2, 3),
  FlSpot(3, 4),
  FlSpot(4, 5),
  FlSpot(5, 6),
  FlSpot(6, 7),
  FlSpot(7, 8),
  FlSpot(8, 9),
  FlSpot(9, 10),
];
List<int> showingTool = [3];
