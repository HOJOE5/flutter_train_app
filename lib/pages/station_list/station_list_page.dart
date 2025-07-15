import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class StationListPage extends StatelessWidget {
  static const String routeName = '/station_list';

  final bool isDeparture;
  final String? excludeStation; // 같은 역 고르지 못하도록

  const StationListPage({
    super.key,
    required this.isDeparture,
    this.excludeStation,
  });

  @override
  Widget build(BuildContext context) {
    final title = isDeparture ? '출발역' : '도착역';
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;

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
        title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: colorScheme.onSurface,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: stationList.length,
        itemBuilder: (context, index) {
          final station = stationList[index];
          final isDisabled = station == excludeStation;

          return ListTile(
            title: Text(
              station,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDisabled
                    ? colorScheme.onSurface.withAlpha(100)
                    : colorScheme.onSurface,
              ),
            ),
            //아래 부분이 같은 역 선택 불가 경고 메시지 띄우는 부분
            trailing: isDisabled
                ? Icon(Icons.block, color: colorScheme.onSurface.withAlpha(100))
                : null,
            onTap: isDisabled
                ? null
                : () {
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
