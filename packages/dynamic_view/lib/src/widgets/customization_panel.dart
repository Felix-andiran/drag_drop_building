import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class CustomizationPanel extends StatefulWidget {
  final WidgetModel? widget;
  final Function(Map<String, dynamic>) onPropertiesChanged;

  const CustomizationPanel({super.key, required this.widget, required this.onPropertiesChanged});

  @override
  _CustomizationPanelState createState() => _CustomizationPanelState();
} 

class _CustomizationPanelState extends State<CustomizationPanel> {
  late TextEditingController _textController;
  late TextEditingController _fontSizeController;
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
    _textController =
        TextEditingController(text: widget.widget?.properties['text']);
    _fontSizeController = TextEditingController(
        text: widget.widget?.properties['fontSize']?.toString());
    _widthController = TextEditingController(
        text: widget.widget?.properties['width']?.toString());
    _heightController = TextEditingController(
        text: widget.widget?.properties['height']?.toString());
    _borderRadiusController = TextEditingController(
        text: widget.widget?.properties['borderRadius']?.toString());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.widget == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Customization Panel'),
        ),
        body: const Center(child: Text('Select a widget to customize')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Customize ${widget.widget!.type.toString().split('.').last}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.widget!.type == WidgetType.text) ...[
              TextField(
                controller: _textController,
                onChanged: (value) {
                  final properties =
                      Map<String, dynamic>.from(widget.widget!.properties);
                  properties['text'] = value;
                  widget.onPropertiesChanged(properties);
                },
                decoration: const InputDecoration(labelText: 'Text'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _fontSizeController,
                onChanged: (value) {
                  final properties =
                      Map<String, dynamic>.from(widget.widget!.properties);
                  properties['fontSize'] = double.tryParse(value) ?? 16.0;
                  widget.onPropertiesChanged(properties);
                },
                decoration: const InputDecoration(labelText: 'Font Size'),
                keyboardType: TextInputType.number,
              ),
            ],
            if (widget.widget!.type == WidgetType.button) ...[
              TextField(
                controller: _textController,
                onChanged: (value) {
                  final properties =
                      Map<String, dynamic>.from(widget.widget!.properties);
                  properties['text'] = value;
                  widget.onPropertiesChanged(properties);
                },
                decoration: const InputDecoration(labelText: 'Button Text'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _widthController,
                onChanged: (value) {
                  final properties =
                      Map<String, dynamic>.from(widget.widget!.properties);
                  properties['width'] = double.tryParse(value) ?? 100.0;
                  widget.onPropertiesChanged(properties);
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
                  widget.onPropertiesChanged(properties);
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
                  properties['borderRadius'] = double.tryParse(value) ?? 0.0;
                  widget.onPropertiesChanged(properties);
                },
                decoration: const InputDecoration(labelText: 'Border Radius'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              const Text('Button Color'),
              const SizedBox(height: 10),
              ColorPicker(
                pickerColor: widget.widget!.properties['color'] ?? Colors.blue,
                onColorChanged: (color) {
                  final properties =
                      Map<String, dynamic>.from(widget.widget!.properties);
                  properties['color'] = color;
                  widget.onPropertiesChanged(properties);
                },
                showLabel: false,
                pickerAreaHeightPercent: 0.8,
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final properties =
                    Map<String, dynamic>.from(widget.widget!.properties);
                properties['newProperty'] = 'newValue';
                widget.onPropertiesChanged(properties);
              },
              child: const Text('Add New Property'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _fontSizeController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _borderRadiusController.dispose();
    super.dispose();
  }
}
