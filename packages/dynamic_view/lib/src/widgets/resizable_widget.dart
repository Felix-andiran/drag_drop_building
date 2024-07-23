import 'package:dynamic_view/src/bloc/view_builder_bloc.dart';
import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResizableWidget extends StatefulWidget {
  final WidgetModel widget;

  const ResizableWidget({super.key, required this.widget});

  @override
  ResizableWidgetState createState() => ResizableWidgetState();
}

class ResizableWidgetState extends State<ResizableWidget> {
  // late double _width;
  // late double _height;

  @override
  void initState() {
    super.initState();
    // _width = widget.widget.properties['width'] ?? 100.0;
    // _height = widget.widget.properties['height'] ?? 100.0;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onScaleUpdate: (details) {
      //   setState(() {
      //     _width = (_width * details.scale).clamp(50.0, 300.0);
      //     _height = (_height * details.scale).clamp(50.0, 300.0);
      //     widget.widget.properties['width'] = _width;
      //     widget.widget.properties['height'] = _height;
      //   });
      // },
      child: Center(
          child: widget.widget.type == WidgetType.text
              ? buildWithRemove(
                  context,
                  widget.widget.properties['key'],
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          '${widget.widget.properties['label'].toUpperCase()} : ',
                          style: TextStyle(
                              color:
                                  Color(widget.widget.properties['labelColor']),
                              fontWeight: FontWeight.bold,
                              fontSize: widget.widget.properties['labelSize']),
                        ),
                        Text(
                          widget.widget.properties['value'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color:
                                  Color(widget.widget.properties['valueColor']),
                              fontSize: widget.widget.properties['valueSize'],
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ))
              : buildWithRemove(
                  context,
                  widget.widget.properties['key'],
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Container(
                      height: widget.widget.properties['height'],
                      width: widget.widget.properties['width'],
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                              widget.widget.properties['borderRadius'])),
                          shape: BoxShape.rectangle,
                          color: Color(widget.widget.properties['color'])),
                      child: Center(
                        child: Text(
                          widget.widget.properties['label'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(
                                  widget.widget.properties['labelColor'])),
                        ),
                      ),
                    ),
                  ))),
    );
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
