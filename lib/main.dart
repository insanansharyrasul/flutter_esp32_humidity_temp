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
      title: 'DHT11 Sensor Monitor',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SensorDashboard(),
    );
  }
}

class SensorDashboard extends StatelessWidget {
  const SensorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('DHT11 Sensor Monitor'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<Sensor>(
          stream: SensorService().censorData(
            'http://192.168.145.56:8080/api/sensor',
            interval: const Duration(seconds: 1),
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Connecting to sensor...', style: TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Card(
                  color: Colors.red[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text(
                          'Connection Error',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Failed to fetch sensor data',
                          style: TextStyle(color: Colors.red[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data available', style: TextStyle(fontSize: 16)));
            }

            final sensor = snapshot.data!;
            return Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: _buildSensorCard(
                        'Temperature',
                        '${sensor.temperature}°C',
                        Icons.thermostat,
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSensorCard(
                        'Humidity',
                        '${sensor.humidity}%',
                        Icons.water_drop,
                        Colors.blue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey[600]),
                        const SizedBox(width: 12),
                        Text(
                          'Last Updated: ${sensor.timestamp}',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSensorCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
