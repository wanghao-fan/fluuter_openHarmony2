import 'package:flutter/material.dart';

class LongPressTooltip extends StatefulWidget {
  final Widget child;
  final String tooltipText;
  final Duration? waitDuration;
  final Duration? showDuration;
  final Color? tooltipColor;
  final TextStyle? textStyle;
  final double? verticalOffset;
  final bool? preferBelow;

  const LongPressTooltip({
    Key? key,
    required this.child,
    required this.tooltipText,
    this.waitDuration,
    this.showDuration,
    this.tooltipColor,
    this.textStyle,
    this.verticalOffset,
    this.preferBelow,
  }) : super(key: key);

  @override
  State<LongPressTooltip> createState() => _LongPressTooltipState();
}

class _LongPressTooltipState extends State<LongPressTooltip> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltipText,
      waitDuration: widget.waitDuration ?? const Duration(milliseconds: 500),
      showDuration: widget.showDuration ?? const Duration(seconds: 2),
      decoration: BoxDecoration(
        color: widget.tooltipColor ?? Colors.grey[800]!,
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: widget.textStyle ?? const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      verticalOffset: widget.verticalOffset ?? 24,
      preferBelow: widget.preferBelow ?? true,
      child: widget.child,
    );
  }
}

class InteractiveTooltipDemo extends StatefulWidget {
  const InteractiveTooltipDemo({Key? key}) : super(key: key);

  @override
  State<InteractiveTooltipDemo> createState() => _InteractiveTooltipDemoState();
}

class _InteractiveTooltipDemoState extends State<InteractiveTooltipDemo> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '长按提示功能演示',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '长按下方元素查看提示信息',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 32),

          // 长按提示按钮示例
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LongPressTooltip(
                tooltipText: '这是一个信息按钮，点击获取更多信息',
                tooltipColor: Colors.blue,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('获取信息成功')),
                    );
                  },
                  icon: const Icon(Icons.info),
                  label: const Text('信息'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              LongPressTooltip(
                tooltipText: '这是一个设置按钮，点击进入设置页面',
                tooltipColor: Colors.green,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('进入设置页面')),
                    );
                  },
                  icon: const Icon(Icons.settings),
                  label: const Text('设置'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // 长按提示图标示例
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              LongPressTooltip(
                tooltipText: '长按查看个人资料',
                waitDuration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('查看个人资料')),
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.purple.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),

              LongPressTooltip(
                tooltipText: '长按查看通知',
                waitDuration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('查看通知')),
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.notifications,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              LongPressTooltip(
                tooltipText: '长按查看收藏',
                waitDuration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('查看收藏')),
                    );
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.yellow.shade600,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      size: 40,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // 计数器示例
          Center(
            child: Column(
              children: [
                LongPressTooltip(
                  tooltipText: '长按查看当前计数',
                  tooltipColor: Colors.orange,
                  child: GestureDetector(
                    onTap: _incrementCounter,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        '$_counter',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '点击增加计数，长按查看提示',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
