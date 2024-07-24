import 'package:dynamic_view/src/bloc/view_builder_bloc.dart';
import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:dynamic_view/src/widgets/device_dropdown.dart';
import 'package:dynamic_view/src/widgets/resizable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropTarget extends StatefulWidget {
  const DropTarget({
    super.key,
  });

  @override
  DropTargetState createState() => DropTargetState();
}

class DropTargetState extends State<DropTarget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
      builder: (context, state) {
        return DragTarget<WidgetModel>(
          onAccept: (data) {
            context
                .read<ViewBuilderBloc>()
                .add(RightSidePositionedWidgetEvent(widget: data));
          },
          builder: (BuildContext context, List<dynamic> accepted,
              List<dynamic> rejected) {
            return Container(
              height: double.infinity,
              color: Colors.grey.shade200,
              child: Column(
                children: [
                  const DeviceDropdown(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GridPaper(
                        divisions: 1,
                        color: Colors.transparent,
                        child: Container(
                          color: Colors.white54,
                          height: state.height,
                          width: state.width,
                          child: Stack(
                            children: state.rightSideWidgets.map((widgetModel) {
                              final double dx =
                                  widgetModel.properties['dx'] ?? 0.0;
                              final double dy =
                                  widgetModel.properties['dy'] ?? 0.0;
                              return Positioned(
                                left: dx,
                                top: dy,
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    setState(() {
                                      widgetModel.properties['dx'] =
                                          dx + details.delta.dx;
                                      widgetModel.properties['dy'] =
                                          dy + details.delta.dy;
                                    });
                                  },
                                  onPanEnd: (details) {
                                    context.read<ViewBuilderBloc>().add(
                                          SelectWidgetModelEvent(
                                              widgetModel: widgetModel),
                                        );
                                  },
                                  onTap: () {
                                    context.read<ViewBuilderBloc>().add(
                                          SelectWidgetModelEvent(
                                              widgetModel: widgetModel),
                                        );
                                  },
                                  child: ResizableWidget(widget: widgetModel),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
