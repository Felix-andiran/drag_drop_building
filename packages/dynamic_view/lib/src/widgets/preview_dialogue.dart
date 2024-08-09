import 'dart:math';

import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_box_transform/flutter_box_transform.dart';

class PreviewButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PreviewButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: const Text('Preview'),
      icon: const Icon(Icons.remove_red_eye_sharp),
    );
  }
}

class FullScreenPreviewDialog extends StatelessWidget {
  final ViewBuilderState state;

  const FullScreenPreviewDialog({required this.state, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: SizedBox(
        width: state.width,
        height: state.height,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Preview Screen'),
            backgroundColor: Colors.blue,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: max(
                          state.droppedWidgetModels.fold<double>(
                            0.0,
                            (sum, widgetModel) =>
                                sum +
                                (widgetModel.properties['height'] ?? 0.0) +
                                10,
                          ),
                          state.height),
                      width: state.width,
                      child: Stack(
                        children: List.generate(
                          state.droppedWidgetModels.length,
                          (index) {
                            final widgetModel =
                                state.droppedWidgetModels[index];
                            final double dx = widgetModel.properties['dx'];
                            final double dy = widgetModel.properties['dy'];
                            final double height =
                                widgetModel.properties['height'];
                            final double width =
                                widgetModel.properties['width'];
                            Rect rect = Rect.fromLTWH(dx, dy, width, height);

                            return TransformableBox(
                              rect: rect,
                              resizable: false,
                              clampingRect: Offset.zero &
                                  Size(
                                      state.width,
                                      state.droppedWidgetModels.fold<double>(
                                        0.0,
                                        (sum, widgetModel) =>
                                            sum +
                                            (widgetModel.properties['height'] ??
                                                0.0) +
                                            10,
                                      )),
                              onChanged: (result, event) {},
                              contentBuilder: (context, rect, flip) {
                                return PreviewBodyWidget(widget: widgetModel);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
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
        ),
      ),
    );
  }
}

class PreviewBodyWidget extends StatefulWidget {
  final WidgetModel widget;

  const PreviewBodyWidget({super.key, required this.widget});

  @override
  PreviewBodyWidgetState createState() => PreviewBodyWidgetState();
}

class PreviewBodyWidgetState extends State<PreviewBodyWidget> {
  @override
  Widget build(BuildContext context) {
    String widgetType = widget.widget.type;

    Widget widgetContent;
    switch (widgetType) {
      case 'text':
        widgetContent = Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widget.widget.properties['paddingDx'],
              vertical: widget.widget.properties['paddingDy']),
          child: Row(
            children: [
              Text(
                '${widget.widget.properties['label'].toUpperCase()} : ',
                style: TextStyle(
                    color: Color(
                        int.parse(widget.widget.properties['labelColor'])
                            .toInt()),
                    fontWeight: FontWeight.bold,
                    fontSize: widget.widget.properties['labelSize']),
              ),
              Text(
                widget.widget.properties['value'].toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(
                        int.parse(widget.widget.properties['valueColor'])
                            .toInt()),
                    fontSize: widget.widget.properties['valueSize'],
                    overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        );
        break;
      case 'button':
        widgetContent = Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widget.widget.properties['paddingDx'],
              vertical: widget.widget.properties['paddingDy']),
          child: Container(
            height: widget.widget.properties['height'],
            width: widget.widget.properties['width'],
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.widget.properties['borderRadius'])),
              shape: BoxShape.rectangle,
              color:
                  Color(int.parse(widget.widget.properties['color']).toInt()),
            ),
            child: Center(
              child: Text(
                widget.widget.properties['label'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.widget.properties['labelSize'],
                  color: Color(int.parse(widget.widget.properties['labelColor'])
                      .toInt()),
                ),
              ),
            ),
          ),
        );
        break;
      case 'cardWithTitleDescription':
        widgetContent = CardWithTitleDescription(
          width: widget.widget.properties['width'],
          height: widget.widget.properties['height'],
          paddingDx: widget.widget.properties['paddingDx'],
          paddingDy: widget.widget.properties['paddingDy'],
          title: widget.widget.properties['title'],
          value: widget.widget.properties['value'],
          subtitle: widget.widget.properties['subtitle'],
          titleFontSize: widget.widget.properties['titleFontSize'],
          valueFontSize: widget.widget.properties['valueFontSize'],
          subTitleFontSize: widget.widget.properties['subTitleFontSize'],
          titleColor: widget.widget.properties['titleColor'],
          valueColor: widget.widget.properties['valueColor'],
          subTitleColor: widget.widget.properties['subTitleColor'],
          backgroundColor: widget.widget.properties['backgroundColor'],
          borderRadius: widget.widget.properties['borderRadius'],
        );
        break;
      case 'cardWithMenu':
        widgetContent = CardWithMenu(
          width: widget.widget.properties['width'],
          height: widget.widget.properties['height'],
          paddingDx: widget.widget.properties['paddingDx'],
          paddingDy: widget.widget.properties['paddingDy'],
          title: widget.widget.properties['title'],
          buttonTitle: widget.widget.properties['buttonTitle'],
          buttonColor: widget.widget.properties['buttonColor'],
          description: widget.widget.properties['description'],
          titleFontSize: widget.widget.properties['titleFontSize'],
          descriptionFontSize: widget.widget.properties['descriptionFontSize'],
          titleColor: widget.widget.properties['titleColor'],
          descriptionColor: widget.widget.properties['descriptionColor'],
          backgroundColor: widget.widget.properties['backgroundColor'],
          borderRadius: widget.widget.properties['borderRadius'],
        );
        break;
      default:
        widgetContent = const SizedBox.shrink();
    }

    return buildWithRemove(
        context, widget.widget.properties['key'], widgetContent);
  }

  Widget buildWithRemove(BuildContext context, String key, Widget widget) {
    return widget;
  }
}
