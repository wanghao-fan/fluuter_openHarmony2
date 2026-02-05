import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordType {
  static const String feeding = 'feeding';
  static const String diaper = 'diaper';
}

class RecordItem {
  final String id;
  final String type;
  final DateTime time;
  final String? notes;

  RecordItem({
    required this.id,
    required this.type,
    required this.time,
    this.notes,
  });
}

class BabyFeedingTracker extends StatefulWidget {
  const BabyFeedingTracker({Key? key}) : super(key: key);

  @override
  State<BabyFeedingTracker> createState() => _BabyFeedingTrackerState();
}

class _BabyFeedingTrackerState extends State<BabyFeedingTracker> {
  List<RecordItem> _records = [];
  TextEditingController _notesController = TextEditingController();

  void _addRecord(String type) {
    setState(() {
      _records.add(RecordItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: type,
        time: DateTime.now(),
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      ));
      _notesController.clear();
    });
  }

  void _deleteRecord(String id) {
    setState(() {
      _records.removeWhere((record) => record.id == id);
    });
  }

  String _formatTime(DateTime time) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(time);
  }

  Widget _buildRecordItem(RecordItem record) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: record.type == RecordType.feeding
            ? Colors.blue.shade50
            : Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: record.type == RecordType.feeding
              ? Colors.blue.shade200
              : Colors.green.shade200,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.type == RecordType.feeding ? '喂奶' : '换尿布',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: record.type == RecordType.feeding
                        ? Colors.blue
                        : Colors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatTime(record.time),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                if (record.notes != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '备注: ${record.notes}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: () => _deleteRecord(record.id),
            icon: const Icon(Icons.delete, color: Colors.red),
            tooltip: '删除记录',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Text(
              '婴儿喂养记录',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 24),

            // 备注输入
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: '备注 (可选)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 24),

            // 操作按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () => _addRecord(RecordType.feeding),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '记录喂奶',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () => _addRecord(RecordType.diaper),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '记录换尿布',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // 记录列表
            Text(
              '记录历史',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            if (_records.isEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                alignment: Alignment.center,
                child: Text(
                  '暂无记录',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade500,
                  ),
                ),
              )
            else
              Column(
                children: _records.reversed
                    .map((record) => _buildRecordItem(record))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
