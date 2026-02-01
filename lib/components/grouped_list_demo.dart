import 'package:flutter/material.dart';

class GroupedListDemo extends StatefulWidget {
  const GroupedListDemo({super.key});

  @override
  State<GroupedListDemo> createState() => _GroupedListDemoState();
}

class _GroupedListDemoState extends State<GroupedListDemo> {
  int _selectedTabIndex = 0;

  final List<Widget> _tabs = [
    const Tab(text: '基础分组'),
    const Tab(text: '自定义分组'),
    const Tab(text: '可展开分组'),
    const Tab(text: '排序分组'),
  ];

  final List<Widget> _tabViews = [
    const BasicGroupedList(),
    const CustomGroupedList(),
    const ExpandableGroupedList(),
    const SortedGroupedList(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('分组列表实现'),
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
              icon: Icon(Icons.view_list),
              label: '基础',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: '自定义',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.expand_more),
              label: '可展开',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sort),
              label: '排序',
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

class BasicGroupedList extends StatelessWidget {
  const BasicGroupedList({super.key});

  @override
  Widget build(BuildContext context) {
    // 模拟分组数据
    final Map<String, List<String>> groupedData = {
      'A': ['Apple', 'Apricot', 'Avocado'],
      'B': ['Banana', 'Blueberry', 'Blackberry', 'Blackcurrant'],
      'C': ['Cherry', 'Coconut', 'Cranberry'],
      'D': ['Date', 'Dragonfruit'],
      'E': ['Elderberry'],
      'F': ['Fig', 'Grapefruit'],
    };

    return ListView.builder(
      itemCount: groupedData.length,
      itemBuilder: (context, index) {
        final String groupKey = groupedData.keys.elementAt(index);
        final List<String> items = groupedData[groupKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 分组标题
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey[200],
              child: Text(
                groupKey,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // 分组项目
            ...items.map((item) {
              return ListTile(
                title: Text(item),
                leading: const Icon(Icons.ac_unit),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}

class CustomGroupedList extends StatelessWidget {
  const CustomGroupedList({super.key});

  @override
  Widget build(BuildContext context) {
    // 模拟自定义分组数据
    final List<GroupData> groupedItems = [
      GroupData(
        title: '水果',
        icon: Icons.apple,
        color: Colors.orange,
        items: ['苹果', '香蕉', '橙子', '葡萄', '草莓'],
      ),
      GroupData(
        title: '蔬菜',
        icon: Icons.eco,
        color: Colors.green,
        items: ['西红柿', '黄瓜', '茄子', '土豆', '胡萝卜'],
      ),
      GroupData(
        title: '肉类',
        icon: Icons.kitchen,
        color: Colors.red,
        items: ['牛肉', '猪肉', '鸡肉', '鱼肉'],
      ),
      GroupData(
        title: '乳制品',
        icon: Icons.local_drink,
        color: Colors.blue,
        items: ['牛奶', '酸奶', '奶酪', '黄油'],
      ),
    ];

    return ListView.builder(
      itemCount: groupedItems.length,
      itemBuilder: (context, index) {
        final GroupData group = groupedItems[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 自定义分组标题
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: group.color.withOpacity(0.1),
                border: Border(
                  left: BorderSide(
                    color: group.color,
                    width: 4,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(group.icon, color: group.color),
                  const SizedBox(width: 12),
                  Text(
                    group.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: group.color,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${group.items.length}项',
                    style: TextStyle(
                      color: group.color.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            // 分组项目
            ...group.items.map((item) {
              return ListTile(
                title: Text(item),
                leading: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: group.color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}

class GroupData {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> items;

  GroupData({
    required this.title,
    required this.icon,
    required this.color,
    required this.items,
  });
}

class ExpandableGroupedList extends StatefulWidget {
  const ExpandableGroupedList({super.key});

  @override
  State<ExpandableGroupedList> createState() => _ExpandableGroupedListState();
}

class _ExpandableGroupedListState extends State<ExpandableGroupedList> {
  // 模拟可展开分组数据
  final List<ExpandableGroup> _groups = [
    ExpandableGroup(
      title: '技术文档',
      icon: Icons.description,
      items: ['API文档', '开发指南', '最佳实践', '故障排查'],
    ),
    ExpandableGroup(
      title: '产品设计',
      icon: Icons.design_services,
      items: ['UI设计', 'UX设计', '交互设计', '视觉设计'],
    ),
    ExpandableGroup(
      title: '项目管理',
      icon: Icons.task,
      items: ['需求分析', '进度跟踪', '风险评估', '团队协作'],
    ),
  ];

  void _toggleGroup(int index) {
    setState(() {
      _groups[index].isExpanded = !_groups[index].isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _groups.length,
      itemBuilder: (context, index) {
        final ExpandableGroup group = _groups[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 可点击的分组标题
            GestureDetector(
              onTap: () => _toggleGroup(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.deepPurple[100]!,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(group.icon, color: Colors.deepPurple),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        group.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(
                      group.isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.deepPurple,
                    ),
                  ],
                ),
              ),
            ),
            // 展开/收起的分组项目
            if (group.isExpanded)
              ...group.items.map((item) {
                return ListTile(
                  title: Text(item),
                  leading: const Icon(Icons.chevron_right, size: 16),
                );
              }).toList(),
          ],
        );
      },
    );
  }
}

class ExpandableGroup {
  final String title;
  final IconData icon;
  final List<String> items;
  bool isExpanded;

  ExpandableGroup({
    required this.title,
    required this.icon,
    required this.items,
    this.isExpanded = false,
  });
}

class SortedGroupedList extends StatefulWidget {
  const SortedGroupedList({super.key});

  @override
  State<SortedGroupedList> createState() => _SortedGroupedListState();
}

class _SortedGroupedListState extends State<SortedGroupedList> {
  bool _sortAscending = true;

  // 模拟排序分组数据
  final Map<String, List<Product>> _products = {
    '电子产品': [
      Product(name: '手机', price: 5999),
      Product(name: '电脑', price: 9999),
      Product(name: '平板', price: 3999),
      Product(name: '手表', price: 1999),
    ],
    '家用电器': [
      Product(name: '冰箱', price: 2999),
      Product(name: '洗衣机', price: 1999),
      Product(name: '空调', price: 3999),
      Product(name: '电视', price: 4999),
    ],
    '服装鞋帽': [
      Product(name: 'T恤', price: 199),
      Product(name: '牛仔裤', price: 399),
      Product(name: '运动鞋', price: 599),
      Product(name: '帽子', price: 99),
    ],
  };

  void _toggleSort() {
    setState(() {
      _sortAscending = !_sortAscending;
    });
  }

  List<Product> _sortProducts(List<Product> products) {
    final sorted = List<Product>.from(products);
    sorted.sort((a, b) {
      return _sortAscending ? a.price.compareTo(b.price) : b.price.compareTo(a.price);
    });
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 排序控制栏
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(
              bottom: BorderSide(color: Colors.grey[200]!),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('按价格排序:'),
              ElevatedButton.icon(
                onPressed: _toggleSort,
                icon: Icon(
                  _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
                ),
                label: Text(
                  _sortAscending ? '升序' : '降序',
                ),
              ),
            ],
          ),
        ),
        // 排序后的分组列表
        Expanded(
          child: ListView.builder(
            itemCount: _products.length,
            itemBuilder: (context, index) {
              final String category = _products.keys.elementAt(index);
              final List<Product> products = _products[category]!;
              final List<Product> sortedProducts = _sortProducts(products);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 分组标题
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.blue[50],
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // 排序后的项目
                  ...sortedProducts.map((product) {
                    return ListTile(
                      title: Text(product.name),
                      trailing: Text(
                        '¥${product.price}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      leading: const Icon(Icons.shopping_cart),
                    );
                  }).toList(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class Product {
  final String name;
  final int price;

  Product({
    required this.name,
    required this.price,
  });
}
