// lib/pages/station_list/station_list_page.dart

import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  static const String routeName = '/station_list';

  /// true → 출발역, false → 도착역
  final bool isDeparture;

  const StationListPage({super.key, required this.isDeparture});

  // 예시용 고정된 역 목록
  static const List<String> _stations = [
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

  @override
  Widget build(BuildContext context) {
    final title = isDeparture ? '출발역' : '도착역';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: const BackButton(), // 자동으로 Navigator.pop()
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: _stations.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, idx) {
          final name = _stations[idx];
          return ListTile(
            title: Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // TODO: 선택된 역을 Provider 등에 저장
              // Navigator.pop(context, name);
              Navigator.pop(context, {
                'isDeparture': isDeparture,
                'station': name,
              });
            },
          );
        },
      ),
    );
  }
}
