import 'package:biye_mid/bar_chart_page.dart';
import 'package:biye_mid/pie_chart_page.dart';
import 'package:biye_mid/radar_chart_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'line_chart_page.dart'; // 导入折线图页面
import 'maintenance_page.dart';
import 'management_page.dart';
import 'power_monitoring_page.dart';
import 'executive_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '风电场监控系统',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('风电场监控系统'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '请选择您的角色',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildRoleCard(
                    context,
                    '运维人员',
                    Icons.build,
                    Colors.blue,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MaintenancePage(),
                      ),
                    ),
                  ),
                  _buildRoleCard(
                    context,
                    '管理人员',
                    Icons.people,
                    Colors.green,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManagementPage(),
                      ),
                    ),
                  ),
                  _buildRoleCard(
                    context,
                    '发电检测',
                    Icons.electric_bolt,
                    Colors.orange,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PowerMonitoringPage(),
                      ),
                    ),
                  ),
                  _buildRoleCard(
                    context,
                    '领导决策',
                    Icons.dashboard,
                    Colors.purple,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExecutiveDashboard(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.7),
                color,
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
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
