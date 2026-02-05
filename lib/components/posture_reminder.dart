import 'package:flutter/material.dart';
import 'dart:async';

class PostureReminder extends StatefulWidget {
  const PostureReminder({super.key});

  @override
  State<PostureReminder> createState() => _PostureReminderState();
}

class _PostureReminderState extends State<PostureReminder> {
  bool _isReminderActive = false;
  int _remainingTime = 30 * 60; // 默认30分钟
  Timer? _timer;
  bool _isReminding = false;
  bool _isExpanded = false;

  void _startReminder() {
    setState(() {
      _isReminderActive = true;
      _remainingTime = 30 * 60;
      _isReminding = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _isReminding = true;
          _timer?.cancel();
        }
      });
    });
  }

  void _stopReminder() {
    setState(() {
      _isReminderActive = false;
      _isReminding = false;
    });
    _timer?.cancel();
  }

  void _dismissReminder() {
    setState(() {
      _isReminding = false;
      _remainingTime = 30 * 60;
      _startReminder();
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '坐姿提醒',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          if (_isReminding)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.redAccent.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.redAccent, width: 2),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.redAccent,
                    size: 48,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '该调整坐姿了！',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '长时间保持同一姿势容易导致颈椎问题',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _dismissReminder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('我知道了'),
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '下次提醒',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      _formatTime(_remainingTime),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isReminderActive ? Colors.deepPurple : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _isReminderActive ? _stopReminder : _startReminder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isReminderActive ? Colors.grey : Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: Text(_isReminderActive ? '停止提醒' : '开始提醒'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          
          if (_isExpanded)
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '健康提示',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• 保持头部与屏幕平视，避免低头',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Text(
                    '• 肩膀放松，背部挺直贴紧椅背',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Text(
                    '• 手臂自然下垂，手腕保持水平',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Text(
                    '• 每30分钟起身活动一下',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isExpanded ? '收起详情' : '查看健康提示',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.deepPurple,
                    decoration: TextDecoration.underline,
                  ),
                ),
                Icon(
                  _isExpanded ? Icons.arrow_upward : Icons.arrow_downward,
                  color: Colors.deepPurple,
                  size: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
