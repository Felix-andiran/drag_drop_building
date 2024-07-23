import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomColorPicker extends StatelessWidget {
  const CustomColorPicker({
    super.key,
    required this.title,
    required this.pickerColor,
    required this.onColorChanged,
  });

  final String title;
  final int pickerColor;
  final void Function(Color) onColorChanged;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ColorPicker(
            pickerColor: Color(pickerColor),
            onColorChanged: onColorChanged,
            portraitOnly: true,
            showLabel: false,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
      ],
    );
  }
}
