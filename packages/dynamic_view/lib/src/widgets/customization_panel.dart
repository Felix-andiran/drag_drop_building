import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:dynamic_view/src/bloc/view_builder_bloc.dart';
import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:dynamic_view/src/widgets/custom_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CustomizationPanel extends StatefulWidget {
  final WidgetModel? widget;

  const CustomizationPanel({super.key, required this.widget});

  @override
  CustomizationPanelState createState() => CustomizationPanelState();
}

class CustomizationPanelState extends State<CustomizationPanel> {
  late TextEditingController _labelController;
  late TextEditingController _labelFontSizeController;
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
        widget.widget?.properties['width']?.toString() ?? '200';
    _heightController.text =
        widget.widget?.properties['height']?.toString() ?? '50';
  }

  @override
  Widget build(BuildContext context) {
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
        _updateControllers();
        final WidgetModel selectedWidget = state.selectedWidget!;
        final Map<String, dynamic> properties =
            Map<String, dynamic>.from(selectedWidget.properties);

        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Customize ${widget.widget!.type.toString().split('.').last}'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.widget!.type ==
                      widgetModelType(WidgetType.text)) ...[
                    TextField(
                      controller: _labelController,
                      onChanged: (value) {
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
                        properties['labelSize'] =
                            double.tryParse(value) ?? 14.0;
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                      decoration:
                          const InputDecoration(labelText: 'Label Font Size'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    CustomColorPicker(
                      title: 'Select Label Color',
                      pickerColor: widget.widget!.properties['labelColor'],
                      onColorChanged: (Color color) {
                        properties['labelColor'] =
                            int.parse("0x${color.toHexString()}");
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _valueFontSizeController,
                      onChanged: (value) {
                        properties['valueSize'] =
                            double.tryParse(value) ?? 12.0;
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                      decoration:
                          const InputDecoration(labelText: 'Value Font Size'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    CustomColorPicker(
                      title: 'Select Value Color',
                      pickerColor: widget.widget!.properties['valueColor'],
                      onColorChanged: (Color color) {
                        properties['valueColor'] =
                            int.parse("0x${color.toHexString()}");
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                    ),
                  ],
                  if (widget.widget!.type ==
                      widgetModelType(WidgetType.button)) ...[
                    TextField(
                      controller: _labelController,
                      onChanged: (value) {
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
                      controller: _labelFontSizeController,
                      onChanged: (value) {
                        properties['labelSize'] =
                            double.tryParse(value) ?? 14.0;
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                      decoration:
                          const InputDecoration(labelText: 'Label Font Size'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    CustomColorPicker(
                      title: 'Select Label Color',
                      pickerColor: widget.widget!.properties['labelColor'],
                      onColorChanged: (Color color) {
                        properties['labelColor'] =
                            int.parse("0x${color.toHexString()}");
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
                      controller: _borderRadiusController,
                      onChanged: (value) {
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
                    CustomColorPicker(
                      title: 'Select Button Color',
                      pickerColor: widget.widget!.properties['color'],
                      onColorChanged: (Color color) {
                        properties['color'] =
                            int.parse("0x${color.toHexString()}");
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                    ),
                  ],
                  if (widget.widget!.type ==
                      widgetModelType(WidgetType.card)) ...[
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
                        properties['titleFontSize'] =
                            double.tryParse(value) ?? 14.0;
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                      decoration:
                          const InputDecoration(labelText: 'Title Font Size'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _valueFontSizeController,
                      onChanged: (value) {
                        properties['valueFontSize'] =
                            double.tryParse(value) ?? 12.0;
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                      decoration:
                          const InputDecoration(labelText: 'Value Font Size'),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    CustomColorPicker(
                      title: 'Select Title Color',
                      pickerColor: int.parse(
                          '0xFF${widget.widget!.properties['titleColor']}'),
                      onColorChanged: (Color color) {
                        properties['titleColor'] =
                            int.parse("0x${color.toHexString()}");
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomColorPicker(
                      title: 'Select Value Color',
                      pickerColor: int.parse(
                          '0xFF${widget.widget!.properties['valueColor']}'),
                      onColorChanged: (Color color) {
                        properties['valueColor'] =
                            int.parse("0x${color.toHexString()}");
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomColorPicker(
                      title: 'Select Subtitle Color',
                      pickerColor: int.parse(
                          '0xFF${widget.widget!.properties['subtitleColor']}'),
                      onColorChanged: (Color color) {
                        properties['subtitleColor'] =
                            int.parse("0x${color.toHexString()}");
                        context.read<ViewBuilderBloc>().add(
                            ChangePropertiesSelectedWidgetEvent(
                                changedProperties: properties));
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomColorPicker(
                      title: 'Select Background Color',
                      pickerColor: int.parse(
                          "0xFF${widget.widget!.properties['backgroundColor']}"),
                      onColorChanged: (Color color) {
                        properties['backgroundColor'] =
                            int.parse("0x${color.toHexString()}");
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
                      controller: _borderRadiusController,
                      onChanged: (value) {
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
                  ],
                ],
              ),
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
    _valueFontSizeController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _borderRadiusController.dispose();
    super.dispose();
  }
}
