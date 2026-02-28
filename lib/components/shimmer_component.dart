import 'package:flutter/material.dart';

// Shimmer 组件
class ShimmerComponent extends StatefulWidget {
  const ShimmerComponent({super.key});

  @override
  State<ShimmerComponent> createState() => _ShimmerComponentState();
}

class _ShimmerComponentState extends State<ShimmerComponent> with SingleTickerProviderStateMixin {
  // 控制 shimmer 效果是否激活
  bool _isShimmering = true;
  
  // 点击次数
  int _tapCount = 0;
  
  // 动画控制器
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制器
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    
    // 初始化动画
    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // 标题
          const Text(
            '特殊光泽效果',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 说明文字
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Shimmer 组件用于实现特殊的光泽效果，可用于加载状态或吸引用户注意力。点击下方卡片可切换效果。',
              style: TextStyle(
                fontSize: 14,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          // Shimmer 效果展示
          GestureDetector(
            onTap: () {
              setState(() {
                _isShimmering = !_isShimmering;
                _tapCount++;
                if (_isShimmering) {
                  _controller.repeat();
                } else {
                  _controller.stop();
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.withAlpha(50)),
              ),
              child: _isShimmering ? _buildShimmerEffect() : _buildContent(),
            ),
          ),
          const SizedBox(height: 16),

          // 点击信息
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '点击次数: $_tapCount\n当前状态: ${_isShimmering ? '光泽效果' : '静态内容'}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // 构建 Shimmer 效果
  Widget _buildShimmerEffect() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题 shimmer
              _buildShimmerItem(width: 200, height: 24, margin: const EdgeInsets.only(bottom: 16)),
              // 内容行 shimmer
              _buildShimmerItem(width: double.infinity, height: 16, margin: const EdgeInsets.only(bottom: 8)),
              _buildShimmerItem(width: 300, height: 16, margin: const EdgeInsets.only(bottom: 8)),
              _buildShimmerItem(width: 250, height: 16, margin: const EdgeInsets.only(bottom: 24)),
              // 按钮 shimmer
              _buildShimmerItem(width: 120, height: 40, borderRadius: 8),
            ],
          );
        },
      ),
    );
  }

  // 构建单个 Shimmer 项目
  Widget _buildShimmerItem({
    required double width,
    required double height,
    EdgeInsets margin = EdgeInsets.zero,
    double borderRadius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: [
            Colors.grey[300]!,
            Colors.white,
            Colors.grey[300]!,
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: Alignment(-1.0, -1.0),
          end: Alignment(1.0, 1.0),
        ),
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return ClipRect(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withAlpha(204), // 0.8 opacity
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                  begin: Alignment(-1.0, 0.0),
                  end: Alignment(1.0, 0.0),
                ),
              ),
              transform: Matrix4.translationValues(width * _animation.value, 0, 0),
            ),
          );
        },
      ),
    );
  }

  // 构建静态内容
  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '示例内容',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '这是一段示例文字，用于展示 Shimmer 效果停止后的静态内容。',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Shimmer 效果可以为用户提供视觉反馈，提升用户体验。',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isShimmering = true;
                _controller.repeat();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('重新启用光泽效果'),
          ),
        ],
      ),
    );
  }
}
