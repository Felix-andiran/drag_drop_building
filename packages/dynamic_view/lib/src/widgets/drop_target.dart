import 'package:dynamic_view/src/bloc/view_builder_bloc.dart';
import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:dynamic_view/src/widgets/device_dropdown.dart';
import 'package:dynamic_view/src/widgets/resizable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

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
                              final RenderBox dragTargetBox =
                                  context.findRenderObject() as RenderBox;

                              final Offset dropOffset = details.offset;

                              final Offset localOffset =
                                  dragTargetBox.globalToLocal(dropOffset);

                              details.data.properties['dx'] = localOffset.dx;
                              details.data.properties['dy'] = localOffset.dy;
                              Logger().d(
                                  'Droping widget initial DX and DY ::: Dx - ${localOffset.dx} Dy - ${localOffset.dy}');

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

                                  Logger().d(
                                      'The Constraints Height and Width ::: Height - $bodyHeight Width - $bodyWidth');

                                  return Stack(
                                    children: state.rightSideWidgets
                                        .map((widgetModel) {
                                      final double dx =
                                          widgetModel.properties['dx'] ?? 0.0;
                                      final double dy =
                                          widgetModel.properties['dy'] ?? 0.0;
                                      final double widgetHeight =
                                          widgetModel.properties['height'] ??
                                              10;
                                      final double widgetWidth =
                                          widgetModel.properties['width'] ??
                                              100;

                                      return Positioned(
                                        left: dx,
                                        top: dy,
                                        child: GestureDetector(
                                          onPanUpdate: (details) {
                                            setState(() {
                                              double newDx =
                                                  dx + details.delta.dx;
                                              double newDy =
                                                  dy + details.delta.dy;

                                              // Ensure the widget stays within bounds
                                              if (newDx < 10) newDx = 10;
                                              if (newDy < 10) newDy = 10;
                                              if (newDx + widgetWidth >
                                                  bodyWidth - 10) {
                                                newDx = bodyWidth -
                                                    widgetWidth -
                                                    10;
                                              }
                                              if (newDy + widgetHeight >
                                                  bodyHeight - 10) {
                                                newDy = bodyHeight -
                                                    widgetHeight -
                                                    10;
                                              }

                                              widgetModel.properties['dx'] =
                                                  newDx;
                                              widgetModel.properties['dy'] =
                                                  newDy;
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
                                          child: ResizableWidget(
                                              widget: widgetModel),
                                        ),
                                      );
                                    }).toList(),
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
