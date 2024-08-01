import 'package:bloc/bloc.dart';
import 'package:dynamic_view/src/model/device_option.dart';
import 'package:dynamic_view/src/model/widget_model.dart';
import 'package:dynamic_view/src/repo/view_builder_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

part 'view_builder_event.dart';
part 'view_builder_state.dart';

class ViewBuilderBloc extends Bloc<ViewBuilderEvent, ViewBuilderState> {
  ViewBuilderBloc({required TemplateRepository templateRepository})
      : _templateRepository = templateRepository,
        super(ViewBuilderState.initial) {
    on<DeviceOptionEvent>(_changeDeviceOptionToState);
    on<RightSidePositionedWidgetEvent>(_insertRightSideWidgetToState);
    on<RemoveRightSideWidgetEvent>(_removeRightSideWidgetFromState);
    on<SelectWidgetModelEvent>(_selectWidgetModelFromState);
    on<ChangePropertiesSelectedWidgetEvent>(
        _changeSelectWidgetPropertiesFromState);
    on<GetTemplateData>(_updateTemplateDataToState);
    on<ResetRightSideWidget>(_resetRightSideWidgets);
  }

  final TemplateRepository _templateRepository;

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
      bool widgetExists = newRightSideWidgets.any((widget) =>
          widget.properties['key'] == event.widget.properties['key']);

      if (!widgetExists) {
        var position = newRightSideWidgets.length;
        if (newRightSideWidgets.contains(event.widget)) {
          position = newRightSideWidgets.indexOf(event.widget);
        }
        newRightSideWidgets.insert(position, event.widget);
        emit(state.copyWith(
            rightSideWidgets: newRightSideWidgets,
            status: ViewBuilderStatus.loaded));
      } else {
        emit(state.copyWith(status: ViewBuilderStatus.loaded));
      }
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

      int indexToRemove = newRightSideWidgets
          .indexWhere((widget) => widget.properties['key'] == event.key);
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

  Future<void> _selectWidgetModelFromState(
      SelectWidgetModelEvent event, Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      log.d(
          "Selected Widget Model from right side widgets ::: ${event.widgetModel.properties}");

      emit(state.copyWith(
          selectedWidget: event.widgetModel, status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e(
          "Select Widget Model from Right Side Widget Event::Setting state to failure::::$error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to remove widget: $error'));
    }
  }

  Future<void> _changeSelectWidgetPropertiesFromState(
      ChangePropertiesSelectedWidgetEvent event,
      Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      log.d(event.changedProperties);
      List<WidgetModel> newRightSideWidgets =
          List<WidgetModel>.from(state.rightSideWidgets);

      int indexOfWidgetModel = newRightSideWidgets.indexWhere((widget) =>
          widget.properties['key'] == event.changedProperties['key']);
      log.d("Index of the widget to change properties: $indexOfWidgetModel");

      if (indexOfWidgetModel == -1) {
        throw RangeError(
            'Widget with key ${event.changedProperties['key']} not found');
      }

      newRightSideWidgets[indexOfWidgetModel].properties = {
        ...newRightSideWidgets[indexOfWidgetModel].properties,
        ...event.changedProperties,
      };

      emit(state.copyWith(
          rightSideWidgets: newRightSideWidgets,
          status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e(
          "Change Properties Selected Widget Event::Setting state to failure::::$error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to change properties: $error'));
    }
  }

  Future<void> _updateTemplateDataToState(
      GetTemplateData event, Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      final getTemplateData =
          await _templateRepository.getTemplateOneJsonData(event.template);

      final List<dynamic> jsonDataList = getTemplateData['data'];
      final List<WidgetModel> templateModelList = jsonDataList
          .map((json) => WidgetModel.fromJson(json as Map<String, dynamic>))
          .toList();

      final List<WidgetModel> updatedTemplateModelList =
          List.from(state.rightSideWidgets)..addAll(templateModelList);

      emit(state.copyWith(
        rightSideWidgets: updatedTemplateModelList,
        status: ViewBuilderStatus.loaded,
      ));
    } catch (error) {
      log.e("Template Data Event::Setting state to failure::::$error");
      emit(state.copyWith(
        status: ViewBuilderStatus.error,
        message: 'Failed to fetch template data: $error',
      ));
    }
  }

  Future<void> _resetRightSideWidgets(
      ResetRightSideWidget event, Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      List<WidgetModel> resetWidgets = [];

      emit(state.copyWith(
          rightSideWidgets: resetWidgets, status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e("Error during reset:: $error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to reset widgets: $error'));
    }
  }
}
