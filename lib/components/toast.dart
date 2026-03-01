import 'package:flutter/material.dart';

class ShadcnToast extends StatelessWidget {
  final String message;
  final ToastType type;
  final Duration duration;

  const ShadcnToast({
    super.key,
    required this.message,
    this.type = ToastType.info,
    this.duration = const Duration(seconds: 3),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(),
            size: 16,
            color: _getTextColor(),
          ),
          const SizedBox(width: 8),
          Text(
            message,
            style: TextStyle(
              color: _getTextColor(),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case ToastType.success:
        return const Color(0xFFECFDF5);
      case ToastType.error:
        return const Color(0xFFFEF2F2);
      case ToastType.warning:
        return const Color(0xFFFFFAEB);
      case ToastType.info:
      default:
        return const Color(0xFFEFF6FF);
    }
  }

  Color _getTextColor() {
    switch (type) {
      case ToastType.success:
        return const Color(0xFF10B981);
      case ToastType.error:
        return const Color(0xFFEF4444);
      case ToastType.warning:
        return const Color(0xFFF59E0B);
      case ToastType.info:
      default:
        return const Color(0xFF3B82F6);
    }
  }

  IconData _getIcon() {
    switch (type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
      default:
        return Icons.info;
    }
  }
}

enum ToastType {
  success,
  error,
  warning,
  info,
}

class ToastService {
  static void show(BuildContext context, String message, {
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlayState = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 0,
        right: 0,
        child: Center(
          child: ShadcnToast(
            message: message,
            type: type,
            duration: duration,
          ),
        ),
      ),
    );

    overlayState.insert(overlayEntry);

    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}
