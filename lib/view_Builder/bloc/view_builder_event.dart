part of 'view_builder_bloc.dart';

sealed class ViewBuilderEvent extends Equatable {
  const ViewBuilderEvent();

  @override
  List<Object> get props => [];
}

final class GetJsonViewData extends ViewBuilderEvent {
  const GetJsonViewData();
}

