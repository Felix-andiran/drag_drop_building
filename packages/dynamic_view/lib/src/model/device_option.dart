import 'package:equatable/equatable.dart';

class DeviceOption extends Equatable {
  final String name;
  final double width;
  final double height;

  const DeviceOption(
      {required this.name, required this.width, required this.height});

  factory DeviceOption.fromJson(Map<String, dynamic> json) {
    return DeviceOption(
      name: json['name'],
      width: json['width'].toDouble(),
      height: json['height'].toDouble(),
    );
  }

  @override
  List<Object?> get props => [name, width, height];
}
