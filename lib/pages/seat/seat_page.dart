import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  const SeatPage({super.key, required this.departure, required this.arrival});

  static const String routeName = '/seat';

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // 예시로 5행 x 4열 좌석 구성
  final List<List<bool>> _seatSelected = List.generate(
    5,
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
  @override
  Widget build(BuildContext context) {
    final selectedCount = _seatSelected
        .expand((row) => row)
        .where((selected) => selected)
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택', style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),

          // 출발/도착역
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.departure,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.arrow_forward, size: 24, color: Colors.grey),
              const SizedBox(width: 16),
              Text(
                widget.arrival,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 좌석 상태 안내
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 선택 가능
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('선택 가능'),
                ],
              ),
              const SizedBox(width: 20),
              // 선택됨
              Row(
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(color: Colors.purple),
                  ),
                  const SizedBox(width: 4),
                  const Text('선택됨'),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final row = index ~/ 4;
                  final col = index % 4;
                  final selected = _seatSelected[row][col];

                  return GestureDetector(
                    onTap: () => _toggleSeat(row, col),
                    child: Container(
                      decoration: BoxDecoration(
                        color: selected ? Colors.purple : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          '${row + 1}-${col + 1}',
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
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
    );
  }
}
