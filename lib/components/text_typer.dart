import 'package:flutter/material.dart';

class TextTyperComponent extends StatefulWidget {
  const TextTyperComponent({super.key});

  @override
  State<TextTyperComponent> createState() => _TextTyperComponentState();
}

class _TextTyperComponentState extends State<TextTyperComponent> {
  String _fullText = 'Flutter for OpenHarmony 实战：文字打字机效果\n\n这是一个示例文本，展示打字机效果的实现。\n\n通过逐字显示文字，可以创造出更加生动的视觉效果，提升用户体验。\n\n点击屏幕可以重新开始打字动画。';
  String _displayText = '';
  int _currentIndex = 0;
  bool _isTyping = true;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    setState(() {
      _displayText = '';
      _currentIndex = 0;
      _isTyping = true;
      _isCompleted = false;
    });

    _typeNextCharacter();
  }

  void _typeNextCharacter() {
    if (_currentIndex < _fullText.length) {
      setState(() {
        _displayText += _fullText[_currentIndex];
        _currentIndex++;
      });

      Future.delayed(const Duration(milliseconds: 50), () {
        _typeNextCharacter();
      });
    } else {
      setState(() {
        _isTyping = false;
        _isCompleted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_isCompleted) {
          _startTyping();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '文字打字机效果',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[50],
                border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _displayText,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  if (_isTyping)
                    const SizedBox(
                      width: 8,
                      height: 20,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (_isCompleted)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.deepPurple.withOpacity(0.1),
                ),
                child: const Text(
                  '点击屏幕重新开始打字动画',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Text(
              '当前进度: ${_currentIndex}/${_fullText.length}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
