import 'package:dynamic_view/src/model/widget_model.dart';
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
      case WidgetType.text:
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
      case WidgetType.button:
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
      default:
        return Container();
    }
  }

  Widget _buildFeedback() {
    switch (data.type) {
      case WidgetType.text:
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
      case WidgetType.button:
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
