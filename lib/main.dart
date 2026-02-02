import 'package:flutter/material.dart';
import 'components/snack_bar.dart';

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
  // 显示成功SnackBar
  void _showSuccessSnackBar() {
    CustomSnackBar.showSuccess(context, '操作成功！');
  }

  // 显示错误SnackBar
  void _showErrorSnackBar() {
    CustomSnackBar.showError(context, '操作失败，请重试！');
  }

  // 显示警告SnackBar
  void _showWarningSnackBar() {
    CustomSnackBar.showWarning(context, '警告：请检查输入！');
  }

  // 显示信息SnackBar
  void _showInfoSnackBar() {
    CustomSnackBar.showInfo(context, '这是一条信息提示');
  }

  @override
  void initState() {
    super.initState();
    // 页面加载时自动显示一条信息SnackBar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomSnackBar.showInfo(context, '欢迎使用SnackBar提示组件！');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'SnackBar提示组件演示',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // 成功提示按钮
            ElevatedButton(
              onPressed: _showSuccessSnackBar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('显示成功提示', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),
            // 错误提示按钮
            ElevatedButton(
              onPressed: _showErrorSnackBar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('显示错误提示', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),
            // 警告提示按钮
            ElevatedButton(
              onPressed: _showWarningSnackBar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('显示警告提示', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),
            // 信息提示按钮
            ElevatedButton(
              onPressed: _showInfoSnackBar,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('显示信息提示', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
