import 'package:flutter/material.dart';
import 'shift_types.dart';

class ShiftCalendarCell extends StatelessWidget {
  final int day;
  final bool isCurrentMonth;
  final bool isToday;
  final ShiftType shiftType;
  final VoidCallback onTap;

  const ShiftCalendarCell({
    Key? key,
    required this.day,
    required this.isCurrentMonth,
    required this.isToday,
    required this.shiftType,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEmpty = day == 0;
    final shiftColor = ShiftUtils.getShiftColor(shiftType);
    final shiftTextColor = ShiftUtils.getShiftTextColor(shiftType);
    final shiftName = ShiftUtils.getShiftName(shiftType);

    return GestureDetector(
      onTap: isEmpty ? null : onTap,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isEmpty ? Colors.transparent : shiftColor,
          borderRadius: BorderRadius.circular(8),
          border: isToday
              ? Border.all(color: Colors.deepPurple, width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isEmpty)
              Text(
                '$day',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  color: isCurrentMonth
                      ? (isToday ? Colors.deepPurple : shiftTextColor)
                      : Colors.grey.shade400,
                ),
              ),
            if (!isEmpty && shiftType != ShiftType.none)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  shiftName,
                  style: TextStyle(
                    fontSize: 12,
                    color: shiftTextColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
