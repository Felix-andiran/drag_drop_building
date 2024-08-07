import 'package:bloc/bloc.dart';
import 'package:dynamic_view/dynamic_view_package.dart';
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
    on<DroppedWidgetModelEvent>(_insertDroppedWidgetModelToState);
    on<RemoveWidgetModelFromDroppedListEvent>(_removeWidgetModelFromState);
    on<SelectWidgetModelEvent>(_selectWidgetModelFromState);
    on<ChangePropertiesSelectedWidgetEvent>(
        _changeSelectWidgetPropertiesFromState);
    on<GetTemplateData>(_updateTemplateDataToState);
    on<ResetRightSideWidget>(_resetdroppedWidgetModelsToState);
    on<RightPanelViewEvent>(_changeRightPanelExpandToState);
    on<LeftPanelViewEvent>(_changeLeftPanelExpandToState);
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

  Future<void> _insertDroppedWidgetModelToState(
      DroppedWidgetModelEvent event, Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      List<WidgetModel> newdroppedWidgetModels =
          List.from(state.droppedWidgetModels);
      bool widgetExists = newdroppedWidgetModels.any((widget) =>
          widget.properties['key'] == event.widget.properties['key']);

      if (!widgetExists) {
        var position = newdroppedWidgetModels.length;
        if (newdroppedWidgetModels.contains(event.widget)) {
          position = newdroppedWidgetModels.indexOf(event.widget);
        }
        newdroppedWidgetModels.insert(position, event.widget);
        emit(state.copyWith(
            droppedWidgetModels: newdroppedWidgetModels,
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

  Future<void> _removeWidgetModelFromState(
      RemoveWidgetModelFromDroppedListEvent event,
      Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      List<WidgetModel> newdroppedWidgetModels =
          List<WidgetModel>.from(state.droppedWidgetModels);

      int indexToRemove = newdroppedWidgetModels
          .indexWhere((widget) => widget.properties['key'] == event.key);
      log.d("Index to be removed from the right side widget ::: ${event.key}");
      newdroppedWidgetModels.removeAt(indexToRemove);

      emit(state.copyWith(
          droppedWidgetModels: newdroppedWidgetModels,
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
          selectedWidgetModel: event.widgetModel, status: ViewBuilderStatus.loaded));
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
      List<WidgetModel> newdroppedWidgetModels =
          List<WidgetModel>.from(state.droppedWidgetModels);

      int indexOfWidgetModel = newdroppedWidgetModels.indexWhere((widget) =>
          widget.properties['key'] == event.changedProperties['key']);
      log.d("Index of the widget to change properties: $indexOfWidgetModel");

      if (indexOfWidgetModel == -1) {
        throw RangeError(
            'Widget with key ${event.changedProperties['key']} not found');
      }

      newdroppedWidgetModels[indexOfWidgetModel].properties = {
        ...newdroppedWidgetModels[indexOfWidgetModel].properties,
        ...event.changedProperties,
      };

      emit(state.copyWith(
          droppedWidgetModels: newdroppedWidgetModels,
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
          List.from(state.droppedWidgetModels)..addAll(templateModelList);

      emit(state.copyWith(
        droppedWidgetModels: updatedTemplateModelList,
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

  Future<void> _resetdroppedWidgetModelsToState(
      ResetRightSideWidget event, Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      List<WidgetModel> resetWidgets = [];

      emit(state.copyWith(
          droppedWidgetModels: resetWidgets, status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e("Error during reset:: $error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to reset widgets: $error'));
    }
  }

  Future<void> _changeRightPanelExpandToState(
      RightPanelViewEvent event, Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      emit(state.copyWith(
          rightPanelView: event.openOrClose, status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e("Error during Changing Right Panel Bool:: $error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to Change Right Panel Bool: $error'));
    }
  }

  Future<void> _changeLeftPanelExpandToState(
      LeftPanelViewEvent event, Emitter<ViewBuilderState> emit) async {
    emit(state.copyWith(status: ViewBuilderStatus.loading));
    try {
      emit(state.copyWith(
          leftPanelView: event.openOrClose, status: ViewBuilderStatus.loaded));
    } catch (error) {
      log.e("Error during Changing Left Panel Bool:: $error");
      emit(state.copyWith(
          status: ViewBuilderStatus.error,
          message: 'Failed to Change Left Panel Bool: $error'));
    }
  }
}
