import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ExpandableText extends StatelessWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;
  final String readMoreText;
  final String readLessText;
  final TextStyle? expandIconStyle;
  final Color? expandIconColor;

  const ExpandableText({
    Key? key,
    required this.text,
    this.trimLines = 2,
    this.style,
    this.readMoreText = '展开',
    this.readLessText = '收起',
    this.expandIconStyle,
    this.expandIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: trimLines,
      trimMode: TrimMode.Line,
      style: style ?? const TextStyle(color: Colors.black),
      colorClickableText: Colors.blue,
      trimCollapsedText: readMoreText,
      trimExpandedText: readLessText,
      moreStyle: expandIconStyle ?? TextStyle(color: expandIconColor ?? Colors.blue),
      lessStyle: expandIconStyle ?? TextStyle(color: expandIconColor ?? Colors.blue),
    );
  }
}

// 测试用的Readmore展示组件
class ReadmoreDemo extends StatelessWidget {
  const ReadmoreDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(51),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '文本展开/折叠测试',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          Text(
            '点击下方文本区域测试展开和折叠功能',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // 示例1：默认样式
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '默认样式',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                ExpandableText(
                  text: '这是一段默认样式的测试文本，包含了较长的内容。当文本超出指定行数时，会自动显示展开按钮。点击展开后可以查看完整内容，再次点击可以折叠回原来的状态。这种功能在显示长文本时非常实用，可以节省屏幕空间，同时又能让用户查看完整内容。',
                  trimLines: 2,
                ),
              ],
            ),
          ),

          // 示例2：自定义样式
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '自定义样式',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                ExpandableText(
                  text: '这是一段自定义样式的测试文本，包含了较长的内容。当文本超出指定行数时，会自动显示展开按钮。点击展开后可以查看完整内容，再次点击可以折叠回原来的状态。这种功能在显示长文本时非常实用，可以节省屏幕空间，同时又能让用户查看完整内容。',
                  trimLines: 3,
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontSize: 15,
                    height: 1.5,
                  ),
                  readMoreText: '查看更多',
                  readLessText: '收起',
                  expandIconColor: Colors.green,
                ),
              ],
            ),
          ),

          // 示例3：长文本示例
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '长文本示例',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 8),
                ExpandableText(
                  text: '这是一段非常长的测试文本，包含了大量的内容。当文本超出指定行数时，会自动显示展开按钮。点击展开后可以查看完整内容，再次点击可以折叠回原来的状态。这种功能在显示长文本时非常实用，可以节省屏幕空间，同时又能让用户查看完整内容。' +
                      '这段文本继续延长，以便测试展开和折叠功能的效果。通过这种方式，我们可以在有限的屏幕空间中展示更多的内容，而不会让界面显得过于拥挤。' +
                      '用户可以根据自己的需要决定是否展开查看完整内容，提高了用户体验的灵活性。',
                  trimLines: 2,
                  style: TextStyle(
                    color: Colors.purple.shade800,
                    fontSize: 14,
                  ),
                  readMoreText: '展开全文',
                  readLessText: '收起全文',
                  expandIconColor: Colors.purple,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Text(
            '点击文本末尾的展开/收起按钮查看效果',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}