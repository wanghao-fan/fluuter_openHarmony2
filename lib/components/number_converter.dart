import 'package:flutter/material.dart';

class NumberConverter extends StatefulWidget {
  const NumberConverter({Key? key}) : super(key: key);

  @override
  State<NumberConverter> createState() => _NumberConverterState();
}

class _NumberConverterState extends State<NumberConverter> {
  String _inputValue = '';
  String _binaryValue = '';
  String _octalValue = '';
  String _decimalValue = '';
  String _hexadecimalValue = '';
  String _errorMessage = '';

  void _convertNumber(String value, int fromBase) {
    if (value.isEmpty) {
      setState(() {
        _binaryValue = '';
        _octalValue = '';
        _decimalValue = '';
        _hexadecimalValue = '';
        _errorMessage = '';
      });
      return;
    }

    try {
      int decimal = int.parse(value, radix: fromBase);
      setState(() {
        _binaryValue = decimal.toRadixString(2);
        _octalValue = decimal.toRadixString(8);
        _decimalValue = decimal.toString();
        _hexadecimalValue = decimal.toRadixString(16).toUpperCase();
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = '输入值不符合所选进制的规则';
      });
    }
  }

  Widget _buildInputField(String title, String value, int base, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          onChanged: (text) {
            _inputValue = text;
            _convertNumber(text, base);
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: hint,
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
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildResultCard(String title, String value, Color color) {
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
          Text(
            value.isEmpty ? '---' : value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
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
            '进制转换器',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '在不同进制之间快速转换数字',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 32),

          // 输入区域
          Text(
            '输入数字',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),

          _buildInputField('二进制 (2)', _inputValue, 2, '输入二进制数字 (0-1)'),
          _buildInputField('八进制 (8)', _inputValue, 8, '输入八进制数字 (0-7)'),
          _buildInputField('十进制 (10)', _inputValue, 10, '输入十进制数字'),
          _buildInputField('十六进制 (16)', _inputValue, 16, '输入十六进制数字 (0-9, A-F)'),

          // 错误信息
          if (_errorMessage.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red, width: 1),
              ),
              child: Text(
                _errorMessage,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),

          // 结果展示
          Text(
            '转换结果',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),

          Column(
            children: [
              _buildResultCard('二进制 (2)', _binaryValue, Colors.blue),
              _buildResultCard('八进制 (8)', _octalValue, Colors.green),
              _buildResultCard('十进制 (10)', _decimalValue, Colors.orange),
              _buildResultCard('十六进制 (16)', _hexadecimalValue, Colors.purple),
            ],
          ),

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
                    _inputValue = '';
                    _binaryValue = '';
                    _octalValue = '';
                    _decimalValue = '';
                    _hexadecimalValue = '';
                    _errorMessage = '';
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
                  // 示例：转换数字 42
                  setState(() {
                    _inputValue = '42';
                    _convertNumber('42', 10);
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
                child: const Text('示例: 42'),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}
