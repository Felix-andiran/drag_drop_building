import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResizableWidget extends StatefulWidget {
  final WidgetModel widget;

  const ResizableWidget({super.key, required this.widget});

  @override
  ResizableWidgetState createState() => ResizableWidgetState();
}

class ResizableWidgetState extends State<ResizableWidget> {
  @override
  Widget build(BuildContext context) {
    String widgetType = widget.widget.type;

    Widget widgetContent;
    switch (widgetType) {
      case 'text':
        widgetContent = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Text(
                '${widget.widget.properties['label'].toUpperCase()} : ',
                style: TextStyle(
                    color: Color(widget.widget.properties['labelColor']),
                    fontWeight: FontWeight.bold,
                    fontSize: widget.widget.properties['labelSize']),
              ),
              Text(
                widget.widget.properties['value'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(widget.widget.properties['valueColor']),
                    fontSize: widget.widget.properties['valueSize'],
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        );
        break;
      case 'button':
        widgetContent = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Container(
            height: widget.widget.properties['height'],
            width: widget.widget.properties['width'],
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.widget.properties['borderRadius'])),
              shape: BoxShape.rectangle,
              color: Color(widget.widget.properties['color']),
            ),
            child: Center(
              child: Text(
                widget.widget.properties['label'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.widget.properties['labelSize'],
                  color: Color(widget.widget.properties['labelColor']),
                ),
              ),
            ),
          ),
        );
        break;
      case 'card':
        widgetContent = CustomerCard(
            width: widget.widget.properties['width'],
            height: widget.widget.properties['height'],
            title: widget.widget.properties['title'],
            value: widget.widget.properties['value'],
            subtitle: widget.widget.properties['subtitle'],
            titleFontSize: widget.widget.properties['titleFontSize'],
            valueFontSize: widget.widget.properties['valueFontSize'],
            subtitleFontSize: widget.widget.properties['subtitleFontSize'],
            titleColor:
                int.parse('0xFF${widget.widget.properties['titleColor']}'),
            valueColor:
                int.parse('0xFF${widget.widget.properties['valueColor']}'),
            subtitleColor:
                int.parse('0xFF${widget.widget.properties['subtitleColor']}'),
            backgroundColor:
                int.parse('0xFF${widget.widget.properties['backgroundColor']}'),
            iconColor:
                int.parse('0xFF${widget.widget.properties['iconColor']}'));
        break;
      default:
        widgetContent = const SizedBox.shrink();
    }

    return buildWithRemove(
        context, widget.widget.properties['key'], widgetContent);
  }

  Widget buildWithRemove(BuildContext context, String key, Widget widget) {
    return Stack(
      children: [
        widget,
        Positioned(
          right: 0,
          top: 0,
          child: InkWell(
            onTap: () {
              context.read<ViewBuilderBloc>().add(
                    RemoveRightSideWidgetEvent(widget: widget, key: key),
                  );
            },
            child: const Icon(
              Icons.cancel,
              size: 14,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
