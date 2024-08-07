import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ButtonCustomization extends StatefulWidget {
  final WidgetModel? widget;
  const ButtonCustomization({
    super.key,
    required this.widget,
  });

  @override
  State<ButtonCustomization> createState() => _ButtonCustomizationState();
}

class _ButtonCustomizationState extends State<ButtonCustomization> {
  late TextEditingController _labelController;
  late TextEditingController _labelFontSizeController;
  late TextEditingController _valueFontSizeController;
  late TextEditingController _heightController;
  late TextEditingController _widthController;
  late TextEditingController _borderRadiusController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void didUpdateWidget(covariant ButtonCustomization oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.widget != widget.widget) {
      _initControllers();
      _updateControllers();
    }
  }

  void _initControllers() {
    _labelController =
        TextEditingController(text: widget.widget?.properties['label'] ?? '');
    _labelFontSizeController = TextEditingController(
        text: widget.widget?.properties['labelSize']?.toString() ?? '14');
    _valueFontSizeController = TextEditingController(
        text: widget.widget?.properties['valueSize']?.toString() ?? '12');
    _widthController = TextEditingController(
        text: widget.widget?.properties['width']?.toString() ?? '200');
    _heightController = TextEditingController(
        text: widget.widget?.properties['height']?.toString() ?? '50');
    _borderRadiusController = TextEditingController(
        text: widget.widget?.properties['borderRadius']?.toString() ?? '10');
  }

  void _updateControllers() {
    _widthController.text =
        widget.widget?.properties['width']?.toString() ?? '100';
    _heightController.text =
        widget.widget?.properties['height']?.toString() ?? '50';
  }

  @override
  void dispose() {
    _labelController.dispose();
    _labelFontSizeController.dispose();
    _valueFontSizeController.dispose();
    _heightController.dispose();
    _widthController.dispose();
    _borderRadiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
      builder: (context, state) {
        _updateControllers();
        final WidgetModel selectedWidget = state.selectedWidget!;
        final Map<String, dynamic> properties =
            Map<String, dynamic>.from(selectedWidget.properties);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _labelController,
              onChanged: (value) {
                properties['label'] = value;
                properties['width'] = (value.length * 8) + 30;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Button Label'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _labelFontSizeController,
              onChanged: (value) {
                properties['labelSize'] = double.tryParse(value) ?? 14.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Label Font Size'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomColorPicker(
              title: 'Select Label Color',
              pickerColor: int.parse(properties['labelColor']),
              onColorChanged: (Color color) {
                properties['labelColor'] = "0x${color.toHexString()}";
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
            ),
            const SizedBox(height: 10),
            TextField(
              readOnly: true,
              controller: _heightController,
              onChanged: (value) {
                properties['height'] = double.tryParse(value) ?? 50.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Height'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              readOnly: true,
              controller: _widthController,
              onChanged: (value) {
                properties['width'] = double.tryParse(value) ?? 50.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Height'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _borderRadiusController,
              onChanged: (value) {
                properties['borderRadius'] = double.tryParse(value) ?? 10.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Border Radius'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomColorPicker(
              title: 'Select Button Color',
              pickerColor: int.parse(properties['color']),
              onColorChanged: (Color color) {
                properties['color'] = "0x${color.toHexString()}";
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
            ),
          ],
        );
      },
    );
  }
}
