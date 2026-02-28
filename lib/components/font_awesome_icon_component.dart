import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FontAwesomeIconComponent extends StatefulWidget {
  const FontAwesomeIconComponent({Key? key}) : super(key: key);

  @override
  State<FontAwesomeIconComponent> createState() => _FontAwesomeIconComponentState();
}

class _FontAwesomeIconComponentState extends State<FontAwesomeIconComponent> {
  int _selectedIconIndex = 0;
  final List<IconData> _icons = [
    FontAwesomeIcons.home,
    FontAwesomeIcons.search,
    FontAwesomeIcons.bell,
    FontAwesomeIcons.user,
    FontAwesomeIcons.gear,
    FontAwesomeIcons.heart,
    FontAwesomeIcons.shoppingCart,
    FontAwesomeIcons.star,
  ];

  void _selectIcon(int index) {
    setState(() {
      _selectedIconIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('点击了图标 ${index + 1}'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Font Awesome 图标',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: _icons.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _selectIcon(index),
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedIconIndex == index
                        ? Colors.deepPurple.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: _selectedIconIndex == index
                        ? Border.all(color: Colors.deepPurple, width: 2)
                        : null,
                  ),
                  child: Center(
                    child: FaIcon(
                      _icons[index],
                      size: 32,
                      color: _selectedIconIndex == index
                          ? Colors.deepPurple
                          : Colors.grey[700],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          const Text(
            '点击图标查看交互效果',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
