# ESP32 Temperature Sensor Monitor

A Flutter application that monitors DHT11 temperature and humidity sensor data from an ESP32 device in real-time.

## 📱 Features

- **Real-time monitoring** of temperature and humidity data
- **Beautiful Material Design 3** interface
- **Automatic data refresh** every second
- **Error handling** with user-friendly messages
- **Loading states** with visual feedback
- **Color-coded sensor cards** for easy reading

## 🛠️ Prerequisites

Before running this project, make sure you have:

- **Flutter SDK** (3.0 or higher)
- **Dart SDK** (3.0 or higher)
- **Android Studio** or **VS Code** with Flutter extensions
- **ESP32 device** with DHT11 sensor
- **WiFi network** for ESP32 connectivity

## 📦 Dependencies

This project uses the following packages:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.1  # For REST API calls
```

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <your-repository-url>
cd esp32_temperature_censor
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure ESP32 API Endpoint

Update the API endpoint in `lib/main.dart` to match your ESP32's IP address:

```dart
stream: SensorService().censorData(
  'http://YOUR_ESP32_IP:8080/api/sensor',  // Replace with your ESP32 IP
  interval: const Duration(seconds: 1),
),
```

### 4. Run the Application

```bash
flutter run
```

## 🔧 ESP32 Setup

Your ESP32 should be running a web server that provides sensor data at the endpoint `/api/sensor` with the following JSON format:

```json
{
  "temperature": 25.5,
  "humidity": 60.2,
  "timestamp": "2025-07-02 14:30:15"
}
```

### Example ESP32 Arduino Code Structure

```cpp
// Your ESP32 should serve JSON data like this:
void handleSensorData() {
  float temp = dht.readTemperature();
  float humidity = dht.readHumidity();
  
  String json = "{";
  json += "\"temperature\":" + String(temp) + ",";
  json += "\"humidity\":" + String(humidity) + ",";
  json += "\"timestamp\":\"" + getCurrentTimestamp() + "\"";
  json += "}";
  
  server.send(200, "application/json", json);
}
```

## 📁 Project Structure

```
lib/
├── main.dart              # Main app and UI
├── models/
│   └── sensor.dart        # Sensor data model
└── services/
    └── sensor_service.dart # API service for fetching data
```

## 🔄 How It Works

1. **SensorService** makes HTTP GET requests to your ESP32 API endpoint
2. **Stream** continuously fetches data every second using `Stream.periodic`
3. **StreamBuilder** listens to the data stream and updates the UI
4. **Sensor model** parses JSON data from the ESP32
5. **Beautiful UI** displays temperature, humidity, and timestamp in cards

## 🎨 UI Components

- **Temperature Card**: Orange-themed with thermostat icon
- **Humidity Card**: Blue-themed with water drop icon
- **Timestamp Display**: Shows when data was last updated
- **Loading State**: Spinner with connection message
- **Error State**: Red-themed error card for connection issues

## 🔧 Customization

### Change Update Interval

Modify the interval in `main.dart`:

```dart
interval: const Duration(seconds: 5), // Update every 5 seconds
```

### Update API Endpoint

Change the URL in `main.dart`:

```dart
'http://192.168.1.100:8080/api/sensor'
```

### Customize Colors

Modify colors in the `_buildSensorCard` method:

```dart
Colors.orange  // For temperature
Colors.blue    // For humidity
```

## 🐛 Troubleshooting

### Common Issues

1. **Connection Error**: Ensure ESP32 is connected to WiFi and accessible
2. **No Data**: Check if ESP32 is serving JSON at the correct endpoint
3. **App Crashes**: Verify the JSON format matches the Sensor model

### Debug Steps

1. Check ESP32 serial monitor for WiFi connection
2. Test API endpoint in browser: `http://ESP32_IP:8080/api/sensor`
3. Verify JSON format matches expected structure
4. Check Flutter console for error messages

## 📱 Screenshots

The app displays:
- Temperature in Celsius with thermostat icon
- Humidity percentage with water drop icon
- Last update timestamp
- Loading spinner while connecting
- Error messages for connection issues

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 📞 Support

If you encounter any issues or have questions, please open an issue in the repository.
