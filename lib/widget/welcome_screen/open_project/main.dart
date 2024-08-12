import 'package:codewave_ui/cubit/app/app_cubit.dart';
import 'package:codewave_ui/util/cui_project_manager.dart';
import 'package:codewave_ui/widget/common/form/cui_form.dart';
import 'package:codewave_ui/widget/welcome_screen/back_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:window_manager/window_manager.dart';

part 'form/project_location_form.dart';
part 'open_project_form.dart';

class OpenProjectScreen extends StatelessWidget {
  const OpenProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 32, top: 24, bottom: 32, right: 32),
        child: Column(children: [
          Row(children: [
            WelcomeScreenBackNavigator(),
          ]),
          SizedBox(height: 16),
          Row(children: [
            Text(
              "Open Project",
              textScaler: TextScaler.linear(2),
            )
          ]),
          Divider(
            height: 48,
          ),
          Expanded(child: OpenProjectForm())
        ]),
      ),
    );
  }
}
