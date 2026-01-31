import 'package:flutter/material.dart';
import 'form_fields.dart';

class CustomForm extends StatefulWidget {
  final List<CustomFormField> fields;
  final void Function(Map<String, String> values)? onSubmit;

  const CustomForm({Key? key, required this.fields, this.onSubmit})
      : super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    for (final f in widget.fields) {
      _controllers[f.name] = TextEditingController(text: f.initialValue ?? '');
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  bool validate() => _formKey.currentState?.validate() ?? false;

  Map<String, String> values() => _controllers.map((k, v) => MapEntry(k, v.text));

  void submit() {
    if (validate()) {
      final vals = values();
      if (widget.onSubmit != null) widget.onSubmit!(vals);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...widget.fields.map((f) => CustomTextField(
                label: f.label,
                controller: _controllers[f.name]!,
                keyboardType: f.keyboardType,
                obscure: f.obscure,
                validator: f.validator,
              )),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: submit,
            child: const Text('提交'),
          ),
        ],
      ),
    );
  }
}
