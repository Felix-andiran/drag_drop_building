import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';

class DataListWidget extends StatelessWidget {
  const DataListWidget({super.key, required this.viewData});
  final Map<String, dynamic> viewData;

  @override
  Widget build(BuildContext context) {
    List<Widget> viewWidgets = [];
    List<Widget> actionButtonWidgets = [];

    viewData.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        if (key == "actionButtons") {
          actionButtonWidgets.addAll(value.entries.map((entry) {
            String buttonLabel = entry.value['label'];
            String form = entry.value['form'];
            String key = entry.key;
            return DraggableWidget(
              data: WidgetModel(
                  type: widgetModelType(WidgetType.button),
                  properties: {
                    'key': key,
                    'form': form,
                    'label': buttonLabel,
                    'labelSize': 14.0,
                    'color': "0xFF2196F3",
                    'labelColor': "0xFFE1E1E1",
                    'width': 100.0,
                    'height': 50.0,
                    'borderRadius': 10.0,
                    'dx': 0.0,
                    'dy': 0.0,
                    'paddingDx': 8.0,
                    'paddingDy': 4.0
                  }),
            );
          }).toList());
        } else {
          value.forEach((nestedKey, nestedValue) {
            viewWidgets.add(
              NestedWidget(
                keyString: nestedKey,
                value: nestedValue,
              ),
            );
          });
        }
      } else {
        viewWidgets.add(DraggableWidget(
          data:
              WidgetModel(type: widgetModelType(WidgetType.text), properties: {
            'key': key,
            'label': key,
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
        ));
      }
    });

    viewWidgets.add(DraggableWidget(
      data: WidgetModel(type: widgetModelType(WidgetType.card), properties: {
        "key": "customer",
        "width": 300,
        "height": 160,
        "dx": 0.0,
        "dy": 0.0,
        "paddingDx": 16.0,
        "paddingDy": 16.0,
        "borderRadius": 10,
        "title": "Total Customer",
        "value": "32,502",
        "subtitle": "2.1% less than last month",
        "titleFontSize": 16,
        "valueFontSize": 32,
        "subTitleFontSize": 14,
        "titleColor": "0xFF757575",
        "valueColor": "0xFF000000",
        "subTitleColor": "0xFFFF0000",
        "backgroundColor": "0xFFFFFFFF"
      }),
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...viewWidgets,
                ],
              ),
            ),
          ),
        ),
        ...actionButtonWidgets,
      ],
    );
  }
}
