import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:dynamic_view/src/widgets/components/card_with_menu.dart';
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
    return Stack(
      children: [
        widget,
        Positioned(
          right: 0,
          top: 0,
          child: InkWell(
            onTap: () {
              context.read<ViewBuilderBloc>().add(
                    RemoveWidgetModelFromDroppedListEvent(
                        widget: widget, key: key),
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
