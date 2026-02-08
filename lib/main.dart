import 'package:flutter/material.dart';
import 'components/kline_chart_component.dart';
import 'services/data_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter for openHarmony',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter for openHarmony'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DataService _dataService = DataService();
  List<KLineData> _kLineData = [];
  bool _isDataServiceRunning = false;

  @override
  void initState() {
    super.initState();
    _startDataService();
  }

  @override
  void dispose() {
    _dataService.stop();
    super.dispose();
  }

  void _startDataService() {
    _dataService.start();
    _isDataServiceRunning = true;
    
    // 监听数据更新
    _dataService.dataStream.listen((value) {
      setState(() {
        _kLineData.add(value);
        // 保持数据点数量在合理范围内，最多显示30个数据点
        if (_kLineData.length > 30) {
          _kLineData = _kLineData.sublist(_kLineData.length - 30);
        }
      });
    });
  }

  void _stopDataService() {
    _dataService.stop();
    _isDataServiceRunning = false;
  }

  void _resetChartData() {
    setState(() {
      _kLineData.clear();
    });
  }

  void _triggerDataUpdate() {
    _dataService.triggerDataUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Flutter for OpenHarmony 实时数据流模拟与图表更新',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            // K线图组件
            KLineChartComponent(
              data: _kLineData,
              title: '实时K线图',
              risingColor: Colors.red,
              fallingColor: Colors.green,
              backgroundColor: Colors.white,
              showGrid: true,
            ),
            
            const SizedBox(height: 20),
            
            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isDataServiceRunning ? _stopDataService : _startDataService,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isDataServiceRunning ? Colors.red : Colors.green,
                  ),
                  child: Text(_isDataServiceRunning ? '停止数据' : '开始数据'),
                ),
                ElevatedButton(
                  onPressed: _resetChartData,
                  child: const Text('重置图表'),
                ),
                ElevatedButton(
                  onPressed: _triggerDataUpdate,
                  child: const Text('手动更新'),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // 数据状态信息
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '数据状态',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('数据服务状态: ${_isDataServiceRunning ? '运行中' : '已停止'}'),
                  Text('当前数据点: ${_kLineData.length}'),
                  if (_kLineData.isNotEmpty)
                    Text('最新收盘价: ${_kLineData.last.close.toStringAsFixed(1)}'),
                  if (_kLineData.isNotEmpty)
                    Text('最新开盘价: ${_kLineData.last.open.toStringAsFixed(1)}'),
                  if (_kLineData.isNotEmpty)
                    Text('最新最高价: ${_kLineData.last.high.toStringAsFixed(1)}'),
                  if (_kLineData.isNotEmpty)
                    Text('最新最低价: ${_kLineData.last.low.toStringAsFixed(1)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
