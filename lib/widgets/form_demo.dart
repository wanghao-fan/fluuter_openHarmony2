import 'package:flutter/material.dart';
import 'package:aa/widgets/custom_form.dart';
import 'package:aa/widgets/form_fields.dart';
import 'package:aa/widgets/validators.dart';

class FormDemoPage extends StatelessWidget {
  const FormDemoPage({Key? key}) : super(key: key);

  void _onSubmit(BuildContext context, Map<String, String> values) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('提交成功'),
        content: SingleChildScrollView(
          child: Text(values.entries.map((e) => '${e.key}: ${e.value}').join('\n')),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('关闭')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();

    final fields = [
      CustomFormField(
        name: 'name',
        label: '姓名',
        validator: Validators.required('请输入姓名'),
      ),
      CustomFormField(
        name: 'email',
        label: '邮箱',
        keyboardType: TextInputType.emailAddress,
        validator: Validators.compose([
          Validators.required('请输入邮箱'),
          Validators.email('邮箱格式不正确'),
        ]),
      ),
      CustomFormField(
        name: 'password',
        label: '密码',
        obscure: true,
        validator: Validators.compose([
          Validators.required('请输入密码'),
          Validators.minLength(6, '密码至少6位'),
        ]),
      ),
      CustomFormField(
        name: 'confirm',
        label: '确认密码',
        obscure: true,
        validator: (v) => null, // will validate in onSubmit by comparing values
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('表单演示')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '这是一个定制化表单，包含可复用组件和验证逻辑。',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              CustomForm(
                fields: fields,
                onSubmit: (values) {
                  // 比较密码
                  if (values['password'] != values['confirm']) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('两次输入的密码不一致')),
                    );
                    return;
                  }
                  _onSubmit(context, values);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
