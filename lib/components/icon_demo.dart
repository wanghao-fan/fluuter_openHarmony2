import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IconDemo extends StatelessWidget {
  const IconDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Material Design 图标',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              _buildIconItem(Icons.home, 'home'),
              _buildIconItem(Icons.search, 'search'),
              _buildIconItem(Icons.add, 'add'),
              _buildIconItem(Icons.settings, 'settings'),
              _buildIconItem(Icons.favorite, 'favorite'),
              _buildIconItem(Icons.share, 'share'),
              _buildIconItem(Icons.delete, 'delete'),
              _buildIconItem(Icons.edit, 'edit'),
            ],
          ),
          const SizedBox(height: 32.0),
          const Text(
            'Cupertino 图标',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              _buildCupertinoIconItem(CupertinoIcons.home, 'home'),
              _buildCupertinoIconItem(CupertinoIcons.search, 'search'),
              _buildCupertinoIconItem(CupertinoIcons.add, 'add'),
              _buildCupertinoIconItem(CupertinoIcons.settings, 'settings'),
              _buildCupertinoIconItem(CupertinoIcons.heart, 'heart'),
              _buildCupertinoIconItem(CupertinoIcons.share, 'share'),
              _buildCupertinoIconItem(CupertinoIcons.trash, 'trash'),
              _buildCupertinoIconItem(CupertinoIcons.pencil, 'pencil'),
            ],
          ),
          const SizedBox(height: 32.0),
          const Text(
            '自定义图标',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              _buildCustomIconItem('Flutter', Colors.blue),
              _buildCustomIconItem('OHOS', Colors.red),
              _buildCustomIconItem('Harmony', Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            icon,
            size: 32.0,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }

  Widget _buildCupertinoIconItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(
            icon,
            size: 32.0,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }

  Widget _buildCustomIconItem(String label, Color color) {
    return Column(
      children: [
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              label[0],
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(label),
      ],
    );
  }
}
