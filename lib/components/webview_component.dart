import 'package:flutter/material.dart';

class WebViewComponent extends StatefulWidget {
  final String initialUrl;
  final String title;
  final Color backgroundColor;

  const WebViewComponent({
    Key? key,
    required this.initialUrl,
    this.title = 'WebView',
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  State<WebViewComponent> createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<WebViewComponent> {
  bool _isLoading = true;
  String _currentUrl = '';
  bool _platformError = false;

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.initialUrl;
    // 模拟加载过程
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
        // 模拟平台错误
        _platformError = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                // 显示平台错误信息
                if (_platformError)
                  Container(
                    color: Colors.red.shade50,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 48, color: Colors.red),
                            const SizedBox(height: 16),
                            const Text(
                              'WebView 平台实现错误',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '当前平台缺少 webview_flutter 的实现。\n请确保在支持的平台上运行，如 Android 或 iOS。',
                              style: const TextStyle(fontSize: 14, color: Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              },
                              child: const Text('重试'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                // 加载指示器
                if (_isLoading)
                  Container(
                    color: Colors.white.withOpacity(0.8),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '当前URL: ${_currentUrl}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    },
                    icon: const Icon(Icons.refresh, size: 16),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
