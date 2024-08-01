import 'package:dynamic_view/dynamic_view_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DeviceDropdown extends StatefulWidget {
  const DeviceDropdown({super.key});

  @override
  DeviceDropdownState createState() => DeviceDropdownState();
}

class DeviceDropdownState extends State<DeviceDropdown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ViewBuilderBloc, ViewBuilderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<DeviceOption>(
                      menuMaxHeight: 300,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      alignment: Alignment.bottomCenter,
                      isDense: true,
                      hint: const Text('Select Device'),
                      value: state.selectedDevice,
                      onChanged: (DeviceOption? newValue) {
                        if (newValue != null) {
                          context
                              .read<ViewBuilderBloc>()
                              .add(DeviceOptionEvent(device: newValue));
                        }
                      },
                      items: state.devices.map((DeviceOption device) {
                        return DropdownMenuItem<DeviceOption>(
                          value: device,
                          child: Text(
                            device.name,
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(width: 20),
                    CustomTextField(
                      controller: state.widthController,
                      labelText: 'Width',
                      readOnly: true,
                    ),
                    const SizedBox(width: 20),
                    CustomTextField(
                      controller: state.heightController,
                      labelText: 'Height',
                      readOnly: true,
                    ),
                  ],
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
