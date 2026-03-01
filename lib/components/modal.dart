import 'package:flutter/material.dart';

class ShadcnModal extends StatelessWidget {
  final Widget child;
  final bool isOpen;
  final Function() onClose;
  final String? title;
  final Widget? footer;

  const ShadcnModal({
    super.key,
    required this.child,
    required this.isOpen,
    required this.onClose,
    this.title,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    if (!isOpen) {
      return Container();
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Backdrop
          GestureDetector(
            onTap: onClose,
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          // Modal content
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              constraints: BoxConstraints(
                maxWidth: 400,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  if (title != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        GestureDetector(
                          onTap: onClose,
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  if (title != null)
                    const SizedBox(height: 16),
                  
                  // Content
                  Flexible(
                    child: child,
                  ),
                  
                  // Footer
                  if (footer != null)
                    const SizedBox(height: 24),
                  if (footer != null)
                    footer!,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
