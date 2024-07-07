import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class WeatherDetailsScreen extends StatelessWidget {
  const WeatherDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather Details')),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100], // Example background color
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<WeatherProvider>(
            builder: (context, provider, child) {
              if (provider.weatherData != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'City: ${provider.weatherData!.cityName}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Temperature: ${provider.weatherData!.temperature} °C',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Condition: ${provider.weatherData!.condition}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Image.network(
                          'https://openweathermap.org/img/wn/${provider.weatherData!.icon}.png',
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Humidity: ${provider.weatherData!.humidity}%',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Wind Speed: ${provider.weatherData!.windSpeed} m/s',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        provider.fetchWeather(provider.weatherData!.cityName);
                      },
                      child: const Text('Refresh'),
                    ),
                  ],
                );
              } else {
                return const Text('No weather data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
