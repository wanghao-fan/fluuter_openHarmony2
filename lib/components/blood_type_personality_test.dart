import 'package:flutter/material.dart';

class BloodType {
  final String type;
  final String description;
  final String traits;
  final String advantages;
  final String disadvantages;
  final Color color;

  BloodType({
    required this.type,
    required this.description,
    required this.traits,
    required this.advantages,
    required this.disadvantages,
    required this.color,
  });
}

class BloodTypePersonalityTest extends StatefulWidget {
  const BloodTypePersonalityTest({Key? key}) : super(key: key);

  @override
  State<BloodTypePersonalityTest> createState() => _BloodTypePersonalityTestState();
}

class _BloodTypePersonalityTestState extends State<BloodTypePersonalityTest> {
  final List<BloodType> _bloodTypes = [
    BloodType(
      type: 'A型',
      description: 'A型血的人通常注重细节，追求完美，有强烈的责任感和团队精神。',
      traits: '认真、仔细、有耐心、注重礼仪、有责任感、团队意识强',
      advantages: '做事认真负责，注重团队合作，有良好的自我约束力',
      disadvantages: '容易紧张，过于追求完美，有时候会显得固执',
      color: Colors.red,
    ),
    BloodType(
      type: 'B型',
      description: 'B型血的人通常性格开朗，思维灵活，喜欢自由，富有创造力。',
      traits: '开朗、活泼、思维灵活、喜欢自由、富有创造力、好奇心强',
      advantages: '思维敏捷，适应能力强，富有创造力和想象力',
      disadvantages: '缺乏耐心，有时候会显得任性，不够专注',
      color: Colors.blue,
    ),
    BloodType(
      type: 'AB型',
      description: 'AB型血的人通常兼具A型和B型的特点，理性与感性并存，善于分析。',
      traits: '理性、感性并存、善于分析、适应性强、注重平衡、有洞察力',
      advantages: '思维敏捷，分析能力强，善于处理复杂问题',
      disadvantages: '有时候会显得冷漠，缺乏持久性，情绪波动较大',
      color: Colors.purple,
    ),
    BloodType(
      type: 'O型',
      description: 'O型血的人通常自信乐观，充满活力，善于社交，有领导能力。',
      traits: '自信、乐观、充满活力、善于社交、有领导能力、意志坚强',
      advantages: '充满活力，善于社交，有领导能力和决策能力',
      disadvantages: '有时候会显得自我中心，缺乏耐心，过于自信',
      color: Colors.green,
    ),
  ];

  BloodType? _selectedBloodType;
  bool _showResult = false;

  void _selectBloodType(BloodType bloodType) {
    setState(() {
      _selectedBloodType = bloodType;
      _showResult = true;
    });
  }

  Widget _buildBloodTypeItem(BloodType bloodType) {
    bool isSelected = _selectedBloodType?.type == bloodType.type;
    return GestureDetector(
      onTap: () => _selectBloodType(bloodType),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? bloodType.color.withOpacity(0.2) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? bloodType.color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: bloodType.color.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ] : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              bloodType.type,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isSelected ? bloodType.color : Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '点击查看性格分析',
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? bloodType.color : Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    if (!_showResult || _selectedBloodType == null) {
      return Container(
        margin: const EdgeInsets.only(top: 32),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bloodtype,
              size: 64,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              '请选择一个血型查看性格分析',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final bloodType = _selectedBloodType!;
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bloodType.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: bloodType.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  '${bloodType.type} 血型性格分析',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: bloodType.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Icon(
                Icons.bloodtype,
                size: 32,
                color: bloodType.color,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 基本描述
          _buildResultItem('基本描述', bloodType.description),
          const SizedBox(height: 20),

          // 性格特质
          _buildResultItem('性格特质', bloodType.traits),
          const SizedBox(height: 20),

          // 优点
          _buildResultItem('优点', bloodType.advantages),
          const SizedBox(height: 20),

          // 缺点
          _buildResultItem('缺点', bloodType.disadvantages),
          const SizedBox(height: 24),

          // 重新选择按钮
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showResult = false;
                  _selectedBloodType = null;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: bloodType.color,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '重新选择',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _selectedBloodType!.color,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Text(
              '血型性格测试',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '选择你的血型，查看性格分析',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            // 血型选择
            Text(
              '请选择你的血型',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: _bloodTypes.map((bloodType) => _buildBloodTypeItem(bloodType)).toList(),
            ),

            // 结果卡片
            _buildResultCard(),
          ],
        ),
      ),
    );
  }
}
