import 'package:dynamic_view/dynamic_view_package.dart';

String widgetModelType(WidgetType value) {
  String message = 'text';

  switch (value) {
    case WidgetType.text:
      message = 'text';
      break;
    case WidgetType.button:
      message = 'button';
      break;
    case WidgetType.cardWithTitleDescription:
      message = 'cardWithTitleDescription';
      break;
    case WidgetType.cardWithMenu:
      message = 'cardWithMenu';
      break;
  }
  return message;
}
