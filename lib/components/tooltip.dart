import 'package:flutter/material.dart';

/// 工具提示类型枚举
enum TooltipType {
  normal, // 普通类型
  success, // 成功类型
  warning, // 警告类型
  error, // 错误类型
}

/// 自定义工具提示组件
class CustomTooltip {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  /// 显示工具提示
  static void show(
    BuildContext context,
    String message,
    {
    TooltipType type = TooltipType.normal,
    Duration duration = const Duration(seconds: 2),
    Alignment alignment = Alignment.topCenter,
    double offsetY = 50.0,
  }) {
    // 如果已经显示了工具提示，先隐藏
    if (_isVisible) {
      hide();
    }

    // 创建工具提示的样式
    final TextStyle textStyle;
    final Color backgroundColor;

    switch (type) {
      case TooltipType.success:
        textStyle = const TextStyle(color: Colors.white, fontSize: 14);
        backgroundColor = Colors.green;
        break;
      case TooltipType.warning:
        textStyle = const TextStyle(color: Colors.white, fontSize: 14);
        backgroundColor = Colors.orange;
        break;
      case TooltipType.error:
        textStyle = const TextStyle(color: Colors.white, fontSize: 14);
        backgroundColor = Colors.red;
        break;
      case TooltipType.normal:
      default:
        textStyle = const TextStyle(color: Colors.white, fontSize: 14);
        backgroundColor = Colors.grey[800]!;
        break;
    }

    // 创建工具提示的内容
    final Widget tooltipWidget = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        message,
        style: textStyle,
        textAlign: TextAlign.center,
      ),
    );

    // 创建OverlayEntry
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: offsetY,
          left: 0,
          right: 0,
          child: Align(
            alignment: alignment,
            child: tooltipWidget,
          ),
        );
      },
    );

    // 添加到Overlay
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;

    // 一段时间后隐藏
    Future.delayed(duration, () {
      hide();
    });
  }

  /// 显示成功工具提示
  static void showSuccess(
    BuildContext context,
    String message,
    {
    Duration duration = const Duration(seconds: 2),
    Alignment alignment = Alignment.topCenter,
    double offsetY = 50.0,
  }) {
    show(
      context,
      message,
      type: TooltipType.success,
      duration: duration,
      alignment: alignment,
      offsetY: offsetY,
    );
  }

  /// 显示警告工具提示
  static void showWarning(
    BuildContext context,
    String message,
    {
    Duration duration = const Duration(seconds: 2),
    Alignment alignment = Alignment.topCenter,
    double offsetY = 50.0,
  }) {
    show(
      context,
      message,
      type: TooltipType.warning,
      duration: duration,
      alignment: alignment,
      offsetY: offsetY,
    );
  }

  /// 显示错误工具提示
  static void showError(
    BuildContext context,
    String message,
    {
    Duration duration = const Duration(seconds: 2),
    Alignment alignment = Alignment.topCenter,
    double offsetY = 50.0,
  }) {
    show(
      context,
      message,
      type: TooltipType.error,
      duration: duration,
      alignment: alignment,
      offsetY: offsetY,
    );
  }

  /// 隐藏工具提示
  static void hide() {
    if (_isVisible && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
  }
}