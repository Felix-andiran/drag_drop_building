import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CardWithTitleDescriptionCustomization extends StatefulWidget {
  final WidgetModel? widget;

  const CardWithTitleDescriptionCustomization({
    required this.widget,
    super.key,
  });

  @override
  State<CardWithTitleDescriptionCustomization> createState() =>
      _CardWithTitleDescriptionCustomizationState();
}

class _CardWithTitleDescriptionCustomizationState
    extends State<CardWithTitleDescriptionCustomization> {
  late TextEditingController _labelController;
  late TextEditingController _labelFontSizeController;
  late TextEditingController _valueFontSizeController;
  late TextEditingController _subTitleFontSizeController;
  late TextEditingController _widthController;
  late TextEditingController _heightController;
  late TextEditingController _paddingDxController;
  late TextEditingController _paddingDyController;
  late TextEditingController _borderRadiusController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void didUpdateWidget(
      covariant CardWithTitleDescriptionCustomization oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.widget != widget.widget) {
      _initControllers();
      _updateControllers();
    }
  }

  void _initControllers() {
    _labelController =
        TextEditingController(text: widget.widget?.properties['title'] ?? '');
    _labelFontSizeController = TextEditingController(
        text: widget.widget?.properties['titleFontSize']?.toString() ?? '16');
    _valueFontSizeController = TextEditingController(
        text: widget.widget?.properties['valueFontSize']?.toString() ?? '32');
    _subTitleFontSizeController = TextEditingController(
        text:
            widget.widget?.properties['subTitleFontSize']?.toString() ?? '14');
    _widthController = TextEditingController(
        text: widget.widget?.properties['width']?.toString() ?? '200');
    _heightController = TextEditingController(
        text: widget.widget?.properties['height']?.toString() ?? '50');
    _paddingDxController = TextEditingController(
        text: widget.widget?.properties['paddingDx']?.toString() ?? '8');
    _paddingDyController = TextEditingController(
        text: widget.widget?.properties['paddingDy']?.toString() ?? '4');
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
    _subTitleFontSizeController.dispose();
    _heightController.dispose();
    _widthController.dispose();
    _paddingDxController.dispose();
    _paddingDyController.dispose();
    _borderRadiusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
      builder: (context, state) {
        _updateControllers();
        final WidgetModel selectedWidget = state.selectedWidgetModel!;
        final Map<String, dynamic> properties =
            Map<String, dynamic>.from(selectedWidget.properties);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _labelController,
              onChanged: (value) {
                properties['title'] = value;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _labelFontSizeController,
              onChanged: (value) {
                properties['titleFontSize'] = double.tryParse(value) ?? 16.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Title Font Size'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomColorPicker(
              title: 'Select Title Color',
              pickerColor: int.parse(properties['titleColor']),
              onColorChanged: (Color color) {
                properties['titleColor'] = "0x${color.toHexString()}";
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _valueFontSizeController,
              onChanged: (value) {
                properties['valueFontSize'] = double.tryParse(value) ?? 32.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Value Font Size'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomColorPicker(
              title: 'Select Value Color',
              pickerColor: int.parse(properties['valueColor']),
              onColorChanged: (Color color) {
                properties['valueColor'] = "0x${color.toHexString()}";
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _subTitleFontSizeController,
              onChanged: (value) {
                properties['subTitleFontSize'] = double.tryParse(value) ?? 16.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration:
                  const InputDecoration(labelText: 'Sub Title Font Size'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomColorPicker(
              title: 'Select Sub Title Color',
              pickerColor: int.parse(properties['subTitleColor']),
              onColorChanged: (Color color) {
                properties['subTitleColor'] = "0x${color.toHexString()}";
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
            ),
            const SizedBox(height: 10),
            TextField(
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
              controller: _widthController,
              onChanged: (value) {
                properties['width'] = double.tryParse(value) ?? 200.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Width'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _paddingDxController,
              onChanged: (value) {
                properties['paddingDx'] = double.tryParse(value) ?? 12.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration:
                  const InputDecoration(labelText: 'Horizontal Padding'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _paddingDyController,
              onChanged: (value) {
                properties['paddingDy'] = double.tryParse(value) ?? 12.0;
                context.read<ViewBuilderBloc>().add(
                    ChangePropertiesSelectedWidgetEvent(
                        changedProperties: properties));
              },
              decoration: const InputDecoration(labelText: 'Vertical Padding'),
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
              title: 'Select Background Color',
              pickerColor: int.parse(properties['backgroundColor']),
              onColorChanged: (Color color) {
                properties['backgroundColor'] = "0x${color.toHexString()}";
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
