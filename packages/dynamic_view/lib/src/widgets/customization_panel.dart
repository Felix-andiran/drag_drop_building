import 'package:dynamic_view/src/bloc/view_builder_bloc.dart';
import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:logger/logger.dart';

class CustomizationPanel extends StatefulWidget {
  final WidgetModel? widget;

  const CustomizationPanel({super.key, required this.widget});

  @override
  CustomizationPanelState createState() => CustomizationPanelState();
}

class CustomizationPanelState extends State<CustomizationPanel> {
  late TextEditingController _labelController;
  late TextEditingController _labelFontSizeController;
  late TextEditingController _valueController;
  late TextEditingController _valueFontSizeController;
  late TextEditingController _widthController;
  late TextEditingController _heightController;
  late TextEditingController _borderRadiusController;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  @override
  void didUpdateWidget(covariant CustomizationPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.widget != widget.widget) {
      _initControllers();
    }
  }

  void _initControllers() {
    _labelController =
        TextEditingController(text: widget.widget?.properties['label']);
    _labelFontSizeController = TextEditingController(
        text: widget.widget?.properties['labelSize']?.toString());
    _valueController =
        TextEditingController(text: widget.widget?.properties['value']);
    _valueFontSizeController = TextEditingController(
        text: widget.widget?.properties['valueSize']?.toString());
    _widthController = TextEditingController(
        text: widget.widget?.properties['width']?.toString());
    _heightController = TextEditingController(
        text: widget.widget?.properties['height']?.toString());
    _borderRadiusController = TextEditingController(
        text: widget.widget?.properties['borderRadius']?.toString());
  }

  @override
  Widget build(BuildContext context) {
    Logger log = Logger();
    return BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
      builder: (context, state) {
        if (state.selectedWidget == null || state.rightSideWidgets.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Customization Panel'),
            ),
            body: const Center(child: Text('Select a widget to customize')),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Customize ${widget.widget!.type.toString().split('.').last}'),
            // actions: [
            //   InkWell(
            //     onTap: () {
            //       context.read<ViewBuilderBloc>().add(
            //             const SelectWidgetModelEvent(widgetModel: null),
            //           );
            //     },
            //     child: const Icon(
            //       Icons.cancel,
            //       size: 16,
            //       color: Colors.red,
            //     ),
            //   ),
            // ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.widget!.type == WidgetType.text) ...[
                  TextField(
                    controller: _labelController,
                    onChanged: (value) {
                      final properties =
                          Map<String, dynamic>.from(widget.widget!.properties);
                      properties['label'] = value;
                      context.read<ViewBuilderBloc>().add(
                          ChangePropertiesSelectedWidgetEvent(
                              changedProperties: properties));
                    },
                    decoration: const InputDecoration(labelText: 'Label'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _labelFontSizeController,
                    onChanged: (value) {
                      final properties =
                          Map<String, dynamic>.from(widget.widget!.properties);
                      properties['labelSize'] = double.tryParse(value) ?? 14.0;
                      context.read<ViewBuilderBloc>().add(
                          ChangePropertiesSelectedWidgetEvent(
                              changedProperties: properties));
                    },
                    decoration:
                        const InputDecoration(labelText: 'Label Font Size'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _valueController,
                    onChanged: (value) {
                      final properties =
                          Map<String, dynamic>.from(widget.widget!.properties);
                      properties['value'] = value;
                      context.read<ViewBuilderBloc>().add(
                          ChangePropertiesSelectedWidgetEvent(
                              changedProperties: properties));
                    },
                    decoration: const InputDecoration(labelText: 'Value'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _valueFontSizeController,
                    onChanged: (value) {
                      final properties =
                          Map<String, dynamic>.from(widget.widget!.properties);
                      properties['valueSize'] = double.tryParse(value) ?? 12.0;
                      context.read<ViewBuilderBloc>().add(
                          ChangePropertiesSelectedWidgetEvent(
                              changedProperties: properties));
                    },
                    decoration:
                        const InputDecoration(labelText: 'Value Font Size'),
                    keyboardType: TextInputType.number,
                  ),
                ],
                if (widget.widget!.type == WidgetType.button) ...[
                  TextField(
                    controller: _labelController,
                    onChanged: (value) {
                      final properties =
                          Map<String, dynamic>.from(widget.widget!.properties);
                      properties['label'] = value;
                      context.read<ViewBuilderBloc>().add(
                          ChangePropertiesSelectedWidgetEvent(
                              changedProperties: properties));
                    },
                    decoration:
                        const InputDecoration(labelText: 'Button Label'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _widthController,
                    onChanged: (value) {
                      final properties =
                          Map<String, dynamic>.from(widget.widget!.properties);
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
                    controller: _heightController,
                    onChanged: (value) {
                      final properties =
                          Map<String, dynamic>.from(widget.widget!.properties);
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
                    controller: _borderRadiusController,
                    onChanged: (value) {
                      final properties =
                          Map<String, dynamic>.from(widget.widget!.properties);
                      properties['borderRadius'] =
                          double.tryParse(value) ?? 10.0;
                      context.read<ViewBuilderBloc>().add(
                          ChangePropertiesSelectedWidgetEvent(
                              changedProperties: properties));
                    },
                    decoration:
                        const InputDecoration(labelText: 'Border Radius'),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  const Text('Button Color'),
                  const SizedBox(height: 10),
                  ColorPicker(
                    pickerColor: Color(widget.widget!.properties['color']),
                    onColorChanged: (color) {
                      final properties =
                          Map<String, dynamic>.from(widget.widget!.properties);
                      log.d(
                          "Selected color code for the button ::: ${color.toHexString()}");
                      properties['color'] =
                          int.parse("0x${color.toHexString()}");
                      context.read<ViewBuilderBloc>().add(
                          ChangePropertiesSelectedWidgetEvent(
                              changedProperties: properties));
                    },
                    showLabel: false,
                    pickerAreaHeightPercent: 0.8,
                  ),
                ],
                // const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     final properties =
                //         Map<String, dynamic>.from(widget.widget!.properties);
                //     properties['newProperty'] = 'newValue';
                //     context.read<ViewBuilderBloc>().add(
                //         ChangePropertiesSelectedWidgetEvent(
                //             changedProperties: properties));
                //   },
                //   child: const Text('Add New Property'),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _labelController.dispose();
    _labelFontSizeController.dispose();
    _valueController.dispose();
    _valueFontSizeController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _borderRadiusController.dispose();
    super.dispose();
  }
}
