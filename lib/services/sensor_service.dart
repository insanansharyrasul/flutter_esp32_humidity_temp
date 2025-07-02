import 'dart:convert';

import 'package:esp32_temperature_censor/models/sensor.dart';
import 'package:http/http.dart' as http;

class SensorService {
  Stream<Sensor> censorData(String url, {Duration interval = const Duration(seconds: 5)}) async* {
    while (true) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decodedJson = json.decode(response.body) as Map<String, dynamic>;
        if (decodedJson['timestamp'] == null) {
          continue;
        }
        yield Sensor.fromJson(decodedJson);
      } else {
        throw Stream.error('Failed to load data');
      }
      await Future.delayed(interval);
    }
  }
}
