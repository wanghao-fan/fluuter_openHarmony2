import 'package:flutter/material.dart';

class StickyHeaderListDemo extends StatefulWidget {
  const StickyHeaderListDemo({super.key});

  @override
  State<StickyHeaderListDemo> createState() => _StickyHeaderListDemoState();
}

class _StickyHeaderListDemoState extends State<StickyHeaderListDemo> {
  int _selectedTabIndex = 0;

  final List<Widget> _tabs = [
    const Tab(text: '基本固定头'),
    const Tab(text: '分组固定头'),
    const Tab(text: '自定义固定头'),
    const Tab(text: '嵌套滚动固定头'),
  ];

  final List<Widget> _tabViews = [
    const BasicStickyHeader(),
    const GroupedStickyHeader(),
    const CustomStickyHeader(),
    const NestedScrollStickyHeader(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('固定头部列表实现'),
          bottom: TabBar(
            tabs: _tabs,
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: _tabViews,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.view_headline),
              label: '基本',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: '分组',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: '自定义',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_quilt),
              label: '嵌套',
            ),
          ],
          currentIndex: _selectedTabIndex,
          onTap: (index) {
            setState(() {
              _selectedTabIndex = index;
              DefaultTabController.of(context)?.animateTo(index);
            });
          },
        ),
      ),
    );
  }
}

class BasicStickyHeader extends StatelessWidget {
  const BasicStickyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 固定头部
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '基本固定头部',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
            ],
          ),
        ),
        // 滚动列表
        Expanded(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: Text('${index + 1}'),
                ),
                title: Text('列表项 ${index + 1}'),
                subtitle: Text('这是列表项 ${index + 1} 的描述信息'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class GroupedStickyHeader extends StatelessWidget {
  const GroupedStickyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // 模拟分组数据
    final List<Map<String, dynamic>> groupedData = [
      {
        'header': '分组 A',
        'items': List.generate(15, (index) => '项目 ${index + 1}'),
      },
      {
        'header': '分组 B',
        'items': List.generate(12, (index) => '项目 ${index + 1}'),
      },
      {
        'header': '分组 C',
        'items': List.generate(18, (index) => '项目 ${index + 1}'),
      },
      {
        'header': '分组 D',
        'items': List.generate(10, (index) => '项目 ${index + 1}'),
      },
      {
        'header': '分组 E',
        'items': List.generate(20, (index) => '项目 ${index + 1}'),
      },
    ];

    return ListView.builder(
      itemCount: groupedData.length,
      itemBuilder: (context, groupIndex) {
        final group = groupedData[groupIndex];
        final List<String> items = group['items'];

        return Column(
          children: [
            // 分组固定头部
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    color: Colors.yellow,
                    margin: const EdgeInsets.only(right: 12),
                  ),
                  Text(
                    group['header'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${items.length}项)',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // 分组项
            ...items.map((item) {
              return ListTile(
                leading: const Icon(Icons.article, color: Colors.deepPurple),
                title: Text(item),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}

class CustomStickyHeader extends StatelessWidget {
  const CustomStickyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // 自定义固定头部
        SliverPersistentHeader(
          delegate: _CustomStickyHeaderDelegate(),
          pinned: true,
        ),
        // 滚动内容
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green.shade100,
                  child: Icon(Icons.check_circle, color: Colors.green),
                ),
                title: Text('自定义固定头部列表项 ${index + 1}'),
                subtitle: Text('这是一个带有自定义固定头部的列表项'),
              );
            },
            childCount: 50,
          ),
        ),
      ],
    );
  }
}

class _CustomStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal, Colors.teal.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '自定义固定头部',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '功能1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '功能2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '功能3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class NestedScrollStickyHeader extends StatelessWidget {
  const NestedScrollStickyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          // 固定头部
          SliverAppBar(
            title: const Text('嵌套滚动固定头部'),
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.orange.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Header Content',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 固定的标签栏
          SliverPersistentHeader(
            delegate: _TabBarHeaderDelegate(
              TabBar(
                tabs: const [
                  Tab(text: '标签1'),
                  Tab(text: '标签2'),
                  Tab(text: '标签3'),
                ],
                indicatorColor: Colors.orange,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.grey,
              ),
            ),
            pinned: true,
          ),
        ];
      },
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.orange.shade100,
              child: Icon(Icons.star, color: Colors.orange),
            ),
            title: Text('嵌套滚动列表项 ${index + 1}'),
            subtitle: Text('这是一个带有嵌套滚动固定头部的列表项'),
          );
        },
      ),
    );
  }
}

class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _TabBarHeaderDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
