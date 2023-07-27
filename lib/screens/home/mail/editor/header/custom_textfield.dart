import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String prefixText;
  final String labelText;
  final String? errorText;
  final bool enabled;
  final void Function(String) onChanged;

  const CustomTextField({
    Key? key,
    this.controller,
    this.prefixText = '',
    this.labelText = '',
    this.errorText,
    this.enabled = true,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ?? TextEditingController(),
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        errorText: errorText,
        prefixText: prefixText,
        labelText: labelText,
        floatingLabelStyle: const TextStyle(color: Colors.transparent),
      ),
      style:
          const TextStyle(color: Color.fromARGB(255, 84, 84, 84), fontSize: 16),
      enabled: enabled,
    );
  }
}
