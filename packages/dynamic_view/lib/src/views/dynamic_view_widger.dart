import 'package:dynamic_view/src/bloc/view_builder_bloc.dart';
import 'package:dynamic_view/src/widgets/customization_panel.dart';
import 'package:dynamic_view/src/widgets/data_list_widget.dart';
import 'package:dynamic_view/src/widgets/drop_target.dart';
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
      create: (context) => ViewBuilderBloc(),
      child: BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Custom View Builder'),
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
                  flex: 2,
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

//  Expanded(
//                   flex: 3,
//                   child: DragTarget<Widget>(
//                     onAccept: (Widget data) {
//                       context
//                           .read<ViewBuilderBloc>()
//                           .add(RightSidePositionedWidgetEvent(widget: data));
//                     },
//                     builder: (context, candidateData, rejectedData) {
//                       return Container(
//                         height: double.infinity,
//                         color: Colors.grey[200],
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const DeviceDropdown(),
//                               Container(
//                                 color: Colors.white54,
//                                 height: state.height,
//                                 width: state.width,
//                                 child: ReorderableListView(
//                                   onReorder: (int oldIndex, int newIndex) {
//                                     context.read<ViewBuilderBloc>().add(
//                                         ReorderRightSideWidgetEvent(
//                                             newIndex: newIndex,
//                                             oldIndex: oldIndex));
//                                   },
//                                   children: [
//                                     for (int index = 0;
//                                         index < state.rightSideWidgets.length;
//                                         index++)
//                                       Container(
//                                         key: ValueKey(index),
//                                         child: state.rightSideWidgets[index],
//                                       ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
               