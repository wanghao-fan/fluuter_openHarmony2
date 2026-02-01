import 'package:flutter/material.dart';

class BottomAppBarDemo extends StatefulWidget {
  const BottomAppBarDemo({super.key});

  @override
  State<BottomAppBarDemo> createState() => _BottomAppBarDemoState();
}

class _BottomAppBarDemoState extends State<BottomAppBarDemo> {
  int _selectedIndex = 0;
  bool _showFAB = true;
  bool _useNotch = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('底部应用栏示例'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '底部应用栏类型',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildOptionRow(),
            const SizedBox(height: 32.0),
            Center(
              child: Column(
                children: [
                  const Text(
                    '当前选择',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '索引: $_selectedIndex',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '显示 FAB: $_showFAB',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '使用凹口: $_useNotch',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _showFAB ? _buildFAB() : null,
      floatingActionButtonLocation: _useNotch 
          ? FloatingActionButtonLocation.centerDocked 
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: _buildBottomAppBar(),
    );
  }

  Widget _buildOptionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Text('显示 FAB'),
            Switch(
              value: _showFAB,
              onChanged: (value) {
                setState(() {
                  _showFAB = value;
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            const Text('使用凹口'),
            Switch(
              value: _useNotch,
              onChanged: (value) {
                setState(() {
                  _useNotch = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          _selectedIndex = 4;
        });
      },
      tooltip: '添加',
      child: const Icon(Icons.add),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      shape: _useNotch && _showFAB ? const CircularNotchedRectangle() : null,
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => _onItemTapped(0),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _onItemTapped(1),
          ),
          if (_useNotch && _showFAB) const SizedBox(width: 48.0), // 为 FAB 留出空间
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => _onItemTapped(2),
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _onItemTapped(3),
          ),
        ],
      ),
    );
  }
}
