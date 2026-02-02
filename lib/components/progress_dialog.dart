import 'package:flutter/material.dart';

/// 自定义进度弹窗组件
class CustomProgressDialog {
  static BuildContext? _dialogContext;

  /// 显示进度弹窗
  /// [context] 上下文
  /// [title] 弹窗标题
  /// [message] 弹窗消息
  /// [isDismissible] 是否可以点击外部关闭
  static void show(
    BuildContext context,
    {
    String title = '加载中',
    String message = '请稍候...',
    bool isDismissible = false,
  }) {
    // 先关闭可能存在的弹窗
    hide();

    _dialogContext = context;

    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(
              minWidth: 280,
              maxWidth: 320,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 标题
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16.0),
                
                // 加载动画
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  strokeWidth: 3.0,
                ),
                const SizedBox(height: 16.0),
                
                // 消息
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 显示成功进度弹窗
  static void showSuccess(
    BuildContext context,
    {
    String title = '操作成功',
    String message = '您的操作已成功完成',
    bool isDismissible = true,
  }) {
    _dialogContext = context;

    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(
              minWidth: 280,
              maxWidth: 320,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 成功图标
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16.0),
                
                // 标题
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8.0),
                
                // 消息
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                
                // 确定按钮
                ElevatedButton(
                  onPressed: () {
                    hide();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('确定'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 显示错误进度弹窗
  static void showError(
    BuildContext context,
    {
    String title = '操作失败',
    String message = '您的操作未能完成，请重试',
    bool isDismissible = true,
  }) {
    _dialogContext = context;

    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            constraints: const BoxConstraints(
              minWidth: 280,
              maxWidth: 320,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 错误图标
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 36,
                  ),
                ),
                const SizedBox(height: 16.0),
                
                // 标题
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8.0),
                
                // 消息
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                
                // 确定按钮
                ElevatedButton(
                  onPressed: () {
                    hide();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('确定'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 隐藏进度弹窗
  static void hide() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!, rootNavigator: true).pop();
      _dialogContext = null;
    }
  }
}