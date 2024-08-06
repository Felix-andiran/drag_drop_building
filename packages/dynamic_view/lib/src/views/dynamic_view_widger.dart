import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

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
              leading: GestureDetector(
                  onTap: () {
                    context.read<ViewBuilderBloc>().add(
                          LeftPanelViewEvent(openOrClose: !state.leftPanelView),
                        );
                  },
                  child: const Icon(Icons.menu, size: 28)),
              centerTitle: false,
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
                const Gap(5),
                PreviewButton(onPressed: showPreviewDialog),
                const Gap(5),
                TextButton.icon(
                  onPressed: () {
                    context.read<ViewBuilderBloc>().add(
                          const GetTemplateData(template: 'template_one'),
                        );
                  },
                  label: const Text('Load Template'),
                  icon: const Icon(Icons.upload),
                ),
                const Gap(5),
                Center(
                    child: GestureDetector(
                        onTap: () {
                          context.read<ViewBuilderBloc>().add(
                                RightPanelViewEvent(
                                    openOrClose: !state.rightPanelView),
                              );
                        },
                        child: const Icon(
                          Icons.miscellaneous_services_sharp,
                          size: 32,
                        ))),
                const Gap(5),
              ],
            ),
            body: Row(
              children: [
                state.leftPanelView
                    ? Expanded(
                        flex: 1,
                        child: DataListWidget(
                          viewData: widget.viewData,
                        ),
                      )
                    : const SizedBox.shrink(),
                const Expanded(flex: 3, child: DropTarget()),
                state.rightPanelView
                    ? Expanded(
                        flex: 1,
                        child: CustomizationPanel(
                          widget: state.selectedWidget,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
