import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPageIndicatorComponent extends StatefulWidget {
  final int pageCount;
  final ValueChanged<int>? onPageChanged;
  
  const SmoothPageIndicatorComponent({
    Key? key,
    required this.pageCount,
    this.onPageChanged,
  }) : super(key: key);

  @override
  _SmoothPageIndicatorComponentState createState() => _SmoothPageIndicatorComponentState();
}

class _SmoothPageIndicatorComponentState extends State<SmoothPageIndicatorComponent> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    if (widget.onPageChanged != null) {
      widget.onPageChanged!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: _onPageChanged,
            itemCount: widget.pageCount,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // 点击页面时的交互效果
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Page ${index + 1} clicked!'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  color: _getPageColor(index),
                  child: Center(
                    child: Text(
                      'Page ${index + 1}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SmoothPageIndicator(
            controller: _controller,
            count: widget.pageCount,
            effect: WormEffect(
              activeDotColor: Colors.blue,
              dotColor: Colors.grey,
              dotHeight: 10,
              dotWidth: 10,
              spacing: 10,
            ),
            onDotClicked: (index) {
              _controller.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getPageColor(int index) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
    ];
    return colors[index % colors.length];
  }
}
