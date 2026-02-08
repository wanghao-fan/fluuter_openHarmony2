import 'dart:async';
import 'dart:math';

class DataService {
  late StreamController<double> _dataStreamController;
  late Timer _timer;
  final Random _random = Random();
  double _currentValue = 50.0;

  Stream<double> get dataStream => _dataStreamController.stream;

  void start() {
    _dataStreamController = StreamController<double>.broadcast();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 模拟数据波动，大幅增大波动范围
      double change = (_random.nextDouble() - 0.5) * 50;
      _currentValue += change;
      
      // 确保数据在合理范围内
      if (_currentValue < 0) {
        _currentValue = 0;
      } else if (_currentValue > 100) {
        _currentValue = 100;
      }
      
      _dataStreamController.add(_currentValue);
    });
  }

  void stop() {
    _timer.cancel();
    _dataStreamController.close();
  }

  // 模拟手动触发数据更新
  void triggerDataUpdate() {
    double change = (_random.nextDouble() - 0.5) * 60;
    _currentValue += change;
    
    if (_currentValue < 0) {
      _currentValue = 0;
    } else if (_currentValue > 100) {
      _currentValue = 100;
    }
    
    _dataStreamController.add(_currentValue);
  }
}
