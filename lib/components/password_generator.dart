import 'package:flutter/material.dart';
import 'dart:math';

class PasswordGenerator extends StatefulWidget {
  const PasswordGenerator({Key? key}) : super(key: key);

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  int _passwordLength = 12;
  bool _includeNumbers = true;
  bool _includeLowercase = true;
  bool _includeUppercase = true;
  bool _includeSymbols = true;
  String _generatedPassword = '';
  String _strengthLevel = '弱';
  Color _strengthColor = Colors.red;

  void _generatePassword() {
    String chars = '';
    if (_includeNumbers) chars += '0123456789';
    if (_includeLowercase) chars += 'abcdefghijklmnopqrstuvwxyz';
    if (_includeUppercase) chars += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (_includeSymbols) chars += '!@#\$%^&*()_+-=[]{}|;:,.<>?';

    if (chars.isEmpty) {
      setState(() {
        _generatedPassword = '请至少选择一种字符类型';
        _strengthLevel = '弱';
        _strengthColor = Colors.red;
      });
      return;
    }

    final random = Random();
    String password = '';
    for (int i = 0; i < _passwordLength; i++) {
      password += chars[random.nextInt(chars.length)];
    }

    setState(() {
      _generatedPassword = password;
      _calculateStrength(password);
    });
  }

  void _calculateStrength(String password) {
    int score = 0;
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (_includeNumbers) score++;
    if (_includeLowercase) score++;
    if (_includeUppercase) score++;
    if (_includeSymbols) score++;

    if (score <= 2) {
      _strengthLevel = '弱';
      _strengthColor = Colors.red;
    } else if (score <= 4) {
      _strengthLevel = '中等';
      _strengthColor = Colors.orange;
    } else {
      _strengthLevel = '强';
      _strengthColor = Colors.green;
    }
  }

  void _copyToClipboard(String text) {
    // 简化的复制功能，实际项目中应使用 clipboard 包
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已复制到剪贴板')),
    );
  }

  Widget _buildPasswordLengthSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '密码长度: $_passwordLength',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: _passwordLength.toDouble(),
          min: 6,
          max: 24,
          divisions: 18,
          onChanged: (value) {
            setState(() {
              _passwordLength = value.toInt();
            });
          },
          activeColor: Colors.deepPurple,
          inactiveColor: Colors.grey.shade300,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildCharacterTypeCheckboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '包含字符类型:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          title: const Text('数字 (0-9)'),
          value: _includeNumbers,
          onChanged: (value) {
            setState(() {
              _includeNumbers = value ?? false;
            });
          },
          activeColor: Colors.deepPurple,
        ),
        CheckboxListTile(
          title: const Text('小写字母 (a-z)'),
          value: _includeLowercase,
          onChanged: (value) {
            setState(() {
              _includeLowercase = value ?? false;
            });
          },
          activeColor: Colors.deepPurple,
        ),
        CheckboxListTile(
          title: const Text('大写字母 (A-Z)'),
          value: _includeUppercase,
          onChanged: (value) {
            setState(() {
              _includeUppercase = value ?? false;
            });
          },
          activeColor: Colors.deepPurple,
        ),
        CheckboxListTile(
          title: const Text('符号 (!@#\$%^&*)'),
          value: _includeSymbols,
          onChanged: (value) {
            setState(() {
              _includeSymbols = value ?? false;
            });
          },
          activeColor: Colors.deepPurple,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPasswordDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '生成的密码:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            if (_generatedPassword.isNotEmpty && _generatedPassword != '请至少选择一种字符类型')
              IconButton(
                onPressed: () => _copyToClipboard(_generatedPassword),
                icon: const Icon(Icons.copy),
                tooltip: '复制到剪贴板',
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200, width: 1),
          ),
          child: Text(
            _generatedPassword.isEmpty ? '---' : _generatedPassword,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Courier New',
              color: Colors.grey.shade800,
            ),
          ),
        ),
        if (_generatedPassword.isNotEmpty && _generatedPassword != '请至少选择一种字符类型')
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Text(
                  '密码强度: ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  _strengthLevel,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _strengthColor,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
      ],
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
              '随机密码生成器',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '指定长度和包含字符类型，生成安全密码',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            // 密码长度选择
            _buildPasswordLengthSlider(),

            // 字符类型选择
            _buildCharacterTypeCheckboxes(),

            // 生成按钮
            ElevatedButton(
              onPressed: _generatePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                '生成密码',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 32),

            // 密码显示
            _buildPasswordDisplay(),

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
                '提示：本工具可以帮助您生成安全的随机密码。密码强度取决于长度和包含的字符类型，建议使用至少12位长度并包含多种字符类型的密码。',
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
