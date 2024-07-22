import 'package:bloc/bloc.dart';
import 'package:dynamic_view/src/model/device_option.dart';
import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

part 'view_builder_event.dart';
part 'view_builder_state.dart';

class ViewBuilderBloc extends Bloc<ViewBuilderEvent, ViewBuilderState> {
  ViewBuilderBloc() : super(ViewBuilderState.initial) {
    on<DeviceOptionEvent>(_changeDeviceOptionToState);
    on<RightSidePositionedWidgetEvent>(_insertRightSideWidgetToState);
    on<RemoveRightSideWidgetEvent>(_removeRightSideWidgetFromState);
    on<ReorderRightSideWidgetEvent>(_reorderRightSideWidgetFromState);
  }

  final log = Logger();

  Future<void> _changeDeviceOptionToState(
      DeviceOptionEvent event, Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      emit(state.copyWith(
          height: event.device.height,
          width: event.device.width,
          heightController:
              TextEditingController(text: event.device.height.toString()),
          widthController:
              TextEditingController(text: event.device.width.toString()),
          selectedDevice: event.device,
          status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e("Load Favorite Data Event::Setting state to failure::::$error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to fetch favor items: $error'));
    }
  }

  Future<void> _insertRightSideWidgetToState(
      RightSidePositionedWidgetEvent event,
      Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      List<WidgetModel> newRightSideWidgets = List.from(state.rightSideWidgets);

      var position = newRightSideWidgets.length;
      if (newRightSideWidgets.contains(event.widget)) {
        position = newRightSideWidgets.indexOf(event.widget);
      }

      newRightSideWidgets.insert(position, event.widget);

      emit(state.copyWith(
          rightSideWidgets: newRightSideWidgets,
          status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e("Load Favorite Data Event::Setting state to failure::::$error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to fetch favor items: $error'));
    }
  }

  Future<void> _removeRightSideWidgetFromState(
      RemoveRightSideWidgetEvent event, Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      List<WidgetModel> newRightSideWidgets =
          List<WidgetModel>.from(state.rightSideWidgets);

      int indexToRemove =
          newRightSideWidgets.indexWhere((widget) => widget.properties['key'] == event.key);
      log.d("Index to be removed from the right side widget ::: ${event.key}");
      newRightSideWidgets.removeAt(indexToRemove);

      emit(state.copyWith(
          rightSideWidgets: newRightSideWidgets,
          status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e(
          "Remove Right Side Widget Event::Setting state to failure::::$error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to remove widget: $error'));
    }
  }

  Future<void> _reorderRightSideWidgetFromState(
    ReorderRightSideWidgetEvent event,
    Emitter<ViewBuilderState> emit,
  ) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      List<WidgetModel> newRightSideWidgets =
          List<WidgetModel>.from(state.rightSideWidgets);

      int oldIndex = event.oldIndex;
      int newIndex = event.newIndex;

      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final widget = newRightSideWidgets.removeAt(oldIndex);
      newRightSideWidgets.insert(newIndex, widget);

      emit(state.copyWith(
          rightSideWidgets: newRightSideWidgets,
          status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e(
          "Remove Right Side Widget Event::Setting state to failure::::$error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to remove widget: $error'));
    }
  }
}
