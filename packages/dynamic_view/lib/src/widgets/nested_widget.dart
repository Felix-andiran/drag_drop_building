import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';

class NestedWidget extends StatelessWidget {
  const NestedWidget({super.key, required this.keyString, required this.value});
  final String keyString;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return DraggableWidget(
      data: WidgetModel(type: widgetModelType(WidgetType.text), properties: {
        'key': keyString,
        'label': keyString,
        'value': value,
        'width': 100.0,
        'height': 30.0,
        'labelSize': 14.0,
        'valueSize': 12.0,
        'labelColor': "0xFF2196F3",
        'valueColor': "0xFF000000",
        'dx': 0.0,
        'dy': 0.0,
        'paddingDx': 8.0,
        'paddingDy': 4.0
      }),
    );
  }
}
