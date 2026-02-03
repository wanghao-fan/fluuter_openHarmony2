import 'package:flutter/material.dart';

// 字体样式模型
class FontStyleModel {
  final double fontSize;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final Color fontColor;

  FontStyleModel({
    required this.fontSize,
    required this.fontWeight,
    required this.fontStyle,
    required this.fontColor,
  });

  FontStyleModel copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    Color? fontColor,
  }) {
    return FontStyleModel(
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      fontColor: fontColor ?? this.fontColor,
    );
  }
}

// 字体样式定制组件
class FontStyleCustomizer extends StatefulWidget {
  const FontStyleCustomizer({Key? key}) : super(key: key);

  @override
  _FontStyleCustomizerState createState() => _FontStyleCustomizerState();
}

class _FontStyleCustomizerState extends State<FontStyleCustomizer> {
  // 当前字体样式
  FontStyleModel _currentFontStyle = FontStyleModel(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    fontColor: Colors.black,
  );

  // 字体大小选项
  final List<double> _fontSizeOptions = [12.0, 14.0, 16.0, 18.0, 20.0, 24.0, 30.0];

  // 字体粗细选项
  final List<Map<String, dynamic>> _fontWeightOptions = [
    {'name': '细体', 'weight': FontWeight.w300},
    {'name': '正常', 'weight': FontWeight.normal},
    {'name': ' medium', 'weight': FontWeight.w500},
    {'name': '粗体', 'weight': FontWeight.bold},
  ];

  // 字体样式选项
  final List<Map<String, dynamic>> _fontStyleOptions = [
    {'name': '正常', 'style': FontStyle.normal},
    {'name': '斜体', 'style': FontStyle.italic},
  ];

  // 字体颜色选项
  final List<Color> _fontColorOptions = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.grey,
  ];

  // 更新字体大小
  void _updateFontSize(double size) {
    setState(() {
      _currentFontStyle = _currentFontStyle.copyWith(fontSize: size);
    });
  }

  // 更新字体粗细
  void _updateFontWeight(FontWeight weight) {
    setState(() {
      _currentFontStyle = _currentFontStyle.copyWith(fontWeight: weight);
    });
  }

  // 更新字体样式
  void _updateFontStyle(FontStyle style) {
    setState(() {
      _currentFontStyle = _currentFontStyle.copyWith(fontStyle: style);
    });
  }

  // 更新字体颜色
  void _updateFontColor(Color color) {
    setState(() {
      _currentFontStyle = _currentFontStyle.copyWith(fontColor: color);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 标题
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '字体样式定制功能展示:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '调整下方参数，实时查看字体样式的变化效果。',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 字体效果预览
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '字体效果预览',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hello, Flutter for OpenHarmony!',
                    style: TextStyle(
                      fontSize: _currentFontStyle.fontSize,
                      fontWeight: _currentFontStyle.fontWeight,
                      fontStyle: _currentFontStyle.fontStyle,
                      color: _currentFontStyle.fontColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '这是一段示例文本，用于展示字体样式的变化效果。',
                    style: TextStyle(
                      fontSize: _currentFontStyle.fontSize * 0.8,
                      fontWeight: _currentFontStyle.fontWeight,
                      fontStyle: _currentFontStyle.fontStyle,
                      color: _currentFontStyle.fontColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 字体大小调整
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '字体大小:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _fontSizeOptions.map((size) {
                      return ElevatedButton(
                        onPressed: () => _updateFontSize(size),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentFontStyle.fontSize == size
                              ? Colors.blue
                              : Colors.grey[200],
                          foregroundColor: _currentFontStyle.fontSize == size
                              ? Colors.white
                              : Colors.grey[800],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('${size.toInt()}px'),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: _currentFontStyle.fontSize,
                    min: 12.0,
                    max: 36.0,
                    onChanged: (value) => _updateFontSize(value),
                    divisions: 24,
                    label: '${_currentFontStyle.fontSize.toInt()}px',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 字体粗细调整
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '字体粗细:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _fontWeightOptions.map((option) {
                      return ElevatedButton(
                        onPressed: () => _updateFontWeight(option['weight']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentFontStyle.fontWeight == option['weight']
                              ? Colors.blue
                              : Colors.grey[200],
                          foregroundColor: _currentFontStyle.fontWeight == option['weight']
                              ? Colors.white
                              : Colors.grey[800],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(option['name']),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 字体样式调整
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '字体样式:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _fontStyleOptions.map((option) {
                      return ElevatedButton(
                        onPressed: () => _updateFontStyle(option['style']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _currentFontStyle.fontStyle == option['style']
                              ? Colors.blue
                              : Colors.grey[200],
                          foregroundColor: _currentFontStyle.fontStyle == option['style']
                              ? Colors.white
                              : Colors.grey[800],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(option['name']),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 字体颜色调整
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '字体颜色:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _fontColorOptions.map((color) {
                      return GestureDetector(
                        onTap: () => _updateFontColor(color),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _currentFontStyle.fontColor == color
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // 当前字体样式信息
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '当前字体样式信息:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '字体大小: ${_currentFontStyle.fontSize.toInt()}px',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '字体粗细: ${_getFontWeightName(_currentFontStyle.fontWeight)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '字体样式: ${_currentFontStyle.fontStyle == FontStyle.normal ? '正常' : '斜体'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '字体颜色: ${_getColorName(_currentFontStyle.fontColor)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 获取字体粗细名称
  String _getFontWeightName(FontWeight weight) {
    switch (weight) {
      case FontWeight.w300:
        return '细体';
      case FontWeight.normal:
        return '正常';
      case FontWeight.w500:
        return ' medium';
      case FontWeight.bold:
        return '粗体';
      default:
        return '正常';
    }
  }

  // 获取颜色名称
  String _getColorName(Color color) {
    if (color == Colors.black) return '黑色';
    if (color == Colors.red) return '红色';
    if (color == Colors.blue) return '蓝色';
    if (color == Colors.green) return '绿色';
    if (color == Colors.orange) return '橙色';
    if (color == Colors.purple) return '紫色';
    if (color == Colors.grey) return '灰色';
    return '自定义';
  }
}