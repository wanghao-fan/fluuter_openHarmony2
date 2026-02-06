import 'package:flutter/material.dart';

class RoundedAvatar extends StatefulWidget {
  final String? imageUrl;
  final String? assetPath;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final Widget? placeholder;
  final String? tooltipText;
  final VoidCallback? onTap;
  final bool showBorder;

  const RoundedAvatar({
    Key? key,
    this.imageUrl,
    this.assetPath,
    required this.radius,
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
    this.placeholder,
    this.tooltipText,
    this.onTap,
    this.showBorder = true,
  }) : super(key: key);

  @override
  State<RoundedAvatar> createState() => _RoundedAvatarState();
}

class _RoundedAvatarState extends State<RoundedAvatar> {
  bool _isPressed = false;

  Widget _buildAvatarContent() {
    if (widget.imageUrl != null) {
      return ClipOval(
        child: Image.network(
          widget.imageUrl!,
          width: widget.radius * 2,
          height: widget.radius * 2,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              width: widget.radius * 2,
              height: widget.radius * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return widget.placeholder ??
                Container(
                  width: widget.radius * 2,
                  height: widget.radius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                );
          },
        ),
      );
    } else if (widget.assetPath != null) {
      return ClipOval(
        child: Image.asset(
          widget.assetPath!,
          width: widget.radius * 2,
          height: widget.radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return widget.placeholder ??
                Container(
                  width: widget.radius * 2,
                  height: widget.radius * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                );
          },
        ),
      );
    } else {
      return widget.placeholder ??
          Container(
            width: widget.radius * 2,
            height: widget.radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade300,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.grey,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(
      width: widget.radius * 2,
      height: widget.radius * 2,
      decoration: widget.showBorder
          ? BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
            )
          : null,
      child: _buildAvatarContent(),
    );

    if (widget.tooltipText != null) {
      avatar = Tooltip(
        message: widget.tooltipText!,
        child: avatar,
      );
    }

    if (widget.onTap != null) {
      avatar = GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: Transform.scale(
          scale: _isPressed ? 0.95 : 1.0,
          child: avatar,
        ),
      );
    }

    return avatar;
  }
}

class AvatarDemo extends StatelessWidget {
  const AvatarDemo({Key? key}) : super(key: key);

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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '圆角头像功能演示',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '点击头像查看交互效果',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            // 网络图片头像示例
            Text(
              '网络图片头像',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedAvatar(
                  imageUrl: 'https://via.placeholder.com/150',
                  radius: 40,
                  tooltipText: '用户头像1',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了头像1')),
                    );
                  },
                ),
                RoundedAvatar(
                  imageUrl: 'https://via.placeholder.com/150/FF0000/FFFFFF',
                  radius: 50,
                  borderColor: Colors.red,
                  tooltipText: '用户头像2',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了头像2')),
                    );
                  },
                ),
                RoundedAvatar(
                  imageUrl: 'https://via.placeholder.com/150/00FF00/FFFFFF',
                  radius: 30,
                  borderColor: Colors.green,
                  tooltipText: '用户头像3',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了头像3')),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 本地资源头像示例
            Text(
              '本地资源头像',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedAvatar(
                  assetPath: 'assets/avatar1.png',
                  radius: 40,
                  tooltipText: '本地头像1',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了本地头像1')),
                    );
                  },
                ),
                RoundedAvatar(
                  assetPath: 'assets/avatar2.png',
                  radius: 50,
                  borderColor: Colors.blue,
                  tooltipText: '本地头像2',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了本地头像2')),
                    );
                  },
                ),
                RoundedAvatar(
                  assetPath: 'assets/avatar3.png',
                  radius: 30,
                  borderColor: Colors.purple,
                  tooltipText: '本地头像3',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了本地头像3')),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 自定义占位符头像示例
            Text(
              '自定义占位符头像',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedAvatar(
                  radius: 40,
                  placeholder: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue, Colors.purple],
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  tooltipText: '自定义占位符1',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了自定义占位符1')),
                    );
                  },
                ),
                RoundedAvatar(
                  radius: 50,
                  placeholder: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.red, Colors.orange],
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.account_circle,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  tooltipText: '自定义占位符2',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了自定义占位符2')),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 无边框头像示例
            Text(
              '无边框头像',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedAvatar(
                  imageUrl: 'https://via.placeholder.com/150/0000FF/FFFFFF',
                  radius: 40,
                  showBorder: false,
                  tooltipText: '无边框头像1',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了无边框头像1')),
                    );
                  },
                ),
                RoundedAvatar(
                  imageUrl: 'https://via.placeholder.com/150/FFFF00/000000',
                  radius: 50,
                  showBorder: false,
                  tooltipText: '无边框头像2',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('点击了无边框头像2')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
