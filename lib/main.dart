// main.dart

import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';
import 'pages/station_list/station_list_page.dart';
import 'pages/seat/seat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기차 예매',
      theme: ThemeData(primarySwatch: Colors.purple),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == StationListPage.routeName) {
          final isDeparture = settings.arguments as bool;
          return MaterialPageRoute(
            builder: (_) => StationListPage(isDeparture: isDeparture),
          );
        }

        if (settings.name == SeatPage.routeName) {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (_) => SeatPage(
              departure: args['departure']!,
              arrival: args['arrival']!,
            ),
          );
        }

        return MaterialPageRoute(builder: (_) => const HomePage());
      },
    );
  }
}
