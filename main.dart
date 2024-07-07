import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/screens/weather_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider()..loadLastSearchedCity(),
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey, // Set primary color to blue grey
          scaffoldBackgroundColor: Colors.blueGrey[50], // Set background color to a lighter shade of blue grey
          // You can further customize the theme here
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/details': (context) => const WeatherDetailsScreen(),
        },
      ),
    );
  }
}
