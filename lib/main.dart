import 'package:flutter/material.dart';
import 'package:aa/components/breadcrumb.dart';

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
  List<BreadcrumbItem> _breadcrumbItems = [];
  String _currentPath = 'Home';

  @override
  void initState() {
    super.initState();
    _initializeBreadcrumb();
  }

  void _initializeBreadcrumb() {
    _breadcrumbItems = [
      BreadcrumbItem(
        label: 'Home',
        isActive: true,
        onTap: () => _navigateTo('Home'),
      ),
    ];
  }

  void _navigateTo(String path) {
    setState(() {
      _currentPath = path;
      
      // Update breadcrumb items based on the current path
      if (path == 'Home') {
        _breadcrumbItems = [
          BreadcrumbItem(
            label: 'Home',
            isActive: true,
            onTap: () => _navigateTo('Home'),
          ),
        ];
      } else if (path == 'Products') {
        _breadcrumbItems = [
          BreadcrumbItem(
            label: 'Home',
            isActive: false,
            onTap: () => _navigateTo('Home'),
          ),
          BreadcrumbItem(
            label: 'Products',
            isActive: true,
            onTap: () => _navigateTo('Products'),
          ),
        ];
      } else if (path == 'Electronics') {
        _breadcrumbItems = [
          BreadcrumbItem(
            label: 'Home',
            isActive: false,
            onTap: () => _navigateTo('Home'),
          ),
          BreadcrumbItem(
            label: 'Products',
            isActive: false,
            onTap: () => _navigateTo('Products'),
          ),
          BreadcrumbItem(
            label: 'Electronics',
            isActive: true,
            onTap: () => _navigateTo('Electronics'),
          ),
        ];
      } else if (path == 'Smartphones') {
        _breadcrumbItems = [
          BreadcrumbItem(
            label: 'Home',
            isActive: false,
            onTap: () => _navigateTo('Home'),
          ),
          BreadcrumbItem(
            label: 'Products',
            isActive: false,
            onTap: () => _navigateTo('Products'),
          ),
          BreadcrumbItem(
            label: 'Electronics',
            isActive: false,
            onTap: () => _navigateTo('Electronics'),
          ),
          BreadcrumbItem(
            label: 'Smartphones',
            isActive: true,
            onTap: () => _navigateTo('Smartphones'),
          ),
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shadcn UI Breadcrumb Demo'),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Navigation Breadcrumb',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            
            // Breadcrumb component
            ShadcnBreadcrumb(
              items: _breadcrumbItems,
              separator: '/',
              activeColor: const Color(0xFF3B82F6),
              inactiveColor: const Color(0xFF64748B),
            ),
            
            const SizedBox(height: 48),
            
            // Navigation buttons
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Navigate to:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        ElevatedButton(
                          onPressed: () => _navigateTo('Home'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentPath == 'Home' ? const Color(0xFF3B82F6) : const Color(0xFFF1F5F9),
                            foregroundColor: _currentPath == 'Home' ? Colors.white : const Color(0xFF475569),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Home'),
                        ),
                        ElevatedButton(
                          onPressed: () => _navigateTo('Products'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentPath == 'Products' ? const Color(0xFF3B82F6) : const Color(0xFFF1F5F9),
                            foregroundColor: _currentPath == 'Products' ? Colors.white : const Color(0xFF475569),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Products'),
                        ),
                        ElevatedButton(
                          onPressed: () => _navigateTo('Electronics'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentPath == 'Electronics' ? const Color(0xFF3B82F6) : const Color(0xFFF1F5F9),
                            foregroundColor: _currentPath == 'Electronics' ? Colors.white : const Color(0xFF475569),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Electronics'),
                        ),
                        ElevatedButton(
                          onPressed: () => _navigateTo('Smartphones'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _currentPath == 'Smartphones' ? const Color(0xFF3B82F6) : const Color(0xFFF1F5F9),
                            foregroundColor: _currentPath == 'Smartphones' ? Colors.white : const Color(0xFF475569),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Smartphones'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 48),
            
            // Current path display
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Path',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _currentPath,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
