import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:aa/components/relationship_chart.dart';

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
  late RelationshipChartData _relationshipData;

  @override
  void initState() {
    super.initState();
    _initRelationshipData();
  }

  // 初始化关系图数据
  void _initRelationshipData() {
    // 定义分类
    final categories = [
      RelationshipCategory(name: '人物'),
      RelationshipCategory(name: '公司'),
      RelationshipCategory(name: '项目'),
    ];

    // 定义节点
    final nodes = [
      RelationshipNode(
        id: '1',
        name: '张三',
        symbolSize: 50,
        category: '人物',
        color: Colors.blue,
      ),
      RelationshipNode(
        id: '2',
        name: '李四',
        symbolSize: 40,
        category: '人物',
        color: Colors.green,
      ),
      RelationshipNode(
        id: '3',
        name: '王五',
        symbolSize: 45,
        category: '人物',
        color: Colors.red,
      ),
      RelationshipNode(
        id: '4',
        name: 'A公司',
        symbolSize: 60,
        category: '公司',
        color: Colors.yellow,
      ),
      RelationshipNode(
        id: '5',
        name: 'B公司',
        symbolSize: 55,
        category: '公司',
        color: Colors.purple,
      ),
      RelationshipNode(
        id: '6',
        name: '项目1',
        symbolSize: 40,
        category: '项目',
        color: Colors.orange,
      ),
      RelationshipNode(
        id: '7',
        name: '项目2',
        symbolSize: 35,
        category: '项目',
        color: Colors.teal,
      ),
    ];

    // 定义边
    final links = [
      RelationshipLink(
        source: '1',
        target: '4',
        value: 50,
        lineStyle: Colors.blue,
      ),
      RelationshipLink(
        source: '1',
        target: '6',
        value: 30,
        lineStyle: Colors.blue,
      ),
      RelationshipLink(
        source: '2',
        target: '4',
        value: 40,
        lineStyle: Colors.green,
      ),
      RelationshipLink(
        source: '2',
        target: '5',
        value: 35,
        lineStyle: Colors.green,
      ),
      RelationshipLink(
        source: '2',
        target: '7',
        value: 25,
        lineStyle: Colors.green,
      ),
      RelationshipLink(
        source: '3',
        target: '5',
        value: 45,
        lineStyle: Colors.red,
      ),
      RelationshipLink(
        source: '3',
        target: '6',
        value: 30,
        lineStyle: Colors.red,
      ),
      RelationshipLink(
        source: '4',
        target: '6',
        value: 55,
        lineStyle: Colors.yellow,
      ),
      RelationshipLink(
        source: '5',
        target: '7',
        value: 50,
        lineStyle: Colors.purple,
      ),
    ];

    _relationshipData = RelationshipChartData(
      nodes: nodes,
      links: links,
      categories: categories,
    );
  }

  // 节点点击回调
  void _onNodeClick(Map<String, dynamic> data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('点击了节点: ${data['name']} (${data['category']})'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // 边点击回调
  void _onLinkClick(Map<String, dynamic> data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('点击了边: ${data['source']} -> ${data['target']} (强度: ${data['value']})'),
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
              '关系图展示',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: kIsWeb
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 64,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            '关系图在Web平台上暂不支持',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '请在Android或iOS平台上运行应用查看关系图',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : RelationshipChartWidget(
                      data: _relationshipData,
                      onNodeClick: _onNodeClick,
                      onLinkClick: _onLinkClick,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
