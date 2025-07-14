import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text('기차 예매', style: TextStyle(fontSize: 18)),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _selectStation(true),
                  child: _StationBox(
                    title: '출발역',
                    stationName: _departure ?? '선택',
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => _selectStation(false),
                  child: _StationBox(
                    title: '도착역',
                    stationName: _arrival ?? '선택',
                  ),
                ),
              ],
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
    );
  }
}

class _StationBox extends StatelessWidget {
  final String title;
  final String stationName;

  const _StationBox({required this.title, required this.stationName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            stationName,
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
