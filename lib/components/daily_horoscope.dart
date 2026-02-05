import 'package:flutter/material.dart';

class ZodiacSign {
  final String name;
  final String symbol;
  final Color color;

  ZodiacSign({
    required this.name,
    required this.symbol,
    required this.color,
  });
}

class HoroscopeData {
  final String zodiacSign;
  final String date;
  final String overall;
  final String love;
  final String career;
  final String health;
  final String finance;
  final String luckyNumber;
  final String luckyColor;

  HoroscopeData({
    required this.zodiacSign,
    required this.date,
    required this.overall,
    required this.love,
    required this.career,
    required this.health,
    required this.finance,
    required this.luckyNumber,
    required this.luckyColor,
  });
}

class DailyHoroscope extends StatefulWidget {
  const DailyHoroscope({Key? key}) : super(key: key);

  @override
  State<DailyHoroscope> createState() => _DailyHoroscopeState();
}

class _DailyHoroscopeState extends State<DailyHoroscope> {
  final List<ZodiacSign> _zodiacSigns = [
    ZodiacSign(name: '白羊座', symbol: '♈', color: Colors.red),
    ZodiacSign(name: '金牛座', symbol: '♉', color: Colors.green),
    ZodiacSign(name: '双子座', symbol: '♊', color: Colors.yellow),
    ZodiacSign(name: '巨蟹座', symbol: '♋', color: Colors.blue),
    ZodiacSign(name: '狮子座', symbol: '♌', color: Colors.orange),
    ZodiacSign(name: '处女座', symbol: '♍', color: Colors.purple),
    ZodiacSign(name: '天秤座', symbol: '♎', color: Colors.pink),
    ZodiacSign(name: '天蝎座', symbol: '♏', color: Colors.indigo),
    ZodiacSign(name: '射手座', symbol: '♐', color: Colors.teal),
    ZodiacSign(name: '摩羯座', symbol: '♑', color: Colors.brown),
    ZodiacSign(name: '水瓶座', symbol: '♒', color: Colors.cyan),
    ZodiacSign(name: '双鱼座', symbol: '♓', color: Colors.lightBlue),
  ];

  ZodiacSign? _selectedSign;
  HoroscopeData? _horoscopeData;

  void _selectZodiacSign(ZodiacSign sign) {
    setState(() {
      _selectedSign = sign;
      _horoscopeData = _generateHoroscopeData(sign);
    });
  }

  HoroscopeData _generateHoroscopeData(ZodiacSign sign) {
    // 生成模拟的运势数据
    return HoroscopeData(
      zodiacSign: sign.name,
      date: '${DateTime.now().year}年${DateTime.now().month}月${DateTime.now().day}日',
      overall: '今天整体运势不错，保持积极的心态，会有意外的惊喜。',
      love: '感情方面会有新的进展，单身的朋友可能会遇到心仪的对象。',
      career: '工作上会有新的机会，好好把握，展示自己的能力。',
      health: '身体健康状况良好，建议适当运动，保持良好的作息。',
      finance: '财运亨通，可能会有意外的收入，建议合理规划支出。',
      luckyNumber: (1 + DateTime.now().day % 9).toString(),
      luckyColor: _getLuckyColor(sign),
    );
  }

  String _getLuckyColor(ZodiacSign sign) {
    Map<Color, String> colorNames = {
      Colors.red: '红色',
      Colors.green: '绿色',
      Colors.yellow: '黄色',
      Colors.blue: '蓝色',
      Colors.orange: '橙色',
      Colors.purple: '紫色',
      Colors.pink: '粉色',
      Colors.indigo: '靛蓝色',
      Colors.teal: '青色',
      Colors.brown: '棕色',
      Colors.cyan: '蓝绿色',
      Colors.lightBlue: '浅蓝色',
    };
    return colorNames[sign.color] ?? '彩色';
  }

  Widget _buildZodiacSignItem(ZodiacSign sign) {
    bool isSelected = _selectedSign?.name == sign.name;
    return GestureDetector(
      onTap: () => _selectZodiacSign(sign),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? sign.color.withOpacity(0.2) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? sign.color : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              sign.symbol,
              style: TextStyle(
                fontSize: 20,
                color: sign.color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              sign.name,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? sign.color : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoroscopeCard() {
    if (_horoscopeData == null) {
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
              Icons.star_outline,
              size: 48,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              '请选择一个星座查看今日运势',
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

    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: _selectedSign!.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _selectedSign!.color.withOpacity(0.3),
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
              Text(
                '${_horoscopeData!.zodiacSign} ${_zodiacSigns.firstWhere((sign) => sign.name == _horoscopeData!.zodiacSign).symbol}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _selectedSign!.color,
                ),
              ),
              Text(
                _horoscopeData!.date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 运势详情
          _buildHoroscopeItem('整体运势', _horoscopeData!.overall),
          const SizedBox(height: 16),
          _buildHoroscopeItem('爱情运势', _horoscopeData!.love),
          const SizedBox(height: 16),
          _buildHoroscopeItem('事业运势', _horoscopeData!.career),
          const SizedBox(height: 16),
          _buildHoroscopeItem('健康运势', _horoscopeData!.health),
          const SizedBox(height: 16),
          _buildHoroscopeItem('财运', _horoscopeData!.finance),
          const SizedBox(height: 24),

          // 幸运数字和颜色
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  '幸运数字: ${_horoscopeData!.luckyNumber}',
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectedSign!.color,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      '幸运颜色: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: _selectedSign!.color,
                      ),
                    ),
                    Container(
                      width: 16,
                      height: 16,
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: _selectedSign!.color,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHoroscopeItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: _selectedSign!.color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
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
              '每日运势',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '选择星座查看今日运势',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),

            // 星座选择
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _zodiacSigns.length,
                itemBuilder: (context, index) {
                  return _buildZodiacSignItem(_zodiacSigns[index]);
                },
              ),
            ),

            // 运势卡片
            _buildHoroscopeCard(),
          ],
        ),
      ),
    );
  }
}
