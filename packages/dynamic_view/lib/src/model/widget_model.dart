enum WidgetType { text, button, nested }

class WidgetModel {
  final WidgetType type;
  Map<String, dynamic> properties;

  WidgetModel({required this.type, required this.properties});

  WidgetModel copyWith({Map<String, dynamic>? properties}) {
    return WidgetModel(
      type: type,
      properties: properties ?? this.properties,
    );
  }
}
