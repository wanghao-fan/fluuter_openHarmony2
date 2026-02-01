import 'package:flutter/material.dart';

class FlowLayoutDemo extends StatefulWidget {
  const FlowLayoutDemo({super.key});

  @override
  State<FlowLayoutDemo> createState() => _FlowLayoutDemoState();
}

class _FlowLayoutDemoState extends State<FlowLayoutDemo> {
  int _selectedTabIndex = 0;

  final List<Widget> _tabs = [
    const Tab(text: '基本 Wrap'),
    const Tab(text: '带间距 Wrap'),
    const Tab(text: '对齐方式'),
    const Tab(text: 'Flow 布局'),
  ];

  final List<Widget> _tabViews = [
    const BasicWrap(),
    const SpacedWrap(),
    const AlignedWrap(),
    const FlowLayout(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('流式布局示例'),
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
              icon: Icon(Icons.view_week),
              label: '基本',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.space_bar),
              label: '间距',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_align_left),
              label: '对齐',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_on),
              label: 'Flow',
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

class BasicWrap extends StatelessWidget {
  const BasicWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        children: _buildChipList(),
      ),
    );
  }

  List<Widget> _buildChipList() {
    final List<String> tags = [
      'Flutter', 'OpenHarmony', 'Dart', 'UI', 'Layout',
      'Widget', 'Mobile', 'Cross-Platform', 'Development', 'Flow',
      'Wrap', 'Alignment', 'Spacing', 'Flexible', 'Responsive'
    ];

    return tags.map((tag) {
      return Chip(
        label: Text(tag),
        backgroundColor: Colors.blue.shade100,
      );
    }).toList();
  }
}

class SpacedWrap extends StatelessWidget {
  const SpacedWrap({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: _buildColorBoxes(),
      ),
    );
  }

  String _getColorHex(Color color) {
    try {
      final String colorString = color.toString();
      if (colorString.contains('(0x')) {
        final parts = colorString.split('(0x');
        if (parts.length > 1) {
          final hexPart = parts[1];
          if (hexPart.length >= 6) {
            return hexPart.substring(0, 6).toUpperCase();
          }
        }
      }
      return '000000';
    } catch (e) {
      return '000000';
    }
  }

  List<Widget> _buildColorBoxes() {
    final List<Color> colors = [
      Colors.red, Colors.orange, Colors.yellow, Colors.green,
      Colors.blue, Colors.indigo, Colors.purple, Colors.pink,
      Colors.teal, Colors.cyan, Colors.lime, Colors.amber,
      Colors.brown, Colors.grey, Colors.blueGrey
    ];

    return colors.map((color) {
      return Container(
        width: 80.0,
        height: 80.0,
        color: color.withOpacity(0.7),
        child: Center(
          child: Text(
            _getColorHex(color),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }).toList();
  }
}

class AlignedWrap extends StatefulWidget {
  const AlignedWrap({super.key});

  @override
  State<AlignedWrap> createState() => _AlignedWrapState();
}

class _AlignedWrapState extends State<AlignedWrap> {
  WrapAlignment _alignment = WrapAlignment.start;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('选择对齐方式:'),
          const SizedBox(height: 16.0),
          _buildAlignmentOptions(),
          const SizedBox(height: 16.0),
          Wrap(
            alignment: _alignment,
            spacing: 8.0,
            runSpacing: 8.0,
            children: _buildTextItems(),
          ),
        ],
      ),
    );
  }

  Widget _buildAlignmentOptions() {
    return Wrap(
      spacing: 8.0,
      children: [
        _buildAlignmentButton(WrapAlignment.start, 'Start'),
        _buildAlignmentButton(WrapAlignment.center, 'Center'),
        _buildAlignmentButton(WrapAlignment.end, 'End'),
        _buildAlignmentButton(WrapAlignment.spaceBetween, 'Space Between'),
        _buildAlignmentButton(WrapAlignment.spaceAround, 'Space Around'),
        _buildAlignmentButton(WrapAlignment.spaceEvenly, 'Space Evenly'),
      ],
    );
  }

  Widget _buildAlignmentButton(WrapAlignment alignment, String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _alignment = alignment;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _alignment == alignment ? Colors.deepPurple : Colors.grey[200],
        foregroundColor: _alignment == alignment ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }

  List<Widget> _buildTextItems() {
    final List<String> items = [
      '短文本', '中等长度的文本', '很长很长的文本内容',
      '短', '中等长度', '很长很长很长的文本',
      '文本1', '文本2', '文本3', '文本4'
    ];

    return items.map((item) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade100,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(item),
      );
    }).toList();
  }
}

class FlowLayout extends StatelessWidget {
  const FlowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Flow(
        delegate: TagFlowDelegate(),
        children: _buildTagItems(),
      ),
    );
  }

  List<Widget> _buildTagItems() {
    final List<String> tags = [
      'Flutter', 'OpenHarmony', 'Dart', 'UI', 'Layout',
      'Widget', 'Mobile', 'Cross-Platform', 'Development', 'Flow',
      'Wrap', 'Alignment', 'Spacing', 'Flexible', 'Responsive',
      'Animation', 'State', 'Widget', 'BuildContext', 'Material'
    ];

    return tags.map((tag) {
      return Chip(
        label: Text(tag),
        backgroundColor: Colors.green.shade100,
        labelStyle: const TextStyle(color: Colors.green),
      );
    }).toList();
  }
}

class TagFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double x = 0.0;
    double y = 0.0;
    double rowHeight = 0.0;

    for (int i = 0; i < context.childCount; i++) {
      final Size childSize = context.getChildSize(i)!;
      
      if (x + childSize.width > context.size.width) {
        x = 0.0;
        y += rowHeight;
        rowHeight = 0.0;
      }

      context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
      x += childSize.width + 8.0;
      rowHeight = rowHeight > childSize.height ? rowHeight : childSize.height;
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return constraints.biggest;
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return false;
  }
}
