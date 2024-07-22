import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:drag_drop_test/view_Builder/repo/view_builder_repository.dart';
import 'package:equatable/equatable.dart';


part 'view_builder_event.dart';
part 'view_builder_state.dart';

class ViewBuilderBloc extends Bloc<ViewBuilderEvent, ViewBuilderState> {

  ViewBuilderBloc({
    required ViewBuilderRepository viewBuilderRepository,
  })  : _viewBuilderRepository = viewBuilderRepository,
        super(ViewBuilderInitial()) {
    on<GetJsonViewData>(_onViewBuilderDataRequested);
  }
  final ViewBuilderRepository _viewBuilderRepository;

  Future<void> _onViewBuilderDataRequested(
    GetJsonViewData event,
    Emitter<ViewBuilderState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => ViewBuilderStatus.loading));
      final viewBuilderData =
          await _viewBuilderRepository.getViewJsonData();
      emit(
        state.copyWith(
          status: () => ViewBuilderStatus.loaded,
          viewData: () => viewBuilderData,
        ),
      );
    } catch (error) {
      state.copyWith(
        status: () => ViewBuilderStatus.error,
        message: error.toString,
      );
    }
  }
}
