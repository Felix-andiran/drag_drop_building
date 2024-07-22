import 'package:drag_drop_test/view_Builder/bloc/view_builder_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dynamic_view/dynamic_view_package.dart';

class ViewBuilderPage extends StatefulWidget {
  const ViewBuilderPage({super.key});

  @override
  ViewBuilderPageState createState() => ViewBuilderPageState();
}

class ViewBuilderPageState extends State<ViewBuilderPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
        builder: (context, state) {
          if (state.status == ViewBuilderStatus.loaded) {
            Map<String, dynamic>? data = state.viewData!;
            return DynamicViewBuilder(
              viewData: data,
            );
          } else if (state.status == ViewBuilderStatus.error) {
            return Text(
              'Error retrieving data for {}',
              style: Theme.of(context).textTheme.bodySmall,
            );
          } else {
            return Center(
              child: Text(
                'Loading data',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
        },
      ),
    );
  }
}
