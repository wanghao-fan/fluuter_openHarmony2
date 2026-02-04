import 'package:flutter/material.dart';
import 'package:aa/components/line_chart.dart';

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
  late List<LineChartDataModel> _lineData;

  @override
  void initState() {
    super.initState();
    _initLineData();
  }

  void _initLineData() {
    // Generate sample dates for the last 7 days
    final dates = List<DateTime>.generate(
      7,
      (i) => DateTime.now().subtract(Duration(days: 6 - i)),
    );

    // Create sample data sets
    _lineData = [
      LineChartDataModel(
        dates: dates,
        values: [12, 19, 13, 15, 20, 25, 22],
        label: '数据集1',
        color: Colors.blue,
      ),
      LineChartDataModel(
        dates: dates,
        values: [10, 15, 18, 12, 16, 19, 21],
        label: '数据集2',
        color: Colors.green,
      ),
      LineChartDataModel(
        dates: dates,
        values: [5, 8, 12, 10, 14, 17, 15],
        label: '数据集3',
        color: Colors.red,
      ),
    ];
  }

  void _onLinePointClick(int index, double value, DateTime date) {
    // Handle line chart point click
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('点击了点 $index: 值 $value, 日期 ${date.month}/${date.day}'),
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
              '折线图展示',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: CustomLineChart(
                data: _lineData,
                title: '多数据集折线图',
                onPointClick: _onLinePointClick,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
