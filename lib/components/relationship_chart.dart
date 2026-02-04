import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

/// 关系图节点数据模型
class RelationshipNode {
  final String id;         // 节点ID
  final String name;       // 节点名称
  final int symbolSize;    // 节点大小
  final String category;   // 节点分类
  final Color color;       // 节点颜色

  RelationshipNode({
    required this.id,
    required this.name,
    required this.symbolSize,
    required this.category,
    required this.color,
  });

  Map<String, dynamic> toJson() {
    final alpha = (color.a * 255).round();
    final red = (color.r * 255).round();
    final green = (color.g * 255).round();
    final blue = (color.b * 255).round();
    final hexColor = '#${(alpha << 24 | red << 16 | green << 8 | blue).toRadixString(16).padLeft(8, '0')}';
    
    return {
      'id': id,
      'name': name,
      'symbolSize': symbolSize,
      'category': category,
      'itemStyle': {
        'color': hexColor, // 转换为十六进制颜色
      },
    };
  }
}

/// 关系图边数据模型
class RelationshipLink {
  final String source;     // 源节点ID
  final String target;     // 目标节点ID
  final int value;         // 边的权重
  final Color lineStyle;   // 边的颜色

  RelationshipLink({
    required this.source,
    required this.target,
    required this.value,
    required this.lineStyle,
  });

  Map<String, dynamic> toJson() {
    final alpha = (lineStyle.a * 255).round();
    final red = (lineStyle.r * 255).round();
    final green = (lineStyle.g * 255).round();
    final blue = (lineStyle.b * 255).round();
    final hexColor = '#${(alpha << 24 | red << 16 | green << 8 | blue).toRadixString(16).padLeft(8, '0')}';
    
    return {
      'source': source,
      'target': target,
      'value': value,
      'lineStyle': {
        'color': hexColor, // 转换为十六进制颜色
        'width': value / 10, // 根据权重设置线宽
      },
    };
  }
}

/// 关系图分类数据模型
class RelationshipCategory {
  final String name;       // 分类名称

  RelationshipCategory({
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

/// 关系图数据模型
class RelationshipChartData {
  final List<RelationshipNode> nodes;      // 节点列表
  final List<RelationshipLink> links;      // 边列表
  final List<RelationshipCategory> categories; // 分类列表

  RelationshipChartData({
    required this.nodes,
    required this.links,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'nodes': nodes.map((node) => node.toJson()).toList(),
      'links': links.map((link) => link.toJson()).toList(),
      'categories': categories.map((category) => category.toJson()).toList(),
    };
  }
}

/// 关系图核心组件
class RelationshipChartWidget extends StatefulWidget {
  final RelationshipChartData data;  // 关系图数据
  final Function(Map<String, dynamic>)? onNodeClick;  // 节点点击回调
  final Function(Map<String, dynamic>)? onLinkClick;  // 边点击回调

  const RelationshipChartWidget({
    super.key,
    required this.data,
    this.onNodeClick,
    this.onLinkClick,
  });

  @override
  State<RelationshipChartWidget> createState() => _RelationshipChartWidgetState();
}

class _RelationshipChartWidgetState extends State<RelationshipChartWidget> {
  late String _option;

  @override
  void initState() {
    super.initState();
    _initOption();
  }

  @override
  void didUpdateWidget(covariant RelationshipChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _initOption();
    }
  }

  void _initOption() {
    final optionMap = {
      'title': {
        'text': '关系网络图',
        'subtext': 'Flutter for OpenHarmony',
        'top': 'top',
        'left': 'center',
      },
      'tooltip': {
        'trigger': 'item',
        'formatter': '''
          function(params) {
            if (params.dataType === 'node') {
              return params.name + '\\n' + '分类: ' + params.data.category + '\\n' + '大小: ' + params.data.symbolSize;
            } else if (params.dataType === 'edge') {
              return params.data.source + ' -> ' + params.data.target + '\\n' + '强度: ' + params.data.value;
            }
            return '';
          }
        ''',
      },
      'legend': {
        'data': widget.data.categories.map((category) => category.name).toList(),
        'orient': 'vertical',
        'left': 'left',
      },
      'series': [
        {
          'type': 'graph',
          'layout': 'force',
          'data': widget.data.nodes.map((node) => node.toJson()).toList(),
          'links': widget.data.links.map((link) => link.toJson()).toList(),
          'categories': widget.data.categories.map((category) => category.toJson()).toList(),
          'roam': true,
          'label': {
            'show': true,
            'position': 'right',
            'formatter': '{b}',
          },
          'lineStyle': {
            'color': 'source',
            'curveness': 0.3,
          },
          'emphasis': {
            'focus': 'adjacency',
            'lineStyle': {
              'width': 10,
            },
          },
          'force': {
            'repulsion': 100,
            'edgeLength': [40, 100],
          },
          'itemStyle': {
            'borderColor': '#fff',
            'borderWidth': 1,
          },
        },
      ],
    };
    _option = json.encode(optionMap);
  }

  @override
  Widget build(BuildContext context) {
    return Echarts(
      option: _option,
      extensions: [
        // 可以添加自定义扩展
      ],
      onMessage: (String message) {
        final Map<String, dynamic> data = _parseJsObject(message);
        if (data['type'] == 'click') {
          if (data['dataType'] == 'node') {
            widget.onNodeClick?.call(data['data']);
          } else if (data['dataType'] == 'edge') {
            widget.onLinkClick?.call(data['data']);
          }
        }
      },
    );
  }

  Map<String, dynamic> _parseJsObject(String message) {
    // 简单的JSON解析
    try {
      return json.decode(message);
    } catch (e) {
      return {};
    }
  }
}