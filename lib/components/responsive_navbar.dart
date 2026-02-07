import 'package:flutter/material.dart';

class ResponsiveNavbarComponent extends StatefulWidget {
  const ResponsiveNavbarComponent({super.key});

  @override
  State<ResponsiveNavbarComponent> createState() => _ResponsiveNavbarComponentState();
}

class _ResponsiveNavbarComponentState extends State<ResponsiveNavbarComponent> {
  bool _isMenuOpen = false;
  int _selectedIndex = 0;

  final List<String> _menuItems = [
    '首页',
    '关于我们',
    '产品服务',
    '联系我们',
    '博客',
  ];

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  void _selectMenuItem(int index) {
    setState(() {
      _selectedIndex = index;
      _isMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Desktop Navigation Bar
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '响应式导航栏',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              // Mobile Menu Button
              Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: _toggleMenu,
                    icon: Icon(
                      _isMenuOpen ? Icons.close : Icons.menu,
                      color: Colors.white,
                      size: 24,
                    ),
                    tooltip: _isMenuOpen ? '关闭菜单' : '打开菜单',
                  );
                },
              ),
            ],
          ),
        ),
        
        // Mobile Menu
        if (_isMenuOpen)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _menuItems.asMap().entries.map((entry) {
                int index = entry.key;
                String item = entry.value;
                return InkWell(
                  onTap: () => _selectMenuItem(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: _selectedIndex == index 
                          ? Colors.deepPurple.shade700 
                          : Colors.transparent,
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        color: _selectedIndex == index 
                            ? Colors.white 
                            : Colors.white.withOpacity(0.8),
                        fontWeight: _selectedIndex == index 
                            ? FontWeight.bold 
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        
        // Selected Item Indicator
        if (_selectedIndex != -1)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.1),
              border: Border(
                bottom: BorderSide(
                  color: Colors.deepPurple.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              '当前选中: ${_menuItems[_selectedIndex]}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}
