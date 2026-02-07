import 'package:flutter/material.dart';

// 桑基图数据模型
class Node {
  final String id;
  final String name;
  final double value;
  double x;
  double y;
  double width;
  double height;
  Color color;
  bool isSelected;

  Node({
    required this.id,
    required this.name,
    required this.value,
    this.x = 0,
    this.y = 0,
    this.width = 20,
    this.height = 0,
    this.color = Colors.blue,
    this.isSelected = false,
  });
}

class Link {
  final String sourceId;
  final String targetId;
  final double value;
  Color color;
  bool isSelected;

  Link({
    required this.sourceId,
    required this.targetId,
    required this.value,
    this.color = Colors.grey,
    this.isSelected = false,
  });
}

class SankeyDiagramComponent extends StatefulWidget {
  const SankeyDiagramComponent({super.key});

  @override
  State<SankeyDiagramComponent> createState() => _SankeyDiagramComponentState();
}

class _SankeyDiagramComponentState extends State<SankeyDiagramComponent> {

  // 示例数据
  final List<Node> _nodes = [
    Node(id: 'A', name: '源头', value: 100, color: Colors.blue),
    Node(id: 'B', name: '处理1', value: 60, color: Colors.green),
    Node(id: 'C', name: '处理2', value: 40, color: Colors.yellow),
    Node(id: 'D', name: '结果1', value: 30, color: Colors.red),
    Node(id: 'E', name: '结果2', value: 30, color: Colors.purple),
    Node(id: 'F', name: '结果3', value: 20, color: Colors.orange),
    Node(id: 'G', name: '结果4', value: 20, color: Colors.teal),
  ];

  final List<Link> _links = [
    Link(sourceId: 'A', targetId: 'B', value: 60, color: Colors.blue.shade300),
    Link(sourceId: 'A', targetId: 'C', value: 40, color: Colors.blue.shade200),
    Link(sourceId: 'B', targetId: 'D', value: 30, color: Colors.green.shade300),
    Link(sourceId: 'B', targetId: 'E', value: 30, color: Colors.green.shade200),
    Link(sourceId: 'C', targetId: 'F', value: 20, color: Colors.yellow.shade300),
    Link(sourceId: 'C', targetId: 'G', value: 20, color: Colors.yellow.shade200),
  ];

  // 布局参数
  final double _nodeWidth = 20;
  final double _nodePadding = 10;
  final double _diagramWidth = 400;
  final double _diagramHeight = 300;
  final double _margin = 40;

  // 选中状态
  Node? _selectedNode;
  Link? _selectedLink;

  @override
  void initState() {
    super.initState();
    _calculateLayout();
  }

  void _calculateLayout() {
    // 计算节点位置和大小
    // 简化布局：分三列排列节点
    final List<List<Node>> columns = [
      [_nodes[0]], // 第一列：源头
      [_nodes[1], _nodes[2]], // 第二列：处理
      [_nodes[3], _nodes[4], _nodes[5], _nodes[6]], // 第三列：结果
    ];

    const double columnWidth = 120;
    const double startX = 20;

    for (int colIndex = 0; colIndex < columns.length; colIndex++) {
      final column = columns[colIndex];
      double totalHeight = column.fold(0, (sum, node) => sum + node.value);
      double currentY = _margin;

      for (final node in column) {
        node.x = startX + colIndex * columnWidth;
        node.y = currentY;
        node.height = (node.value / totalHeight) * (_diagramHeight - _margin * 2);
        node.width = _nodeWidth;
        currentY += node.height + _nodePadding;
      }
    }
  }

  void _selectNode(Node node) {
    setState(() {
      if (_selectedNode == node) {
        _selectedNode = null;
        node.isSelected = false;
      } else {
        if (_selectedNode != null) {
          _selectedNode!.isSelected = false;
        }
        _selectedNode = node;
        node.isSelected = true;
        _selectedLink = null;
        for (final link in _links) {
          link.isSelected = false;
        }
      }
    });
  }

  void _selectLink(Link link) {
    setState(() {
      if (_selectedLink == link) {
        _selectedLink = null;
        link.isSelected = false;
      } else {
        if (_selectedLink != null) {
          _selectedLink!.isSelected = false;
        }
        _selectedLink = link;
        link.isSelected = true;
        _selectedNode = null;
        for (final node in _nodes) {
          node.isSelected = false;
        }
      }
    });
  }

  void _handleTap(Offset position) {
    // 检查是否点击了节点
    for (final node in _nodes) {
      if (position.dx >= node.x &&
          position.dx <= node.x + node.width &&
          position.dy >= node.y &&
          position.dy <= node.y + node.height) {
        _selectNode(node);
        return;
      }
    }

    // 检查是否点击了连接
    for (final link in _links) {
      final sourceNode = _nodes.firstWhere((n) => n.id == link.sourceId);
      final targetNode = _nodes.firstWhere((n) => n.id == link.targetId);

      // 简化的连接点击检测
      final path = Path();
      path.moveTo(sourceNode.x + sourceNode.width, sourceNode.y + sourceNode.height / 2);
      path.quadraticBezierTo(
        (sourceNode.x + targetNode.x) / 2,
        sourceNode.y + sourceNode.height / 2,
        targetNode.x, targetNode.y + targetNode.height / 2,
      );

      // 简化的路径点击检测
      final pathMetrics = path.computeMetrics();
      for (final metric in pathMetrics) {
        final tangent = metric.getTangentForOffset(metric.length / 2);
        if (tangent != null) {
          final distance = (position - tangent.position).distance;
          if (distance < 10) {
            _selectLink(link);
            return;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // 标题
          const Text(
            '桑基图生成器',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 说明文字
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '桑基图用于可视化流量或资源转移路径，展示数据从一个节点到另一个节点的流动情况。点击节点或连接可查看详细信息。',
              style: TextStyle(
                fontSize: 14,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          // 桑基图
          Center(
            child: Container(
              width: _diagramWidth + _margin * 2,
              height: _diagramHeight + _margin * 2,
              child: GestureDetector(
                onTapUp: (TapUpDetails details) {
                  _handleTap(details.localPosition);
                },
                child: CustomPaint(
                  painter: SankeyDiagramPainter(
                    nodes: _nodes,
                    links: _links,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 选中信息
          if (_selectedNode != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _selectedNode!.color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _selectedNode!.color,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '节点信息',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('名称: ${_selectedNode!.name}'),
                  Text('值: ${_selectedNode!.value}'),
                  Text('ID: ${_selectedNode!.id}'),
                ],
              ),
            ),

          if (_selectedLink != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _selectedLink!.color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _selectedLink!.color,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '连接信息',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('源节点: ${_nodes.firstWhere((n) => n.id == _selectedLink!.sourceId).name}'),
                  Text('目标节点: ${_nodes.firstWhere((n) => n.id == _selectedLink!.targetId).name}'),
                  Text('值: ${_selectedLink!.value}'),
                ],
              ),
            ),

          const SizedBox(height: 16),

          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _calculateLayout();
                    if (_selectedNode != null) {
                      _selectedNode!.isSelected = false;
                      _selectedNode = null;
                    }
                    if (_selectedLink != null) {
                      _selectedLink!.isSelected = false;
                      _selectedLink = null;
                    }
                    for (final node in _nodes) {
                      node.isSelected = false;
                    }
                    for (final link in _links) {
                      link.isSelected = false;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('重置视图'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SankeyDiagramPainter extends CustomPainter {
  final List<Node> nodes;
  final List<Link> links;

  SankeyDiagramPainter({
    required this.nodes,
    required this.links,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 绘制连接
    for (final link in links) {
      final sourceNode = nodes.firstWhere((n) => n.id == link.sourceId);
      final targetNode = nodes.firstWhere((n) => n.id == link.targetId);

      final paint = Paint()
        ..color = link.isSelected ? link.color.withAlpha(200) : link.color.withAlpha(150)
        ..strokeWidth = 2;

      // 绘制贝塞尔曲线连接
      final path = Path();
      path.moveTo(sourceNode.x + sourceNode.width, sourceNode.y + sourceNode.height / 2);
      path.quadraticBezierTo(
        (sourceNode.x + targetNode.x) / 2,
        sourceNode.y + sourceNode.height / 2,
        targetNode.x, targetNode.y + targetNode.height / 2,
      );
      canvas.drawPath(path, paint);
    }

    // 绘制节点
    for (final node in nodes) {
      final paint = Paint()
        ..color = node.isSelected ? node.color.withAlpha(200) : node.color.withAlpha(150);

      canvas.drawRect(
        Rect.fromLTWH(node.x, node.y, node.width, node.height),
        paint,
      );

      // 绘制节点边框
      final borderPaint = Paint()
        ..color = node.isSelected ? Colors.black : Colors.grey
        ..strokeWidth = node.isSelected ? 2 : 1
        ..style = PaintingStyle.stroke;

      canvas.drawRect(
        Rect.fromLTWH(node.x, node.y, node.width, node.height),
        borderPaint,
      );

      // 绘制节点标签
      final textPainter = TextPainter(
        text: TextSpan(
          text: node.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(node.x + node.width + 5, node.y),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }


}
