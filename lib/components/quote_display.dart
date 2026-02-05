import 'dart:math';
import 'package:flutter/material.dart';
import 'quote_data.dart';

class QuoteDisplay extends StatefulWidget {
  const QuoteDisplay({Key? key}) : super(key: key);

  @override
  State<QuoteDisplay> createState() => _QuoteDisplayState();
}

class _QuoteDisplayState extends State<QuoteDisplay> {
  late Quote _currentQuote;
  final Random _random = Random();
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _currentQuote = _getRandomQuote();
  }

  Quote _getRandomQuote() {
    final index = _random.nextInt(QuoteData.quotes.length);
    return QuoteData.quotes[index];
  }

  void _refreshQuote() {
    if (!_isAnimating) {
      setState(() {
        _isAnimating = true;
      });

      // 动画效果
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _currentQuote = _getRandomQuote();
          _isAnimating = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _refreshQuote,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 引用图标
            const Icon(
              Icons.format_quote,
              size: 48,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 20),

            // 名言文本
            AnimatedOpacity(
              opacity: _isAnimating ? 0.5 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Text(
                _currentQuote.text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade800,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),

            // 作者
            AnimatedOpacity(
              opacity: _isAnimating ? 0.5 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Text(
                '- ${_currentQuote.author}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(height: 16),

            // 提示文本
            Text(
              '点击卡片获取新名言',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
