import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Để xử lý dữ liệu JSON

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String apiKey = '9e021d15dbdc256f636785824a451b5c';
  final String city = 'Hanoi';
  String weatherData = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  // Hàm lấy dữ liệu thời tiết từ API
  Future<void> fetchWeatherData() async {
    final String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=vi';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Truy xuất tất cả dữ liệu trả về từ API
        final temperature = data['main']['temp'];
        final humidity = data['main']['humidity'];
        final pressure = data['main']['pressure'];
        final windSpeed = data['wind']['speed'];
        final weatherDescription = data['weather'][0]['description'];
        final clouds = data['clouds']['all'];

        // Cập nhật UI với tất cả dữ liệu
        setState(() {
          weatherData =
              '''
          Temperature: $temperature°C
          Weather: $weatherDescription
          Humidity: $humidity%
          Pressure: $pressure hPa
          Wind Speed: $windSpeed m/s
          Clouds: $clouds%
        ''';
        });
      } else {
        setState(() {
          weatherData = 'Failed to load weather data';
        });
      }
    } catch (e) {
      setState(() {
        weatherData = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            weatherData,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
