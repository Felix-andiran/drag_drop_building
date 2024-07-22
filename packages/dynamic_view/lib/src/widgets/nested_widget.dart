import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:dynamic_view/src/widgets/draggable_widget.dart';
import 'package:flutter/material.dart';

class NestedWidget extends StatelessWidget {
  const NestedWidget({super.key, required this.keyString, required this.value});
  final String keyString;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return DraggableWidget(
      data: WidgetModel(type: WidgetType.text, properties: {
        'key': keyString,
        'label': keyString,
        'value': value,
        'labelSize': 14.0,
        'valueSize': 12.0,
        'labelColor': 0xFF2196F3,
        'valueColor': 0xFF000000,
      }),
    );
  }
}
