import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherData {
  final String cityName;
  final double temperature;
  final String condition;
  final int humidity;
  final double windSpeed;
  final String icon;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      temperature: (json['main']['temp'] ).toDouble(),
      condition: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}

class WeatherProvider with ChangeNotifier {
  WeatherData? weatherData;
  bool isLoading = false;
  String? errorMessage;
  String? lastSearchedCity;

  WeatherProvider() {
    loadLastSearchedCity();
  }

  Future<void> fetchWeather(String cityName) async {
    isLoading = true;
    errorMessage = null;
    weatherData = null; // Clear previous weather data
    notifyListeners();

    const apiKey = '3a9599e6f532da9b3c377cb2ab7319a4'; // Replace with your OpenWeatherMap API key
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        weatherData = WeatherData.fromJson(data);
        saveLastSearchedCity(cityName);
      } else {
        errorMessage = 'Error: ${response.reasonPhrase}';
      }
    } catch (error) {
      errorMessage = 'Error: $error';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveLastSearchedCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastCity', cityName);
    lastSearchedCity = cityName;
    notifyListeners();
  }

  Future<void> loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance();
    lastSearchedCity = prefs.getString('lastCity');
    if (lastSearchedCity != null) {
      fetchWeather(lastSearchedCity!);
    }
    notifyListeners();
  }
}
