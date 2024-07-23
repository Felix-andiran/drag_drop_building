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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const DeviceDropdown(),
                    Container(
                      color: Colors.white54,
                      height: state.height,
                      width: state.width,
                      child: Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: state.rightSideWidgets.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.read<ViewBuilderBloc>().add(
                                    SelectWidgetModelEvent(
                                        widgetModel:
                                            state.rightSideWidgets[index]));
                              },
                              child: ResizableWidget(
                                widget: state.rightSideWidgets[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
