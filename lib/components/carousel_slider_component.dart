import 'package:flutter/material.dart';

class CarouselSliderComponent extends StatefulWidget {
  const CarouselSliderComponent({Key? key}) : super(key: key);

  @override
  State<CarouselSliderComponent> createState() => _CarouselSliderComponentState();
}

class _CarouselSliderComponentState extends State<CarouselSliderComponent> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<String> _images = [
    'https://picsum.photos/id/1018/800/400',
    'https://picsum.photos/id/1015/800/400',
    'https://picsum.photos/id/1019/800/400',
    'https://picsum.photos/id/1025/800/400',
  ];

  @override
  void initState() {
    super.initState();
    // 自动轮播
    Future.delayed(const Duration(seconds: 3), () {
      _autoPlay();
    });
  }

  void _autoPlay() {
    if (_currentIndex < _images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      _pageController.jumpToPage(0);
    }
    Future.delayed(const Duration(seconds: 3), () {
      _autoPlay();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            '图片轮播',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Container(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('点击了第 ${index + 1} 张图片'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: Image.network(
                      _images[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = entry.key;
                    _pageController.jumpToPage(entry.key);
                  });
                },
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? Colors.deepPurple
                        : Colors.grey[300],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          const Text(
            '点击图片查看交互效果',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
