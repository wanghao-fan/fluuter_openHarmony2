import 'package:flutter/material.dart';

/// 标签导航组件
class TabNavigationDemo extends StatefulWidget {
  const TabNavigationDemo({super.key});

  @override
  State<TabNavigationDemo> createState() => _TabNavigationDemoState();
}

class _TabNavigationDemoState extends State<TabNavigationDemo> with SingleTickerProviderStateMixin {
  /// 标签控制器
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 初始化标签控制器，管理3个标签
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // 销毁标签控制器
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('标签导航示例'),
        // 顶部标签栏
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '推荐', icon: Icon(Icons.star)),
            Tab(text: '热门', icon: Icon(Icons.local_fire_department)),
            Tab(text: '关注', icon: Icon(Icons.favorite)),
          ],
          // 标签指示器颜色
          indicatorColor: Colors.black,
          // 选中标签文字颜色
          labelColor: Colors.black,
          // 未选中标签文字颜色
          unselectedLabelColor: Colors.black54,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 推荐页面
          const RecommendPage(),
          // 热门页面
          const HotPage(),
          // 关注页面
          const FollowPage(),
        ],
      ),
    );
  }
}

/// 推荐页面
class RecommendPage extends StatefulWidget {
  const RecommendPage({super.key});

  @override
  State<RecommendPage> createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '推荐页面计数器:',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text('增加计数'),
          ),
        ],
      ),
    );
  }
}

/// 热门页面
class HotPage extends StatelessWidget {
  const HotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '热门内容 ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('这是热门页面的示例内容，展示列表效果。'),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 关注页面
class FollowPage extends StatelessWidget {
  const FollowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.favorite,
            size: 80,
            color: Colors.red,
          ),
          const SizedBox(height: 20),
          const Text(
            '关注页面',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('这里展示您关注的内容'),
        ],
      ),
    );
  }
}