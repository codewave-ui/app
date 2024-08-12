import 'dart:io';

import 'package:codewave_ui/constant/constant.dart';
import 'package:codewave_ui/util/cui_command_line_interface.dart';
import 'package:codewave_ui/util/cui_project_manager.dart';
import 'package:codewave_ui/widget/common/cui_button.dart';
import 'package:codewave_ui/widget/common/dialog/cui_confirmation_dialog.dart';
import 'package:codewave_ui/widget/common/form/cui_form.dart';
import 'package:codewave_ui/widget/common/form/cui_form_validator.dart';
import 'package:codewave_ui/widget/welcome_screen/back_navigator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

part 'form/name_and_location_input_form.dart';
part 'form/node_input_form.dart';
part 'form/npm_input_form.dart';
part 'git_initialization_form.dart';
part 'new_project_form.dart';

class NewProjectScreen extends StatelessWidget {
  const NewProjectScreen({super.key});

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
              "New Project",
              textScaler: TextScaler.linear(2),
            )
          ]),
          Divider(
            height: 48,
          ),
          Expanded(child: NewProjectForm())
        ]),
      ),
    );
  }
}
