import 'package:flutter/material.dart';

/// 面包屑导航项数据模型
class BreadcrumbItem {
  final String title;
  final String route;

  const BreadcrumbItem({
    required this.title,
    required this.route,
  });
}

/// 面包屑导航组件
class BreadcrumbNavigation extends StatelessWidget {
  /// 面包屑项列表
  final List<BreadcrumbItem> items;
  
  /// 当前激活的索引
  final int activeIndex;
  
  /// 点击回调
  final Function(int index)? onItemTap;
  
  /// 分隔符
  final Widget separator;
  
  /// 激活状态颜色
  final Color activeColor;
  
  /// 非激活状态颜色
  final Color inactiveColor;
  
  /// 文本样式
  final TextStyle? textStyle;
  
  /// 激活状态文本样式
  final TextStyle? activeTextStyle;

  const BreadcrumbNavigation({
    super.key,
    required this.items,
    required this.activeIndex,
    this.onItemTap,
    this.separator = const Icon(
      Icons.chevron_right,
      size: 16,
    ),
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.textStyle,
    this.activeTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildBreadcrumbItems(),
        ),
      ),
    );
  }

  /// 构建面包屑项列表
  List<Widget> _buildBreadcrumbItems() {
    final List<Widget> breadcrumbItems = [];

    for (int i = 0; i < items.length; i++) {
      final bool isActive = i == activeIndex;

      // 添加面包屑项
      breadcrumbItems.add(
        GestureDetector(
          onTap: () {
            if (onItemTap != null) {
              onItemTap!(i);
            }
          },
          child: Text(
            items[i].title,
            style: (isActive ? activeTextStyle : textStyle) ??
                TextStyle(
                  color: isActive ? activeColor : inactiveColor,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
      );

      // 添加分隔符（最后一项除外）
      if (i < items.length - 1) {
        breadcrumbItems.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: separator,
          ),
        );
      }
    }

    return breadcrumbItems;
  }
}

/// 面包屑导航示例组件
class BreadcrumbNavigationDemo extends StatefulWidget {
  const BreadcrumbNavigationDemo({super.key});

  @override
  State<BreadcrumbNavigationDemo> createState() => _BreadcrumbNavigationDemoState();
}

class _BreadcrumbNavigationDemoState extends State<BreadcrumbNavigationDemo> {
  /// 当前激活的面包屑索引
  int _activeIndex = 2;

  /// 面包屑项列表
  final List<BreadcrumbItem> _items = [
    BreadcrumbItem(title: '首页', route: '/'),
    BreadcrumbItem(title: '分类', route: '/category'),
    BreadcrumbItem(title: '电子产品', route: '/category/electronics'),
    BreadcrumbItem(title: '手机', route: '/category/electronics/phones'),
    BreadcrumbItem(title: '智能手机', route: '/category/electronics/phones/smartphones'),
  ];

  /// 处理面包屑项点击
  void _handleItemTap(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('面包屑导航示例'),
      ),
      body: Column(
        children: [
          // 面包屑导航
          BreadcrumbNavigation(
            items: _items,
            activeIndex: _activeIndex,
            onItemTap: _handleItemTap,
          ),
          
          // 内容区域
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '当前位置: ${_items[_activeIndex].title}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '路由路径: ${_items[_activeIndex].route}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '点击面包屑项可切换当前位置',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}