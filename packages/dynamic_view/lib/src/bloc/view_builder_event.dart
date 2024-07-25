part of 'view_builder_bloc.dart';

class ViewBuilderEvent extends Equatable {
  const ViewBuilderEvent();

  @override
  List<Object> get props => [];
}

class DeviceOptionEvent extends ViewBuilderEvent {
  final DeviceOption device;
  const DeviceOptionEvent({
    required this.device,
  });
  @override
  List<Object> get props => [device];
}

class RightSidePositionedWidgetEvent extends ViewBuilderEvent {
  final WidgetModel widget;
  const RightSidePositionedWidgetEvent({
    required this.widget,
  });
  @override
  List<Object> get props => [widget];
}

class RemoveRightSideWidgetEvent extends ViewBuilderEvent {
  final Widget widget;
  final String key;
  const RemoveRightSideWidgetEvent({
    required this.widget,
    required this.key,
  });

  @override
  List<Object> get props => [widget, key];
}

class SelectWidgetModelEvent extends ViewBuilderEvent {
  final WidgetModel widgetModel;
  const SelectWidgetModelEvent({
    required this.widgetModel,
  });

  @override
  List<Object> get props => [widgetModel];
}

class ChangePropertiesSelectedWidgetEvent extends ViewBuilderEvent {
  final Map<String, dynamic> changedProperties;
  const ChangePropertiesSelectedWidgetEvent({
    required this.changedProperties,
  });

  @override
  List<Object> get props => [changedProperties];
}

// class RightSideWidgetPositioningEvent extends ViewBuilderEvent {
//   final double newDx;
//   final double newDy;
//   final Map<String, dynamic> changedProperties;
//   const RightSideWidgetPositioningEvent({
//     required this.newDx,
//     required this.newDy,
//     required this.changedProperties,
//   });

//   @override
//   List<Object> get props => [newDx, newDy, changedProperties];
// }
