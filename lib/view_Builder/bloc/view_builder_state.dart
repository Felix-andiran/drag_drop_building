part of 'view_builder_bloc.dart';

enum ViewBuilderStatus { initial, loading, loaded, error }

final class ViewBuilderState extends Equatable {
  const ViewBuilderState({
    this.status = ViewBuilderStatus.initial,
    this.viewData,
    this.message,
  });
  final ViewBuilderStatus status;
  final Map<String,dynamic>? viewData;
  final String? message;

  ViewBuilderState copyWith({
    ViewBuilderStatus Function()? status,
    Map<String,dynamic>? Function()? viewData,
    String Function()? message,
  }) {
    return ViewBuilderState(
      status: status != null ? status() : this.status,
      viewData: viewData != null ? viewData() : this.viewData,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object> get props => [status];
}

final class ViewBuilderInitial extends ViewBuilderState {}
