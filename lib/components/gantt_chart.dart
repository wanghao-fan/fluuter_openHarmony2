import 'package:flutter/material.dart';

// 甘特图任务模型
class GanttTask {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final Color color;
  bool isSelected;

  GanttTask({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.color = Colors.blue,
    this.isSelected = false,
  });

  Duration get duration => endDate.difference(startDate);
}

// 任务依赖关系模型
class GanttDependency {
  final String sourceId;
  final String targetId;

  GanttDependency({
    required this.sourceId,
    required this.targetId,
  });
}

// 甘特图组件
class GanttChartComponent extends StatefulWidget {
  const GanttChartComponent({super.key});

  @override
  State<GanttChartComponent> createState() => _GanttChartComponentState();
}

class _GanttChartComponentState extends State<GanttChartComponent> {
  // 示例数据
  final List<GanttTask> _tasks = [
    GanttTask(
      id: '1',
      name: '需求分析',
      startDate: DateTime(2024, 1, 1),
      endDate: DateTime(2024, 1, 5),
      color: Colors.blue,
    ),
    GanttTask(
      id: '2',
      name: '设计',
      startDate: DateTime(2024, 1, 6),
      endDate: DateTime(2024, 1, 10),
      color: Colors.green,
    ),
    GanttTask(
      id: '3',
      name: '开发',
      startDate: DateTime(2024, 1, 11),
      endDate: DateTime(2024, 1, 20),
      color: Colors.orange,
    ),
    GanttTask(
      id: '4',
      name: '测试',
      startDate: DateTime(2024, 1, 21),
      endDate: DateTime(2024, 1, 25),
      color: Colors.red,
    ),
    GanttTask(
      id: '5',
      name: '部署',
      startDate: DateTime(2024, 1, 26),
      endDate: DateTime(2024, 1, 30),
      color: Colors.purple,
    ),
  ];

  // 任务依赖关系
  final List<GanttDependency> _dependencies = [
    GanttDependency(sourceId: '1', targetId: '2'),
    GanttDependency(sourceId: '2', targetId: '3'),
    GanttDependency(sourceId: '3', targetId: '4'),
    GanttDependency(sourceId: '4', targetId: '5'),
  ];

  // 布局参数
  final double _taskHeight = 40;
  final double _taskPadding = 8;
  final double _chartWidth = 600;
  final double _chartHeight = 300;
  final double _taskNameWidth = 120;
  final double _timeAxisHeight = 60;

  // 选中状态
  GanttTask? _selectedTask;

  // 计算时间范围
  DateTime get _minDate {
    return _tasks.map((task) => task.startDate).reduce((a, b) => a.isBefore(b) ? a : b);
  }

  DateTime get _maxDate {
    return _tasks.map((task) => task.endDate).reduce((a, b) => a.isAfter(b) ? a : b);
  }

  // 处理任务点击
  void _selectTask(GanttTask task) {
    setState(() {
      if (_selectedTask == task) {
        _selectedTask = null;
        task.isSelected = false;
      } else {
        if (_selectedTask != null) {
          _selectedTask!.isSelected = false;
        }
        _selectedTask = task;
        task.isSelected = true;
      }
    });
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
            '甘特图',
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
              '甘特图用于可视化项目时间安排和任务依赖关系，展示任务的开始时间、结束时间和持续时间。点击任务条可查看详细信息。',
              style: TextStyle(
                fontSize: 14,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          // 甘特图
          Center(
            child: Container(
              width: _chartWidth + _taskNameWidth + 40,
              height: _chartHeight + _timeAxisHeight + 40,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: _chartWidth + _taskNameWidth + 40,
                  child: CustomPaint(
                    painter: GanttChartPainter(
                      tasks: _tasks,
                      dependencies: _dependencies,
                      minDate: _minDate,
                      maxDate: _maxDate,
                      taskHeight: _taskHeight,
                      taskPadding: _taskPadding,
                      chartWidth: _chartWidth,
                      taskNameWidth: _taskNameWidth,
                      timeAxisHeight: _timeAxisHeight,
                      onTaskTap: _selectTask,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 选中信息
          if (_selectedTask != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _selectedTask!.color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _selectedTask!.color,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '任务信息',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('任务名称: ${_selectedTask!.name}'),
                  Text('开始时间: ${_selectedTask!.startDate.toString().split(' ')[0]}'),
                  Text('结束时间: ${_selectedTask!.endDate.toString().split(' ')[0]}'),
                  Text('持续时间: ${_selectedTask!.duration.inDays} 天'),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_selectedTask != null) {
                      _selectedTask!.isSelected = false;
                      _selectedTask = null;
                    }
                    for (final task in _tasks) {
                      task.isSelected = false;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('重置选中'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 甘特图画布绘制器
class GanttChartPainter extends CustomPainter {
  final List<GanttTask> tasks;
  final List<GanttDependency> dependencies;
  final DateTime minDate;
  final DateTime maxDate;
  final double taskHeight;
  final double taskPadding;
  final double chartWidth;
  final double taskNameWidth;
  final double timeAxisHeight;
  final Function(GanttTask) onTaskTap;
  
  // 记录上次点击的任务，防止重复触发
  GanttTask? _lastTappedTask;

  GanttChartPainter({
    required this.tasks,
    required this.dependencies,
    required this.minDate,
    required this.maxDate,
    required this.taskHeight,
    required this.taskPadding,
    required this.chartWidth,
    required this.taskNameWidth,
    required this.timeAxisHeight,
    required this.onTaskTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制时间轴
    _drawTimeAxis(canvas, size);

    // 绘制任务名称和任务条
    _drawTasks(canvas, size);

    // 绘制依赖关系
    _drawDependencies(canvas, size);
  }

  // 绘制时间轴
  void _drawTimeAxis(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    // 绘制时间轴背景
    canvas.drawRect(
      Rect.fromLTWH(taskNameWidth, 0, chartWidth, timeAxisHeight),
      Paint()..color = Colors.grey.withAlpha(20),
    );

    // 绘制时间轴刻度和标签
    final totalDays = maxDate.difference(minDate).inDays;
    const interval = 5; // 每5天一个刻度

    for (int i = 0; i <= totalDays; i += interval) {
      final x = taskNameWidth + (i / totalDays) * chartWidth;
      final date = minDate.add(Duration(days: i));

      // 绘制刻度线
      canvas.drawLine(
        Offset(x, timeAxisHeight - 10),
        Offset(x, timeAxisHeight),
        paint,
      );

      // 绘制日期标签
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${date.month}/${date.day}',
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, timeAxisHeight - 30),
      );
    }

    // 绘制时间轴底部边框
    canvas.drawLine(
      Offset(taskNameWidth, timeAxisHeight),
      Offset(taskNameWidth + chartWidth, timeAxisHeight),
      Paint()..color = Colors.grey..strokeWidth = 2,
    );
  }

  // 绘制任务名称和任务条
  void _drawTasks(Canvas canvas, Size size) {
    for (int i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      final y = timeAxisHeight + i * (taskHeight + taskPadding) + taskPadding;

      // 绘制任务名称
      final textPainter = TextPainter(
        text: TextSpan(
          text: task.name,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: task.isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        ellipsis: '...',
      )..layout(maxWidth: taskNameWidth - 16);

      textPainter.paint(
        canvas,
        Offset(8, y + (taskHeight - textPainter.height) / 2),
      );

      // 计算任务条位置和宽度
      final totalDays = maxDate.difference(minDate).inDays;
      final taskStartDays = task.startDate.difference(minDate).inDays;
      final taskDurationDays = task.duration.inDays;

      final x = taskNameWidth + (taskStartDays / totalDays) * chartWidth;
      final width = (taskDurationDays / totalDays) * chartWidth;

      // 绘制任务条
      final taskPaint = Paint()
        ..color = task.isSelected ? task.color.withAlpha(200) : task.color.withAlpha(150);

      final taskRect = Rect.fromLTWH(x, y, width, taskHeight);
      canvas.drawRRect(
        RRect.fromRectAndRadius(taskRect, Radius.circular(4)),
        taskPaint,
      );

      // 绘制任务条边框
      if (task.isSelected) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(taskRect, Radius.circular(4)),
          Paint()
            ..color = Colors.black
            ..strokeWidth = 2
            ..style = PaintingStyle.stroke,
        );
      }
    }
  }

  // 绘制依赖关系
  void _drawDependencies(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (final dependency in dependencies) {
      final sourceTask = tasks.firstWhere(
        (task) => task.id == dependency.sourceId,
        orElse: () => tasks[0],
      );
      final targetTask = tasks.firstWhere(
        (task) => task.id == dependency.targetId,
        orElse: () => tasks[0],
      );

      final sourceIndex = tasks.indexOf(sourceTask);
      final targetIndex = tasks.indexOf(targetTask);

      if (sourceIndex != -1 && targetIndex != -1) {
        final totalDays = maxDate.difference(minDate).inDays;
        final sourceEndX = taskNameWidth +
            ((sourceTask.endDate.difference(minDate).inDays) / totalDays) * chartWidth;
        final targetStartX = taskNameWidth +
            ((targetTask.startDate.difference(minDate).inDays) / totalDays) * chartWidth;

        final sourceY = timeAxisHeight +
            sourceIndex * (taskHeight + taskPadding) +
            taskPadding +
            taskHeight / 2;
        final targetY = timeAxisHeight +
            targetIndex * (taskHeight + taskPadding) +
            taskPadding +
            taskHeight / 2;

        // 绘制连接线
        final path = Path();
        path.moveTo(sourceEndX, sourceY);
        path.lineTo(sourceEndX + 10, sourceY);
        path.lineTo(sourceEndX + 10, (sourceY + targetY) / 2);
        path.lineTo(targetStartX - 10, (sourceY + targetY) / 2);
        path.lineTo(targetStartX - 10, targetY);
        path.lineTo(targetStartX, targetY);
        canvas.drawPath(path, paint);

        // 绘制箭头
        final arrowPath = Path();
        arrowPath.moveTo(targetStartX, targetY);
        arrowPath.lineTo(targetStartX - 6, targetY - 3);
        arrowPath.lineTo(targetStartX - 6, targetY + 3);
        arrowPath.close();
        canvas.drawPath(arrowPath, Paint()..color = Colors.grey[400]!);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // 只有当旧绘制器的数据与当前不同时才重绘
    if (oldDelegate is GanttChartPainter) {
      // 检查任务列表是否相同
      if (oldDelegate.tasks.length != tasks.length) return true;
      
      // 检查任务是否有变化
      for (int i = 0; i < tasks.length; i++) {
        if (oldDelegate.tasks[i].isSelected != tasks[i].isSelected) {
          return true;
        }
      }
      
      // 其他数据检查...
      return false;
    }
    return true;
  }

  @override
  bool hitTest(Offset position) {
    // 检查是否点击了任务条
    for (int i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      final y = timeAxisHeight + i * (taskHeight + taskPadding) + taskPadding;

      final totalDays = maxDate.difference(minDate).inDays;
      final taskStartDays = task.startDate.difference(minDate).inDays;
      final taskDurationDays = task.duration.inDays;

      final x = taskNameWidth + (taskStartDays / totalDays) * chartWidth;
      final width = (taskDurationDays / totalDays) * chartWidth;

      final taskRect = Rect.fromLTWH(x, y, width, taskHeight);

      if (taskRect.contains(position)) {
        // 只有当点击的任务与上次不同时才触发回调
        if (_lastTappedTask != task) {
          _lastTappedTask = task;
          onTaskTap(task);
        }
        return true;
      }
    }
    
    // 如果没有点击任务条，重置上次点击的任务
    _lastTappedTask = null;
    return false;
  }
}
