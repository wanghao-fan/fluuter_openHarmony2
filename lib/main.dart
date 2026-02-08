import 'package:flutter/material.dart';
import 'components/fingerprint_unlock_component.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
              'Flutter for OpenHarmony 实战：指纹解锁动画',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            // 指纹解锁组件
            FingerprintUnlockComponent(
              title: '指纹解锁',
              subtitle: '点击指纹区域解锁',
              fingerprintColor: Colors.blue,
              scanColor: Colors.green,
              size: 200.0,
              animationDuration: 2000,
              onUnlock: () {
                print('指纹解锁成功');
                // 这里可以添加解锁后的逻辑
              },
              onFailed: () {
                print('指纹解锁失败');
                // 这里可以添加解锁失败的逻辑
              },
            ),
            
            const SizedBox(height: 40),
            
            // 不同样式的指纹解锁组件示例
            const Text(
              '不同样式的指纹解锁效果',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FingerprintUnlockComponent(
                  title: '绿色主题',
                  subtitle: '点击解锁',
                  fingerprintColor: Colors.green,
                  scanColor: Colors.blue,
                  size: 150.0,
                  animationDuration: 1500,
                ),
                FingerprintUnlockComponent(
                  title: '紫色主题',
                  subtitle: '点击解锁',
                  fingerprintColor: Colors.purple,
                  scanColor: Colors.orange,
                  size: 150.0,
                  animationDuration: 1500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
