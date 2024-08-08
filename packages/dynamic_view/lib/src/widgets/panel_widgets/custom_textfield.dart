import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool readOnly;
  final double width;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.readOnly = false,
    this.width = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 10),
        ),
        style: const TextStyle(fontSize: 10),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.left,
        minLines: 1,
        maxLines: 1,
        maxLengthEnforcement: MaxLengthEnforcement.none,
      ),
    );
  }
}
