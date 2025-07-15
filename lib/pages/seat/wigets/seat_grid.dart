import 'package:flutter/material.dart';

class SeatGrid extends StatelessWidget {
  final List<List<bool>> seatSelected;
  final Function(int, int) onSeatToggle;
  final int startCol;
  final int endCol;

  const SeatGrid({
    super.key,
    required this.seatSelected,
    required this.onSeatToggle,
    required this.startCol,
    required this.endCol,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(seatSelected.length, (row) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(endCol - startCol, (i) {
                final col = startCol + i;
                final selected = seatSelected[row][col];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      print('Seat tapped: row=$row, col=$col'); // 디버깅용
                      onSeatToggle(row, col);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: selected ? Colors.purple : Colors.grey[800],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + col) + (row + 1).toString(),
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.white70,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
