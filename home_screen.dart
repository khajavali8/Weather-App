import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue[100]!, Colors.blueGrey[50]!],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter city name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        context.read<WeatherProvider>().fetchWeather(controller.text);
                      }
                    },
                    child: const Text('Get Weather'),
                  ),
                  const SizedBox(height: 16),
                  Consumer<WeatherProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const CircularProgressIndicator();
                      } else if (provider.weatherData != null) {
                        return ListTile(
                          title: Text(provider.weatherData!.cityName),
                          subtitle: Text('Temperature: ${provider.weatherData!.temperature} °C'),
                          onTap: () {
                            Navigator.pushNamed(context, '/details');
                          },
                        );
                      } else if (provider.errorMessage != null) {
                        return Text(provider.errorMessage!);
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.wb_sunny, size: 100, color: Colors.yellow.withOpacity(0.5)),
                  Icon(Icons.cloud, size: 100, color: Colors.white.withOpacity(0.5)),
                  Icon(Icons.grain, size: 100, color: Colors.grey.withOpacity(0.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
