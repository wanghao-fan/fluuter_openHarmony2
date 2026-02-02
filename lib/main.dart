import 'package:flutter/material.dart';
import 'components/tooltip.dart';

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
  @override
  void initState() {
    super.initState();
    
    // 页面加载时自动显示工具提示
    Future.delayed(const Duration(milliseconds: 500), () {
      // 显示普通工具提示
      CustomTooltip.show(
        context,
        '欢迎使用Flutter for OpenHarmony',
        duration: const Duration(seconds: 2),
      );
      
      // 2秒后显示成功工具提示
      Future.delayed(const Duration(seconds: 2), () {
        CustomTooltip.showSuccess(
          context,
          '初始化成功',
          duration: const Duration(seconds: 2),
        );
        
        // 2秒后显示警告工具提示
        Future.delayed(const Duration(seconds: 2), () {
          CustomTooltip.showWarning(
            context,
            '请注意，这是一个警告信息',
            duration: const Duration(seconds: 2),
          );
          
          // 2秒后显示错误工具提示
          Future.delayed(const Duration(seconds: 2), () {
            CustomTooltip.showError(
              context,
              '操作失败，请重试',
              duration: const Duration(seconds: 2),
            );
          });
        });
      });
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
              'Flutter for OpenHarmony 工具提示示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '页面加载后会自动显示各种类型的工具提示',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
