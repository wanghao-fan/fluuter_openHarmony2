import 'package:flutter/material.dart';

/// 全屏弹窗组件
class FullScreenDialog extends StatelessWidget {
  /// 是否显示弹窗
  final bool isVisible;
  
  /// 弹窗内容
  final Widget content;
  
  /// 关闭弹窗的回调
  final VoidCallback onClose;
  
  /// 背景透明度
  final double backgroundOpacity;
  
  /// 动画时长
  final Duration animationDuration;

  const FullScreenDialog({
    super.key,
    required this.isVisible,
    required this.content,
    required this.onClose,
    this.backgroundOpacity = 0.5,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        // 背景遮罩
        GestureDetector(
          onTap: onClose,
          child: AnimatedOpacity(
            opacity: isVisible ? backgroundOpacity : 0.0,
            duration: animationDuration,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
            ),
          ),
        ),
        // 弹窗内容
        AnimatedPositioned(
          top: isVisible ? 0 : MediaQuery.of(context).size.height,
          left: 0,
          right: 0,
          height: MediaQuery.of(context).size.height,
          duration: animationDuration,
          curve: Curves.easeInOut,
          child: GestureDetector(
            // 防止点击内容区域关闭弹窗
            onTap: () {},
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  // 顶部关闭按钮和指示器
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        // 指示器
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 关闭按钮
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: onClose,
                            icon: const Icon(Icons.close),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 内容区域
                  Expanded(
                    child: content,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}