import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicViewBuilder extends StatefulWidget {
  final Map<String, dynamic> viewData;

  const DynamicViewBuilder({super.key, required this.viewData});

  @override
  State<DynamicViewBuilder> createState() => _DynamicViewBuilderState();
}

class _DynamicViewBuilderState extends State<DynamicViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ViewBuilderBloc(templateRepository: TemplateRepository()),
      child: BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
        builder: (context, state) {
          void showPreviewDialog() {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return FullScreenPreviewDialog(state: state);
              },
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Custom View Builder'),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<CircleBorder>(
                      const CircleBorder(),
                    ),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.all(12.0),
                    ),
                    minimumSize: WidgetStateProperty.all<Size>(
                      const Size(24.0, 24.0),
                    ),
                  ),
                  onPressed: () => context.read<ViewBuilderBloc>().add(
                        const ResetRightSideWidget(),
                      ),
                  child: const Icon(Icons.restart_alt_rounded),
                ),
                PreviewButton(onPressed: showPreviewDialog),
                TextButton.icon(
                  onPressed: () {
                    context.read<ViewBuilderBloc>().add(
                          const GetTemplateData(template: 'template_one'),
                        );
                  },
                  label: const Text('Load Template'),
                  icon: const Icon(Icons.upload),
                )
              ],
            ),
            body: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: DataListWidget(
                    viewData: widget.viewData,
                  ),
                ),
                const Expanded(flex: 3, child: DropTarget()),
                Expanded(
                  flex: 1,
                  child: CustomizationPanel(
                    widget: state.selectedWidget,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
