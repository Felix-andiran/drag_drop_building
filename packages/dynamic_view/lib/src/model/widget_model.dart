enum WidgetType { text, button, cardWithTitleDescription, cardWithMenu }

class WidgetModel {
  final String type;
  Map<String, dynamic> properties;

  WidgetModel({required this.type, required this.properties});

  WidgetModel copyWith({Map<String, dynamic>? properties}) {
    return WidgetModel(
      type: type,
      properties: properties ?? this.properties,
    );
  }

  // Factory constructor to create a WidgetModel from JSON
  factory WidgetModel.fromJson(Map<String, dynamic> json) {
    return WidgetModel(
      type: json['type'] as String,
      properties: Map<String, dynamic>.from(json['properties'] as Map),
    );
  }

  // Method to convert WidgetModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'properties': properties,
    };
  }
}
