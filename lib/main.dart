import 'package:flutter/material.dart';
import 'package:aa/components/combobox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter for openHarmony',
      theme: ThemeData(
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

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ComboboxOption> _options = const [
    ComboboxOption(value: 'option1', label: 'Option 1'),
    ComboboxOption(value: 'option2', label: 'Option 2'),
    ComboboxOption(value: 'option3', label: 'Option 3'),
    ComboboxOption(value: 'option4', label: 'Option 4'),
    ComboboxOption(value: 'option5', label: 'Option 5'),
  ];

  String _selectedValue = 'No option selected';

  void _handleOptionSelected(ComboboxOption option) {
    setState(() {
      _selectedValue = 'Selected: ${option.label} (${option.value})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shadcn UI Combobox Demo'),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Combobox Examples',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 32),
            
            // Basic Combobox
            const Text(
              'Basic Combobox',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            ShadcnCombobox(
              options: _options,
              placeholder: 'Select an option',
              onSelected: _handleOptionSelected,
            ),
            const SizedBox(height: 32),
            
            // Combobox with Label
            const Text(
              'Combobox with Label',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            ShadcnCombobox(
              options: _options,
              label: 'Choose an option',
              placeholder: 'Select an option',
              onSelected: _handleOptionSelected,
            ),
            const SizedBox(height: 32),
            
            // Combobox with Initial Value
            const Text(
              'Combobox with Initial Value',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            ShadcnCombobox(
              options: _options,
              label: 'Choose an option',
              placeholder: 'Select an option',
              initialValue: const ComboboxOption(value: 'option2', label: 'Option 2'),
              onSelected: _handleOptionSelected,
            ),
            const SizedBox(height: 32),
            
            // Selected Value Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFF8FAFC),
              ),
              child: Text(
                _selectedValue,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
