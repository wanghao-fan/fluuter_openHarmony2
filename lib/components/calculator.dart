import 'package:flutter/material.dart';

class CalculatorComponent extends StatefulWidget {
  const CalculatorComponent({super.key});

  @override
  State<CalculatorComponent> createState() => _CalculatorComponentState();
}

class _CalculatorComponentState extends State<CalculatorComponent> {
  String _displayText = '0';
  double _firstOperand = 0;
  double _secondOperand = 0;
  String _operator = '';
  bool _isOperatorPressed = false;
  bool _isCalculated = false;

  void _onNumberPressed(String number) {
    setState(() {
      if (_isOperatorPressed || _isCalculated || _displayText == '0') {
        _displayText = number;
        _isOperatorPressed = false;
        _isCalculated = false;
      } else {
        _displayText += number;
      }
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      if (_operator.isEmpty) {
        _firstOperand = double.parse(_displayText);
      } else if (!_isOperatorPressed) {
        _secondOperand = double.parse(_displayText);
        _firstOperand = _calculateResult();
        _displayText = _firstOperand.toString();
      }
      _operator = operator;
      _isOperatorPressed = true;
      _isCalculated = false;
    });
  }

  void _onEqualPressed() {
    setState(() {
      if (_operator.isNotEmpty && !_isCalculated) {
        _secondOperand = double.parse(_displayText);
        double result = _calculateResult();
        _displayText = result.toString();
        _firstOperand = result;
        _isCalculated = true;
        _isOperatorPressed = false;
      }
    });
  }

  void _onClearPressed() {
    setState(() {
      _displayText = '0';
      _firstOperand = 0;
      _secondOperand = 0;
      _operator = '';
      _isOperatorPressed = false;
      _isCalculated = false;
    });
  }

  double _calculateResult() {
    switch (_operator) {
      case '+':
        return _firstOperand + _secondOperand;
      case '-':
        return _firstOperand - _secondOperand;
      case '×':
        return _firstOperand * _secondOperand;
      case '÷':
        return _firstOperand / _secondOperand;
      default:
        return _firstOperand;
    }
  }

  Widget _buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            if (text == 'C') {
              _onClearPressed();
            } else if (text == '=') {
              _onEqualPressed();
            } else if ('+-×÷'.contains(text)) {
              _onOperatorPressed(text);
            } else {
              _onNumberPressed(text);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: color ?? Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(51),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor ?? Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
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
          // 显示区域
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
              color: Colors.grey.withAlpha(77),
              width: 1,
            ),
            ),
            child: Text(
              _displayText,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // 按钮区域
          Column(
            children: [
              // 第一行
              Row(
                children: [
                  _buildButton('C', color: Colors.red.shade100, textColor: Colors.red),
                  _buildButton('±', color: Colors.grey.shade200),
                  _buildButton('%', color: Colors.grey.shade200),
                  _buildButton('÷', color: Colors.blue.shade100, textColor: Colors.blue),
                ],
              ),

              // 第二行
              Row(
                children: [
                  _buildButton('7'),
                  _buildButton('8'),
                  _buildButton('9'),
                  _buildButton('×', color: Colors.blue.shade100, textColor: Colors.blue),
                ],
              ),

              // 第三行
              Row(
                children: [
                  _buildButton('4'),
                  _buildButton('5'),
                  _buildButton('6'),
                  _buildButton('-', color: Colors.blue.shade100, textColor: Colors.blue),
                ],
              ),

              // 第四行
              Row(
                children: [
                  _buildButton('1'),
                  _buildButton('2'),
                  _buildButton('3'),
                  _buildButton('+', color: Colors.blue.shade100, textColor: Colors.blue),
                ],
              ),

              // 第五行
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      child: InkWell(
                        onTap: () => _onNumberPressed('0'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withAlpha(51),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Text(
                            '0',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildButton('.'),
                  _buildButton('=', color: Colors.blue, textColor: Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
