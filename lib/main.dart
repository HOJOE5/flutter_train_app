// lib/main.dart

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
      routes: {
        '/': (_) => const HomePage(),
        StationListPage.routeName: (_) =>
            const StationListPage(isDeparture: true),
        // 나중에 도착역은 isDeparture: false 로 호출
        //'/seat': (_) => const SeatPage(),
      },
    );
  }
}
