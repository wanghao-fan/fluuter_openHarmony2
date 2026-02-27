import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// 日历组件
class CalendarComponent extends StatefulWidget {
  const CalendarComponent({super.key});

  @override
  State<CalendarComponent> createState() => _CalendarComponentState();
}

class _CalendarComponentState extends State<CalendarComponent> {
  // 日历控制器
  final CalendarController _controller = CalendarController();
  
  // 选中的日期
  DateTime? _selectedDate;
  
  // 日历数据源
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    // 初始化示例数据
    _initializeAppointments();
  }

  // 初始化预约数据
  void _initializeAppointments() {
    final DateTime today = DateTime.now();
    
    _appointments = [
      // 今天的预约
      Appointment(
        startTime: DateTime(today.year, today.month, today.day, 9, 0, 0),
        endTime: DateTime(today.year, today.month, today.day, 10, 30, 0),
        subject: '团队会议',
        color: Colors.blue,
        isAllDay: false,
      ),
      Appointment(
        startTime: DateTime(today.year, today.month, today.day, 11, 0, 0),
        endTime: DateTime(today.year, today.month, today.day, 12, 0, 0),
        subject: '项目进度讨论',
        color: Colors.green,
        isAllDay: false,
      ),
      Appointment(
        startTime: DateTime(today.year, today.month, today.day, 14, 0, 0),
        endTime: DateTime(today.year, today.month, today.day, 15, 30, 0),
        subject: '客户会面',
        color: Colors.orange,
        isAllDay: false,
      ),
      Appointment(
        startTime: DateTime(today.year, today.month, today.day, 16, 0, 0),
        endTime: DateTime(today.year, today.month, today.day, 17, 0, 0),
        subject: '技术评审',
        color: Colors.red,
        isAllDay: false,
      ),
    ];
  }

  // 处理日期选择
  void _onSelectionChanged(CalendarSelectionDetails details) {
    setState(() {
      _selectedDate = details.date;
    });
  }

  // 处理预约点击
  void _onAppointmentTapped(CalendarTapDetails details) {
    if (details.appointments != null && details.appointments!.isNotEmpty) {
      final Appointment appointment = details.appointments!.first;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(appointment.subject),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('开始时间: ${appointment.startTime.toString()}'),
                Text('结束时间: ${appointment.endTime.toString()}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('确定'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(51),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 标题
          const Text(
            '日历',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 说明文字
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '日历组件用于显示和管理日程安排，支持时间线日视图展示。点击预约可查看详细信息。',
              style: TextStyle(
                fontSize: 14,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          // 日历视图
          SizedBox(
            height: 600,
            child: SfCalendar(
              controller: _controller,
              view: CalendarView.timelineDay,
              dataSource: _getCalendarDataSource(),
              onSelectionChanged: _onSelectionChanged,
              onTap: _onAppointmentTapped,
              // 外观设置
              timeZone: 'Asia/Shanghai',
              timeSlotViewSettings: const TimeSlotViewSettings(
                startHour: 8,
                endHour: 18,
                timeInterval: Duration(minutes: 60),
                timeFormat: 'HH:mm',
              ),
              appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
                final Appointment appointment = details.appointments.first;
                return ClipRect(
                  child: Container(
                    decoration: BoxDecoration(
                      color: appointment.color.withAlpha(150),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      appointment.subject,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // 选中日期信息
          if (_selectedDate != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withAlpha(20),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '选中日期: ${_selectedDate!.toString().split(' ')[0]}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // 获取日历数据源
  _AppointmentDataSource _getCalendarDataSource() {
    return _AppointmentDataSource(_appointments);
  }
}

// 日历数据源类
class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}