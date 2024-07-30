import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DraggableWidget extends StatelessWidget {
  final WidgetModel data;

  const DraggableWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Draggable<WidgetModel>(
      data: data,
      feedback: _buildFeedback(),
      childWhenDragging: Opacity(
        opacity: 0.2,
        child: _buildChild(),
      ),
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    switch (data.type) {
      case 'text':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Text(
                '${data.properties['label'].toUpperCase()} : ',
                style: TextStyle(
                    color: Color(data.properties['labelColor']),
                    fontWeight: FontWeight.bold,
                    fontSize: data.properties['labelSize']),
              ),
              Text(
                data.properties['value'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(data.properties['valueColor']),
                    fontSize: data.properties['valueSize'],
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        );
      case 'button':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color(data.properties['color']))),
            onPressed: () {
              if (kDebugMode) {
                print(data.properties['form']);
              }
            },
            child: Text(
              data.properties['label'],
              style: TextStyle(
                  color: Color(data.properties['labelColor']),
                  fontSize: data.properties['labelSize']),
            ),
          ),
        );
      case 'card':
        return const CustomerCard(
            width: 300,
            height: 150,
            title: 'Total Customer',
            value: '32,502',
            subtitle: '2.1% less than last month',
            titleFontSize: 16,
            valueFontSize: 32,
            subtitleFontSize: 14,
            titleColor: 0xFF757575,
            valueColor: 0xFF000000,
            subtitleColor: 0xFFFF0000,
            backgroundColor: 0xFFFFFFFF,
            iconColor: 0xFF808080);
      default:
        return Container();
    }
  }

  Widget _buildFeedback() {
    switch (data.type) {
      case 'text':
        return Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data.properties['label'].toString().toUpperCase(),
              style: TextStyle(
                  fontSize: data.properties['labelSize'],
                  color: Color(data.properties['labelColor'])),
            ),
          ),
        );
      case 'button':
        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(data.properties['borderRadius'])),
                color: Color(data.properties['color'])),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data.properties['label'],
              style: TextStyle(
                  color: Color(data.properties['labelColor']),
                  fontSize: data.properties['labelSize']),
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
