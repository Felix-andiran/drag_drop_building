
enum WidgetType { text, button, nested }

class WidgetModel {
  final WidgetType type;
  Map<String, dynamic> properties;

  WidgetModel({required this.type, required this.properties});
}
