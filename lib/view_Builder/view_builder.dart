import 'package:drag_drop_test/view_Builder/bloc/view_builder_bloc.dart';
import 'package:drag_drop_test/view_Builder/repo/view_builder_repository.dart';
import 'package:drag_drop_test/view_Builder/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewRenderer extends StatelessWidget {
  const ViewRenderer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewBuilderBloc(
        viewBuilderRepository: const ViewBuilderRepository(),
      )..add(const GetJsonViewData()),
      child: const ViewBuilderPage(),
    );
  }
}
