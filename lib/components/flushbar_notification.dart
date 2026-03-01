import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

class FlushbarNotification {
  // 显示成功消息
  static void showSuccess(BuildContext context, String message) {
    Flushbar(
      title: '成功',
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check_circle, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      onTap: (flushbar) {
        flushbar.dismiss(true);
      },
    ).show(context);
  }

  // 显示错误消息
  static void showError(BuildContext context, String message) {
    Flushbar(
      title: '错误',
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      icon: const Icon(Icons.error, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      onTap: (flushbar) {
        flushbar.dismiss(true);
      },
    ).show(context);
  }

  // 显示信息消息
  static void showInfo(BuildContext context, String message) {
    Flushbar(
      title: '信息',
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.blue,
      icon: const Icon(Icons.info, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      onTap: (flushbar) {
        flushbar.dismiss(true);
      },
    ).show(context);
  }

  // 显示警告消息
  static void showWarning(BuildContext context, String message) {
    Flushbar(
      title: '警告',
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.orange,
      icon: const Icon(Icons.warning, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      onTap: (flushbar) {
        flushbar.dismiss(true);
      },
    ).show(context);
  }

  // 显示自定义消息
  static void showCustom(
    BuildContext context,
    String title,
    String message,
    Color backgroundColor,
    IconData icon,
  ) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
      icon: Icon(icon, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(8),
      onTap: (flushbar) {
        flushbar.dismiss(true);
      },
    ).show(context);
  }
}

// 测试用的Flushbar展示组件
class FlushbarDemo extends StatelessWidget {
  const FlushbarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
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
          const Text(
            '消息通知测试',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          Text(
            '点击下方按钮测试不同类型的消息通知',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: () {
                  FlushbarNotification.showSuccess(context, '操作成功完成！');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('成功消息'),
              ),
              ElevatedButton(
                onPressed: () {
                  FlushbarNotification.showError(context, '操作失败，请重试');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('错误消息'),
              ),
              ElevatedButton(
                onPressed: () {
                  FlushbarNotification.showInfo(context, '这是一条信息通知');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('信息消息'),
              ),
              ElevatedButton(
                onPressed: () {
                  FlushbarNotification.showWarning(context, '请注意，操作有风险');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: const Text('警告消息'),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            '点击消息可以关闭通知',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}