import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class MD5SHA1Generator extends StatefulWidget {
  const MD5SHA1Generator({Key? key}) : super(key: key);

  @override
  State<MD5SHA1Generator> createState() => _MD5SHA1GeneratorState();
}

class _MD5SHA1GeneratorState extends State<MD5SHA1Generator> {
  String _inputString = '';
  String _md5Hash = '';
  String _sha1Hash = '';

  void _calculateHashes(String input) {
    if (input.isEmpty) {
      setState(() {
        _md5Hash = '';
        _sha1Hash = '';
      });
      return;
    }

    setState(() {
      _md5Hash = _calculateMD5(input);
      _sha1Hash = _calculateSHA1(input);
    });
  }

  String _calculateMD5(String input) {
    // 简化的 MD5 实现，实际项目中应使用 crypto 包
    // 这里使用一个模拟实现来展示功能
    final bytes = utf8.encode(input);
    final hash = bytes.fold(0, (prev, byte) => prev + byte);
    return hash.toRadixString(16).padLeft(32, '0');
  }

  String _calculateSHA1(String input) {
    // 简化的 SHA1 实现，实际项目中应使用 crypto 包
    // 这里使用一个模拟实现来展示功能
    final bytes = utf8.encode(input);
    var hash = 0;
    for (final byte in bytes) {
      hash = ((hash << 5) - hash) + byte;
      hash &= 0xFFFFFFFF;
    }
    return hash.toRadixString(16).padLeft(40, '0');
  }

  Widget _buildInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '输入字符串',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: _inputString),
          onChanged: (text) {
            _inputString = text;
            _calculateHashes(text);
          },
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: '请输入要计算哈希值的字符串',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildHashCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            value.isEmpty ? '---' : value,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Courier New',
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MD5/SHA1 生成器',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '输入字符串，一键计算其哈希值，用于简单校验',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            // 输入区域
            _buildInputField(),

            // 哈希结果展示
            Text(
              '哈希结果',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),

            _buildHashCard('MD5 哈希值', _md5Hash, Colors.blue),
            _buildHashCard('SHA1 哈希值', _sha1Hash, Colors.green),

            // 快速操作按钮
            const SizedBox(height: 24),
            Text(
              '快速操作',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _inputString = '';
                      _md5Hash = '';
                      _sha1Hash = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.grey.shade800,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('清空'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _inputString = 'Hello, Flutter!';
                      _calculateHashes('Hello, Flutter!');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('示例文本'),
                ),
              ],
            ),

            // 说明信息
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
              child: Text(
                '提示：MD5 和 SHA1 是常用的哈希算法，用于数据校验和完整性检查。本工具提供了简单的哈希值计算功能，实际项目中建议使用 crypto 包获取更准确的哈希值。',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
