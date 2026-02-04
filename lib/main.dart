import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:aa/components/scatter_chart.dart';

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
  late List<ScatterChartDataModel> _scatterData;

  @override
  void initState() {
    super.initState();
    _initScatterData();
  }

  void _initScatterData() {
    // Generate sample data for scatter chart
    _scatterData = [
      ScatterChartDataModel(
        title: '数据集1',
        spots: [
          ScatterSpot(1.0, 3.0),
          ScatterSpot(2.0, 5.0),
          ScatterSpot(3.0, 2.0),
          ScatterSpot(4.0, 7.0),
          ScatterSpot(5.0, 4.0),
          ScatterSpot(6.0, 6.0),
          ScatterSpot(7.0, 3.0),
        ],
        color: Colors.blue,
        radius: 6,
      ),
      ScatterChartDataModel(
        title: '数据集2',
        spots: [
          ScatterSpot(1.5, 4.0),
          ScatterSpot(2.5, 6.0),
          ScatterSpot(3.5, 3.0),
          ScatterSpot(4.5, 8.0),
          ScatterSpot(5.5, 5.0),
          ScatterSpot(6.5, 7.0),
          ScatterSpot(7.5, 4.0),
        ],
        color: Colors.green,
        radius: 6,
      ),
      ScatterChartDataModel(
        title: '数据集3',
        spots: [
          ScatterSpot(2.0, 2.0),
          ScatterSpot(3.0, 4.0),
          ScatterSpot(4.0, 1.0),
          ScatterSpot(5.0, 6.0),
          ScatterSpot(6.0, 3.0),
          ScatterSpot(7.0, 5.0),
          ScatterSpot(8.0, 2.0),
        ],
        color: Colors.red,
        radius: 6,
      ),
    ];
  }

  void _onScatterPointClick(ScatterSpot spot, ScatterChartDataModel dataset) {
    // Handle scatter chart point click
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('点击了点: 坐标 (${spot.x}, ${spot.y}) 来自 ${dataset.title}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              '散点图展示',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CustomScatterChart(
                data: _scatterData,
                title: 'Flutter for OpenHarmony 散点图',
                onPointTap: _onScatterPointClick,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
