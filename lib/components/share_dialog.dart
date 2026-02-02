import 'package:flutter/material.dart';

/// 分享平台类型枚举
enum SharePlatform {
  wechat,      // 微信
  moments,     // 朋友圈
  qq,          // QQ
  qzone,       // QQ空间
  weibo,       // 微博
  copyLink,    // 复制链接
  more,        // 更多
}

/// 分享回调函数类型
typedef ShareCallback = Function(SharePlatform platform);

/// 分享弹窗组件
class ShareDialog {
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  /// 显示分享弹窗
  static void show(
    BuildContext context,
    {
    String title = '分享到',
    String content = '',
    String link = '',
    ShareCallback? onShare,
  }) {
    // 如果已经显示了分享弹窗，先隐藏
    if (_isVisible) {
      hide();
    }

    // 创建分享弹窗内容
    final Widget shareDialogWidget = _buildShareDialog(
      context,
      title: title,
      content: content,
      link: link,
      onShare: onShare,
    );

    // 创建OverlayEntry
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: hide,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                shareDialogWidget,
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );

    // 添加到Overlay
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;
  }

  /// 构建分享弹窗
  static Widget _buildShareDialog(
    BuildContext context,
    {
    required String title,
    required String content,
    required String link,
    ShareCallback? onShare,
  }) {
    // 分享平台列表
    final List<Map<String, dynamic>> platforms = [
      {
        'platform': SharePlatform.wechat,
        'icon': Icons.chat,
        'name': '微信',
        'color': Colors.green,
      },
      {
        'platform': SharePlatform.moments,
        'icon': Icons.people,
        'name': '朋友圈',
        'color': Colors.green,
      },
      {
        'platform': SharePlatform.qq,
        'icon': Icons.account_circle,
        'name': 'QQ',
        'color': Colors.blue,
      },
      {
        'platform': SharePlatform.qzone,
        'icon': Icons.photo_album,
        'name': 'QQ空间',
        'color': Colors.yellow,
      },
      {
        'platform': SharePlatform.weibo,
        'icon': Icons.favorite,
        'name': '微博',
        'color': Colors.red,
      },
      {
        'platform': SharePlatform.copyLink,
        'icon': Icons.content_copy,
        'name': '复制链接',
        'color': Colors.grey,
      },
      {
        'platform': SharePlatform.more,
        'icon': Icons.more_horiz,
        'name': '更多',
        'color': Colors.grey,
      },
    ];

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 标题
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // 分享平台网格
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: platforms.length,
            itemBuilder: (context, index) {
              final platform = platforms[index];
              return GestureDetector(
                onTap: () {
                  hide();
                  if (onShare != null) {
                    onShare(platform['platform']);
                  }
                },
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: platform['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Icon(
                        platform['icon'],
                        size: 28,
                        color: platform['color'],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      platform['name'],
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // 取消按钮
          GestureDetector(
            onTap: hide,
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  '取消',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 隐藏分享弹窗
  static void hide() {
    if (_isVisible && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
  }
}