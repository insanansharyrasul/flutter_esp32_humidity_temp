class Sensor {
  final double temperature;
  final double humidity;
  final String status;
  final int timestamp;

  Sensor({
    required this.temperature,
    required this.humidity,
    required this.status,
    required this.timestamp,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      temperature: json['temperature'] as double,
      humidity: json['humidity'] as double,
      status: json['status'] as String,
      timestamp: json['timestamp'] as int,
    );
  }
}
