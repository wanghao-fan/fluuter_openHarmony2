import 'package:flutter/material.dart';

class TextOverflowDemo extends StatefulWidget {
  const TextOverflowDemo({super.key});

  @override
  State<TextOverflowDemo> createState() => _TextOverflowDemoState();
}

class _TextOverflowDemoState extends State<TextOverflowDemo> {
  int _selectedTabIndex = 0;

  final List<Widget> _tabs = [
    const Tab(text: '单行溢出'),
    const Tab(text: '多行溢出'),
    const Tab(text: '自定义溢出'),
    const Tab(text: '响应式溢出'),
  ];

  final List<Widget> _tabViews = [
    const SingleLineOverflow(),
    const MultiLineOverflow(),
    const CustomOverflow(),
    const ResponsiveOverflow(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('文本溢出处理方案'),
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
              label: '单行',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_list),
              label: '多行',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: '自定义',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_android),
              label: '响应式',
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

class SingleLineOverflow extends StatelessWidget {
  const SingleLineOverflow({super.key});

  @override
  Widget build(BuildContext context) {
    const String longText = '这是一段很长的文本，用于演示单行文本溢出的处理方式。当文本长度超过容器宽度时，需要进行适当的处理，以确保界面的美观性。';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('单行文本溢出处理方式：', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16.0),
          
          const Text('1. Ellipsis（省略号）：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              longText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 16.0),
          
          const Text('2. Fade（渐变消失）：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              longText,
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
          ),
          const SizedBox(height: 16.0),
          
          const Text('3. Clip（裁剪）：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              longText,
              overflow: TextOverflow.clip,
              maxLines: 1,
              softWrap: false,
            ),
          ),
          const SizedBox(height: 16.0),
          
          const Text('4. Visible（可见）：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              longText,
              overflow: TextOverflow.visible,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}

class MultiLineOverflow extends StatelessWidget {
  const MultiLineOverflow({super.key});

  @override
  Widget build(BuildContext context) {
    const String longText = '这是一段很长的文本，用于演示多行文本溢出的处理方式。当文本长度超过容器宽度时，需要进行适当的处理，以确保界面的美观性。这种方式适用于需要显示更多文本内容，但又要限制显示行数的场景。';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('多行文本溢出处理方式：', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16.0),
          
          const Text('1. 2行文本，末尾省略：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              longText,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 16.0),
          
          const Text('2. 3行文本，末尾省略：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Text(
              longText,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 16.0),
          
          const Text('3. 使用 Expanded 自动适应：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            height: 120.0,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const Expanded(
              child: Text(
                longText,
                overflow: TextOverflow.ellipsis,
                maxLines: null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomOverflow extends StatefulWidget {
  const CustomOverflow({super.key});

  @override
  State<CustomOverflow> createState() => _CustomOverflowState();
}

class _CustomOverflowState extends State<CustomOverflow> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    const String longText = '这是一段很长的文本，用于演示自定义文本溢出的处理方式。当文本长度超过容器宽度时，我们可以实现一些自定义的交互效果，比如点击展开/收起文本，或者添加"查看更多"按钮等。这种方式可以提供更好的用户体验，让用户可以根据需要选择是否查看完整内容。';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('自定义文本溢出处理方式：', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16.0),
          
          const Text('1. 点击展开/收起：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  longText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: _expanded ? null : 2,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                  child: Text(
                    _expanded ? '收起' : '展开',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          
          const Text('2. 带"查看更多"按钮：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Stack(
              children: [
                const Text(
                  longText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('查看更多'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ResponsiveOverflow extends StatelessWidget {
  const ResponsiveOverflow({super.key});

  @override
  Widget build(BuildContext context) {
    const String longText = '这是一段很长的文本，用于演示响应式文本溢出的处理方式。在不同屏幕尺寸下，文本的显示方式会自动调整，以适应不同的容器宽度。这种方式可以确保在各种设备上都能提供良好的用户体验。';

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('响应式文本溢出处理方式：', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16.0),
          
          const Text('1. 自适应容器宽度：', style: TextStyle(fontWeight: FontWeight.bold)),
          LayoutBuilder(
            builder: (context, constraints) {
              int maxLines = constraints.maxWidth > 300 ? 3 : 2;
              
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  longText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: maxLines,
                ),
              );
            },
          ),
          const SizedBox(height: 16.0),
          
          const Text('2. 不同屏幕尺寸的处理：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: MediaQuery.of(context).size.width > 600
                ? const Text(
                    longText,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  )
                : const Text(
                    longText,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
          ),
          const SizedBox(height: 16.0),
          
          const Text('3. 使用 FittedBox 自动调整字体大小：', style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            width: 200.0,
            height: 60.0,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: const FittedBox(
              fit: BoxFit.contain,
              child: Text(
                '这段文本会根据容器大小自动调整字体大小',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
