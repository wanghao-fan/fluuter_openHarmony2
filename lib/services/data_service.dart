import 'dart:async';
import 'dart:math';

// K线图数据模型
class KLineData {
  final double open;
  final double close;
  final double high;
  final double low;
  final int timestamp;

  KLineData({
    required this.open,
    required this.close,
    required this.high,
    required this.low,
    required this.timestamp,
  });
}

class DataService {
  late StreamController<KLineData> _dataStreamController;
  late Timer _timer;
  final Random _random = Random();
  double _currentValue = 50.0;

  Stream<KLineData> get dataStream => _dataStreamController.stream;

  void start() {
    _dataStreamController = StreamController<KLineData>.broadcast();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 生成K线数据
      KLineData kLineData = _generateKLineData();
      _dataStreamController.add(kLineData);
    });
  }

  void stop() {
    _timer.cancel();
    _dataStreamController.close();
  }

  // 模拟手动触发数据更新
  void triggerDataUpdate() {
    KLineData kLineData = _generateKLineData();
    _dataStreamController.add(kLineData);
  }

  // 生成K线数据
  KLineData _generateKLineData() {
    // 模拟数据波动，大幅增大波动范围
    double change = (_random.nextDouble() - 0.5) * 50;
    double newClose = _currentValue + change;
    
    // 确保数据在合理范围内
    if (newClose < 0) {
      newClose = 0;
    } else if (newClose > 100) {
      newClose = 100;
    }
    
    // 生成开盘价、最高价、最低价
    double open = _currentValue;
    double high = max(open, newClose) + (_random.nextDouble() * 10);
    double low = min(open, newClose) - (_random.nextDouble() * 10);
    
    // 确保最高价和最低价在合理范围内
    if (high > 100) high = 100;
    if (low < 0) low = 0;
    
    // 更新当前值
    _currentValue = newClose;
    
    return KLineData(
      open: open,
      close: newClose,
      high: high,
      low: low,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
