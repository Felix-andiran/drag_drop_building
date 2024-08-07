import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomizationPanel extends StatefulWidget {
  final WidgetModel? widget;

  const CustomizationPanel({this.widget, super.key});

  @override
  CustomizationPanelState createState() => CustomizationPanelState();
}

class CustomizationPanelState extends State<CustomizationPanel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
      builder: (context, state) {
        if (state.selectedWidget == null || state.rightSideWidgets.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('Customization Panel')),
            body: const Center(child: Text('Select a widget to customize')),
          );
        }

        final WidgetModel selectedWidget = state.selectedWidget!;

        return Scaffold(
          appBar: AppBar(
              title: Text(
                  'Customize ${widget.widget!.type.toString().split('.').last}')),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.widget!.type == widgetModelType(WidgetType.text))
                    TextCustomization(
                      widget: selectedWidget,
                    ),
                  if (widget.widget!.type == widgetModelType(WidgetType.button))
                    ButtonCustomization(
                      widget: selectedWidget,
                    ),
                  if (widget.widget!.type == widgetModelType(WidgetType.card))
                    CardCustomization(
                      widget: selectedWidget,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
