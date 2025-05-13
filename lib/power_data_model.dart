class PowerData {
  final DateTime date;
  final double powerGenerated; // 发电量
  final double efficiency; // 效率
  final double co2Reduction; // 减排量

  PowerData({
    required this.date,
    required this.powerGenerated,
    required this.efficiency,
    required this.co2Reduction,
  });
}

class DeviceStatus {
  final String name;
  final String status;
  final double power;
  final double speed;

  DeviceStatus({
    required this.name,
    required this.status,
    required this.power,
    required this.speed,
  });
}