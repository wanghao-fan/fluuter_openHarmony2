import 'package:flutter/material.dart';

class BreadcrumbItem {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const BreadcrumbItem({
    required this.label,
    this.isActive = false,
    this.onTap,
  });
}

class ShadcnBreadcrumb extends StatelessWidget {
  final List<BreadcrumbItem> items;
  final String separator;
  final Color? activeColor;
  final Color? inactiveColor;
  final TextStyle? activeStyle;
  final TextStyle? inactiveStyle;

  const ShadcnBreadcrumb({
    super.key,
    required this.items,
    this.separator = '/',
    this.activeColor = const Color(0xFF3B82F6),
    this.inactiveColor = const Color(0xFF64748B),
    this.activeStyle,
    this.inactiveStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (int i = 0; i < items.length; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: items[i].onTap,
                child: Text(
                  items[i].label,
                  style: items[i].isActive
                      ? (activeStyle ??
                          TextStyle(
                            color: activeColor,
                            fontWeight: FontWeight.w500,
                          ))
                      : (inactiveStyle ??
                          TextStyle(
                            color: inactiveColor,
                          )),
                ),
              ),
              if (i < items.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    separator,
                    style: TextStyle(
                      color: inactiveColor,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
