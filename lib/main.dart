import 'package:flutter/material.dart';
import 'components/selection_dialog.dart';

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
  bool _isDialogVisible = true;
  String _selectedOption = '';

  void _hideDialog() {
    setState(() {
      _isDialogVisible = false;
    });
  }

  void _showDialog() {
    setState(() {
      _isDialogVisible = true;
    });
  }

  void _handleSelect(int index) {
    List<String> options = ['选项一', '选项二', '选项三', '选项四'];
    setState(() {
      _selectedOption = options[index];
      print('用户选择了: $_selectedOption');
      _hideDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Flutter for OpenHarmony 选择对话框示例',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                if (_selectedOption.isNotEmpty)
                  Text(
                    '您选择了: $_selectedOption',
                    style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _showDialog,
                  child: const Text('显示选择对话框'),
                ),
              ],
            ),
          ),
          SelectionDialog(
            title: '请选择一个选项',
            options: ['选项一', '选项二', '选项三', '选项四'],
            cancelText: '取消',
            onSelect: _handleSelect,
            onCancel: () {
              print('用户点击了取消');
              _hideDialog();
            },
            isVisible: _isDialogVisible,
          ),
        ],
      ),
    );
  }
}
