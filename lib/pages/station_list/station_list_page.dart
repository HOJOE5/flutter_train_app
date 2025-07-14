import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  static const String routeName = '/station_list';

  final bool isDeparture;

  const StationListPage({super.key, required this.isDeparture});

  @override
  Widget build(BuildContext context) {
    final title = isDeparture ? '출발역' : '도착역';
    const List<String> stationList = [
      '수서',
      '동탄',
      '평택지제',
      '천안아산',
      '오송',
      '대전',
      '김천구미',
      '동대구',
      '경주',
      '울산',
      '부산',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: stationList.length,
        itemBuilder: (context, index) {
          final station = stationList[index];
          return ListTile(
            title: Text(
              station,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context, {
                'isDeparture': isDeparture,
                'station': station,
              });
            },
          );
        },
      ),
    );
  }
}
