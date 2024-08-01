import 'package:dynamic_view/src/bloc/view_builder_bloc.dart';
import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:dynamic_view/src/widgets/device_dropdown.dart';
import 'package:dynamic_view/src/widgets/resizable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class DropTarget extends StatefulWidget {
  const DropTarget({super.key});

  @override
  DropTargetState createState() => DropTargetState();
}

class DropTargetState extends State<DropTarget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
      builder: (context, state) {
        return Container(
          height: double.infinity,
          color: Colors.grey.shade200,
          child: Column(
            children: [
              const DeviceDropdown(),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: GridPaper(
                      divisions: 1,
                      color: Colors.transparent,
                      child: Container(
                        color: Colors.white54,
                        height: state.height,
                        width: state.width,
                        child: Scaffold(
                          appBar: AppBar(
                            backgroundColor: Colors.blueAccent,
                          ),
                          bottomNavigationBar: BottomNavigationBar(
                            items: const <BottomNavigationBarItem>[
                              BottomNavigationBarItem(
                                icon: Icon(Icons.home),
                                label: 'Home',
                                backgroundColor: Colors.black,
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.business),
                                label: 'Business',
                                backgroundColor: Colors.green,
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.school),
                                label: 'School',
                                backgroundColor: Colors.purple,
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.settings),
                                label: 'Settings',
                                backgroundColor: Colors.pink,
                              ),
                            ],
                            currentIndex: 0,
                            selectedItemColor: Colors.yellow[800],
                            onTap: (value) {},
                          ),
                          body: DragTarget<WidgetModel>(
                            onAcceptWithDetails: (details) {
                              details.data.properties['dx'] =
                                  (state.width / 2) - 50;
                              details.data.properties['dy'] =
                                  state.height / 2 - 100;
                              context.read<ViewBuilderBloc>().add(
                                    RightSidePositionedWidgetEvent(
                                        widget: details.data),
                                  );
                            },
                            builder: (BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected) {
                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  final double bodyHeight =
                                      constraints.maxHeight;
                                  final double bodyWidth = constraints.maxWidth;
                                  return Expanded(
                                    child: ScrollConfiguration(
                                      behavior: ScrollConfiguration.of(context)
                                          .copyWith(scrollbars: false),
                                      child: SingleChildScrollView(
                                        child: SizedBox(
                                          height: state.height,
                                          width: state.width,
                                          child: Stack(
                                            children: state.rightSideWidgets
                                                .map((widgetModel) {
                                              final double dx = widgetModel
                                                      .properties['dx'] ??
                                                  0.0;
                                              final double dy = widgetModel
                                                      .properties['dy'] ??
                                                  0.0;
                                              final double height = widgetModel
                                                      .properties['height'] ??
                                                  50.0;
                                              final double width = widgetModel
                                                      .properties['width'] ??
                                                  100.0;
                                              Rect rect = Rect.fromLTWH(
                                                  dx, dy, width, height);

                                              return TransformableBox(
                                                rect: rect,
                                                clampingRect: Offset.zero &
                                                    Size(bodyWidth, bodyHeight),
                                                onChanged: (result, event) {
                                                  rect = result.rect;
                                                  widgetModel.properties['dx'] =
                                                      result.rect.left;
                                                  widgetModel.properties['dy'] =
                                                      result.rect.top;
                                                  widgetModel.properties[
                                                          'height'] =
                                                      result.rect.height
                                                          .round();
                                                  widgetModel
                                                          .properties['width'] =
                                                      result.rect.width.round();
                                                  context
                                                      .read<ViewBuilderBloc>()
                                                      .add(
                                                        SelectWidgetModelEvent(
                                                            widgetModel:
                                                                widgetModel),
                                                      );
                                                },
                                                contentBuilder:
                                                    (context, rect, flip) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              ViewBuilderBloc>()
                                                          .add(
                                                            SelectWidgetModelEvent(
                                                                widgetModel:
                                                                    widgetModel),
                                                          );
                                                    },
                                                    child: ResizableWidget(
                                                        widget: widgetModel),
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
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
  }
}
