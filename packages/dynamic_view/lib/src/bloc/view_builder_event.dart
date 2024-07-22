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

class ReorderRightSideWidgetEvent extends ViewBuilderEvent {
  final int oldIndex;
  final int newIndex;
  const ReorderRightSideWidgetEvent({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object> get props => [oldIndex, newIndex];
}
