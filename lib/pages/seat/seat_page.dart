import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;
  const SeatPage({super.key, required this.departure, required this.arrival});

  static const String routeName = '/seat';

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // 10행 x 4열 좌석 구성
  final List<List<bool>> _seatSelected = List.generate(
    10,
    (_) => List.generate(4, (_) => false),
  );

  void _toggleSeat(int row, int col) {
    setState(() {
      _seatSelected[row][col] = !_seatSelected[row][col];
    });
  }

  bool get _hasSelectedSeat =>
      _seatSelected.any((row) => row.any((selected) => selected == true));

  void _confirmBooking() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("예매 완료"),
        content: const Text("좌석이 성공적으로 예매되었습니다."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
              Navigator.of(
                context,
              ).popUntil((route) => route.isFirst); // 홈으로 이동
            },
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택', style: TextStyle(color: colorScheme.onSurface)),
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // 출발/도착역
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.departure,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.arrow_circle_right,
                  size: 24,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.arrival,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // 좌석 상태 안내
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[700] : Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(width: 4),
                Text('선택 가능', style: TextStyle(color: colorScheme.onSurface)),
                const SizedBox(width: 40),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(width: 4),
                Text('선택됨', style: TextStyle(color: colorScheme.onSurface)),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _seatHeader('A', colorScheme),
                const SizedBox(width: 16),
                _seatHeader('B', colorScheme),
                const SizedBox(width: 40), // 가운데 통로
                _seatHeader('C', colorScheme),
                const SizedBox(width: 16),
                _seatHeader('D', colorScheme),
              ],
            ),

            // 좌석 그리드
            Expanded(
              child: ListView.builder(
                itemCount: _seatSelected.length,
                itemBuilder: (context, row) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        // A, B 열
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 50),
                              _buildSeat(row, 0, colorScheme), // A열
                              const SizedBox(width: 8),
                              _buildSeat(row, 1, colorScheme), // B열
                            ],
                          ),
                        ),

                        // 구분선
                        Container(
                          width: 20,
                          height: 60,
                          child: Center(
                            child: Text(
                              (row + 1).toString(),
                              style: TextStyle(
                                color: colorScheme.onSurface.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),

                        // C, D 열
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSeat(row, 2, colorScheme), // C열
                              const SizedBox(width: 8),
                              _buildSeat(row, 3, colorScheme),
                              const SizedBox(width: 50), // D열
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 예매하기 버튼
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _hasSelectedSeat ? _confirmBooking : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    '예매하기',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeat(int row, int col, ColorScheme colorScheme) {
    final selected = _seatSelected[row][col];
    final seatLabel = String.fromCharCode(65 + col) + (row + 1).toString();

    return GestureDetector(
      onTap: () => _toggleSeat(row, col),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: selected
              ? Colors.purple
              : (colorScheme.brightness == Brightness.dark
                    ? Colors.grey[700]
                    : Colors.grey[300]),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.onSurface.withOpacity(0.3)),
        ),
        child: Center(
          child: Text(
            seatLabel,
            style: TextStyle(
              color: selected ? Colors.white : colorScheme.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _seatHeader(String text, ColorScheme colorScheme) {
    return SizedBox(
      width: 60,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
