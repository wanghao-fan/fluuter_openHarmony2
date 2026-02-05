import 'package:flutter/material.dart';
import 'shift_calendar_cell.dart';
import 'shift_types.dart';

class ShiftCalendar extends StatefulWidget {
  const ShiftCalendar({Key? key}) : super(key: key);

  @override
  State<ShiftCalendar> createState() => _ShiftCalendarState();
}

class _ShiftCalendarState extends State<ShiftCalendar> {
  DateTime _currentDate = DateTime.now();
  Map<DateTime, ShiftType> _shiftSchedule = {};
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // 初始化一些示例数据
    _initializeSampleData();
  }

  void _initializeSampleData() {
    final today = DateTime.now();
    for (int i = -5; i <= 10; i++) {
      final date = today.add(Duration(days: i));
      final shiftIndex = i % 4;
      ShiftType shiftType;
      switch (shiftIndex) {
        case 0:
          shiftType = ShiftType.morning;
          break;
        case 1:
          shiftType = ShiftType.afternoon;
          break;
        case 2:
          shiftType = ShiftType.night;
          break;
        case 3:
          shiftType = ShiftType.off;
          break;
        default:
          shiftType = ShiftType.none;
      }
      _shiftSchedule[DateTime(date.year, date.month, date.day)] = shiftType;
    }
  }

  void _previousMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentDate = DateTime(_currentDate.year, _currentDate.month + 1, 1);
    });
  }

  void _goToToday() {
    setState(() {
      _currentDate = DateTime.now();
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _updateShift(ShiftType shiftType) {
    if (_selectedDate != null) {
      setState(() {
        _shiftSchedule[_selectedDate!] = shiftType;
      });
    }
  }

  List<Widget> _buildWeekdayHeaders() {
    const weekdays = ['日', '一', '二', '三', '四', '五', '六'];
    return weekdays.map((weekday) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          child: Text(
            weekday,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<List<int>> _generateCalendarDays() {
    final year = _currentDate.year;
    final month = _currentDate.month;

    // 获取当月第一天是星期几（0-6，0表示星期日）
    final firstDayOfMonth = DateTime(year, month, 1);
    final startingWeekday = firstDayOfMonth.weekday % 7;

    // 获取当月的天数
    final daysInMonth = DateTime(year, month + 1, 0).day;

    // 获取上个月的天数
    final daysInPreviousMonth = DateTime(year, month, 0).day;

    final calendarDays = <List<int>>[];
    var currentWeek = <int>[];

    // 添加上个月的日期
    for (int i = startingWeekday - 1; i >= 0; i--) {
      currentWeek.add(daysInPreviousMonth - i);
    }

    // 添加当月的日期
    for (int day = 1; day <= daysInMonth; day++) {
      if (currentWeek.length == 7) {
        calendarDays.add(currentWeek);
        currentWeek = [];
      }
      currentWeek.add(day);
    }

    // 添加下个月的日期
    var nextMonthDay = 1;
    while (currentWeek.length < 7) {
      currentWeek.add(nextMonthDay++);
    }
    calendarDays.add(currentWeek);

    return calendarDays;
  }

  List<List<Widget>> _buildCalendarGrid() {
    final calendarDays = _generateCalendarDays();
    final year = _currentDate.year;
    final month = _currentDate.month;
    final today = DateTime.now();
    final isCurrentMonth = year == today.year && month == today.month;

    return calendarDays.map((week) {
      return week.map((day) {
        // 确定日期是否属于当前月
        bool isDayInCurrentMonth;
        DateTime date;

        if (day <= DateTime(year, month, 0).day) {
          // 上个月的日期
          isDayInCurrentMonth = false;
          date = DateTime(year, month - 1, day);
        } else if (day > DateTime(year, month + 1, 0).day) {
          // 下个月的日期
          isDayInCurrentMonth = false;
          date = DateTime(year, month + 1, day - DateTime(year, month + 1, 0).day);
        } else {
          // 当前月的日期
          isDayInCurrentMonth = true;
          date = DateTime(year, month, day);
        }

        // 检查是否是今天
        final isToday = isCurrentMonth && day == today.day;

        // 获取该日期的班次
        final shiftType = _shiftSchedule[DateTime(date.year, date.month, date.day)] ?? ShiftType.none;

        return Expanded(
          child: ShiftCalendarCell(
            day: day,
            isCurrentMonth: isDayInCurrentMonth,
            isToday: isToday,
            shiftType: shiftType,
            onTap: () => _selectDate(DateTime(date.year, date.month, date.day)),
          ),
        );
      }).toList();
    }).toList();
  }

  Widget _buildShiftSelector() {
    final shiftTypes = [
      ShiftType.none,
      ShiftType.morning,
      ShiftType.afternoon,
      ShiftType.night,
      ShiftType.off,
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedDate != null
                ? '为 ${_selectedDate!.month}月${_selectedDate!.day}日选择班次'
                : '点击日期选择班次',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: shiftTypes.map((type) {
              return GestureDetector(
                onTap: _selectedDate != null ? () => _updateShift(type) : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: ShiftUtils.getShiftColor(type),
                    border: Border.all(
                      color: _selectedDate != null
                          ? (_shiftSchedule[_selectedDate!] == type
                              ? Colors.deepPurple
                              : Colors.grey.shade300)
                          : Colors.grey.shade300,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    ShiftUtils.getShiftName(type) == '' ? '无' : ShiftUtils.getShiftName(type),
                    style: TextStyle(
                      color: ShiftUtils.getShiftTextColor(type),
                      fontWeight: _selectedDate != null && _shiftSchedule[_selectedDate!] == type
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 月份导航
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _previousMonth,
              ),
              Column(
                children: [
                  Text(
                    '${_currentDate.year}年${_currentDate.month}月',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  TextButton(
                    onPressed: _goToToday,
                    child: Text(
                      '今天',
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextMonth,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 星期标题
          Row(
            children: _buildWeekdayHeaders(),
          ),

          const SizedBox(height: 8),

          // 日历网格
          ..._buildCalendarGrid().map((week) {
            return Row(
              children: week,
              mainAxisSize: MainAxisSize.max,
            );
          }),

          const SizedBox(height: 24),

          // 班次选择器
          _buildShiftSelector(),
        ],
      ),
    );
  }
}
