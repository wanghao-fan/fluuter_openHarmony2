import 'package:flutter/material.dart';

/// 步骤导航项数据模型
class StepItem {
  final String title;
  final String? description;

  const StepItem({
    required this.title,
    this.description,
  });
}

/// 步骤导航组件
class StepNavigation extends StatelessWidget {
  /// 步骤项列表
  final List<StepItem> steps;
  
  /// 当前激活的步骤索引（从0开始）
  final int currentStep;
  
  /// 步骤点击回调
  final Function(int index)? onStepTap;
  
  /// 激活状态颜色
  final Color activeColor;
  
  /// 完成状态颜色
  final Color completedColor;
  
  /// 未激活状态颜色
  final Color inactiveColor;
  
  /// 步骤指示器大小
  final double indicatorSize;
  
  /// 步骤连接线高度
  final double lineHeight;

  const StepNavigation({
    super.key,
    required this.steps,
    required this.currentStep,
    this.onStepTap,
    this.activeColor = Colors.blue,
    this.completedColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.indicatorSize = 32.0,
    this.lineHeight = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: _buildSteps(),
      ),
    );
  }

  /// 构建步骤列表
  List<Widget> _buildSteps() {
    final List<Widget> stepWidgets = [];

    for (int i = 0; i < steps.length; i++) {
      final bool isCompleted = i < currentStep;
      final bool isActive = i == currentStep;
      final bool isInactive = i > currentStep;

      // 添加步骤项
      stepWidgets.add(
        GestureDetector(
          onTap: () {
            if (onStepTap != null) {
              onStepTap!(i);
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 步骤指示器
                Container(
                  width: indicatorSize,
                  height: indicatorSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? completedColor
                        : isActive
                            ? activeColor
                            : inactiveColor,
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                        : Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                // 步骤内容
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[i].title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                            color: isActive ? activeColor : Colors.black,
                          ),
                        ),
                        if (steps[i].description != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              steps[i].description!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // 添加连接线（最后一步除外）
      if (i < steps.length - 1) {
        stepWidgets.add(
          Container(
            margin: EdgeInsets.only(left: indicatorSize / 2 - lineHeight / 2, bottom: 24),
            width: lineHeight,
            height: 24,
            color: i < currentStep ? completedColor : inactiveColor,
          ),
        );
      }
    }

    return stepWidgets;
  }
}

/// 步骤导航示例组件
class StepNavigationDemo extends StatefulWidget {
  const StepNavigationDemo({super.key});

  @override
  State<StepNavigationDemo> createState() => _StepNavigationDemoState();
}

class _StepNavigationDemoState extends State<StepNavigationDemo> {
  /// 当前步骤索引
  int _currentStep = 1;

  /// 步骤列表
  final List<StepItem> _steps = [
    StepItem(
      title: '填写基本信息',
      description: '输入姓名、邮箱和联系电话',
    ),
    StepItem(
      title: '选择服务类型',
      description: '根据您的需求选择合适的服务',
    ),
    StepItem(
      title: '确认订单信息',
      description: '检查订单详情并提交',
    ),
    StepItem(
      title: '完成支付',
      description: '选择支付方式并完成付款',
    ),
  ];

  /// 处理步骤点击
  void _handleStepTap(int index) {
    setState(() {
      _currentStep = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('步骤导航示例'),
      ),
      body: Column(
        children: [
          // 步骤导航
          StepNavigation(
            steps: _steps,
            currentStep: _currentStep,
            onStepTap: _handleStepTap,
          ),
          
          // 内容区域
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '当前步骤: ${_currentStep + 1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '步骤名称: ${_steps[_currentStep].title}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    '点击步骤可切换当前进度',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}