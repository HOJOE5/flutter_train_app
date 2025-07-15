import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'package:flutter_train_app/pages/seat/seat_page.dart';
import '../station_list/station_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _departure;
  String? _arrival;

  Future<void> _selectStation(bool isDeparture) async {
    final result = await Navigator.pushNamed(
      context,
      StationListPage.routeName,
      arguments: isDeparture,
    );

    if (result is Map) {
      setState(() {
        if (result['isDeparture'] as bool) {
          _departure = result['station'] as String;
        } else {
          _arrival = result['station'] as String;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text('기차 예매', style: TextStyle(color: colorScheme.onSurface)),
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
      body: Container(
        color: Colors.grey[400],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              Spacer(),
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.onSurface.withAlpha(150),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectStation(true),
                        child: _StationBox(
                          title: '출발역',
                          stationName: _departure ?? '선택',
                          colorScheme: colorScheme,
                        ),
                      ),
                    ),
                    //구분선
                    Center(
                      child: Container(
                        width: 2,
                        height: 50,
                        color: Colors.grey[400],
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectStation(false),
                        child: _StationBox(
                          title: '도착역',
                          stationName: _arrival ?? '선택',
                          colorScheme: colorScheme,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_departure != null && _arrival != null)
                      ? () {
                          Navigator.pushNamed(
                            context,
                            SeatPage.routeName,
                            arguments: {
                              'departure': _departure!,
                              'arrival': _arrival!,
                            },
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    '좌석 선택',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }
}

class _StationBox extends StatelessWidget {
  final String title;
  final String stationName;
  final ColorScheme colorScheme;

  const _StationBox({
    required this.title,
    required this.stationName,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(stationName, style: TextStyle(fontSize: 40)),
        ],
      ),
    );
  }
}
