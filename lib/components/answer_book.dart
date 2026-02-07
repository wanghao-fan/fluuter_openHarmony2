import 'package:flutter/material.dart';
import 'dart:math';

class AnswerBookComponent extends StatefulWidget {
  const AnswerBookComponent({super.key});

  @override
  State<AnswerBookComponent> createState() => _AnswerBookComponentState();
}

class _AnswerBookComponentState extends State<AnswerBookComponent> {
  final List<String> _answers = [
    '是的，毫无疑问',
    '当然，这是肯定的',
    '你可以相信它',
    '从我的角度看，是的',
    '可能性很大',
    '前景看好',
    '是的',
    '迹象表明是这样',
    '不完全是',
    '目前还不确定',
    '很难预测',
    '最好不要现在回答',
    '我现在不能告诉你',
    '需要更多信息',
    '看法不一',
    '考虑其他选择',
    '前景不确定',
    '不要指望它',
    '我的回答是否定的',
    '根据我的判断，不会',
    '可能性很小',
    '非常怀疑',
    '不可能',
    '绝对不行',
  ];

  String _currentAnswer = '';
  bool _isAnswering = false;
  bool _isShaking = false;

  void _getAnswer() {
    setState(() {
      _isAnswering = true;
      _isShaking = true;
      _currentAnswer = '';
    });

    // 模拟摇晃效果和延迟，增加神秘感
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isShaking = false;
        _currentAnswer = _answers[Random().nextInt(_answers.length)];
        _isAnswering = false;
      });
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
            '答案之书',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 问题提示
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '在心中默念你的问题，然后点击下方按钮获取答案',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          // 答案显示区域
          Container(
            height: 200,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.deepPurple.withAlpha(100),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(30),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: _isShaking
                  ? (Matrix4.identity()..rotateZ(Random().nextDouble() * 0.1 - 0.05))
                  : Matrix4.identity(),
              child: Center(
                child: _isAnswering
                    ? const CircularProgressIndicator(
                        color: Colors.deepPurple,
                      )
                    : _currentAnswer.isNotEmpty
                        ? Text(
                            _currentAnswer,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            '点击下方按钮获取答案',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade500,
                            ),
                            textAlign: TextAlign.center,
                          ),
              ),
            ),
          ),
          const SizedBox(height: 32),

          // 按钮
          InkWell(
            onTap: _getAnswer,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withAlpha(50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                '获取答案',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 说明文字
          Text(
            '答案之书只能作为参考，真正的决定还需要你自己做出',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
