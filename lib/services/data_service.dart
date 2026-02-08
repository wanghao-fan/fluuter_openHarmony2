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
  StreamController<KLineData>? _dataStreamController;
  Timer? _timer;
  final Random _random = Random();
  double _currentValue = 50.0;

  Stream<KLineData> get dataStream {
    if (_dataStreamController == null) {
      _dataStreamController = StreamController<KLineData>.broadcast();
    }
    return _dataStreamController!.stream;
  }

  void start() {
    // 确保控制器正确初始化
    if (_dataStreamController == null) {
      _dataStreamController = StreamController<KLineData>.broadcast();
    }
    
    // 立即生成初始数据，确保应用启动时就有数据显示
    KLineData initialData = _generateKLineData();
    _dataStreamController?.add(initialData);
    
    // 确保定时器正确初始化
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      try {
        // 生成K线数据
        KLineData kLineData = _generateKLineData();
        _dataStreamController?.add(kLineData);
      } catch (e) {
        print('Error generating data: $e');
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _dataStreamController?.close();
    _dataStreamController = null;
  }

  // 模拟手动触发数据更新
  void triggerDataUpdate() {
    try {
      KLineData kLineData = _generateKLineData();
      _dataStreamController?.add(kLineData);
    } catch (e) {
      print('Error triggering data update: $e');
    }
  }

  // 生成K线数据
  KLineData _generateKLineData() {
    try {
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
    } catch (e) {
      print('Error generating K-line data: $e');
      // 返回默认数据作为兜底
      return KLineData(
        open: 50.0,
        close: 50.0,
        high: 55.0,
        low: 45.0,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
    }
  }
}
