import 'package:esp32_temperature_censor/models/sensor.dart';
import 'package:esp32_temperature_censor/services/sensor_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Center(child: Text("DHT11 Sensor Data")),
            Center(
              child: StreamBuilder<Sensor>(
                stream: SensorService().censorData(
                  'http://192.168.145.56:8080/api/sensor',
                  interval: const Duration(seconds: 1),
                ),
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Text('Humidity: ${snapshot.data?.humidity}'),
                      Text('Temperature: ${snapshot.data?.temperature}'),
                      Text('Timestamp: ${snapshot.data?.timestamp}'),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
