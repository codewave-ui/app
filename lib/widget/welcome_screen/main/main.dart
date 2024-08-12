import 'package:codewave_ui/cubit/app/app_cubit.dart';
import 'package:codewave_ui/cubit/app/app_model.dart';
import 'package:codewave_ui/cubit/app/simple_project_model/main.dart';
import 'package:codewave_ui/cubit/theme/theme_cubit.dart';
import 'package:codewave_ui/util/cui_debouncer.dart';
import 'package:codewave_ui/widget/empty_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

part 'action_panel/action_button.dart';
part 'action_panel/action_button_group.dart';
part 'action_panel/container.dart';
part 'recent_project/container.dart';
part 'recent_project/project_list.dart';
part 'recent_project/search_bar.dart';

class WelcomeScreenMain extends StatelessWidget {
  const WelcomeScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            context.read<ThemeCubit>().toggleBrightness();
            // SmartDialog.showNotify(
            //   msg: "SDF",
            //   notifyType: NotifyType.success,
            //   keepSingle: true,
            // );
            // SmartDialog.showLoading(
            //     msg: "Loading Test", maskColor: Color.fromARGB(200, 0, 0, 0));
            // await Future.delayed(Durations.extralong4);
            // SmartDialog.dismiss(status: SmartStatus.loading);
          },
          child: Icon(Icons.settings),
          mini: true,
        ),
        body: Row(
          children: [
            RecentProjectContainer(),
            VerticalDivider(
              width: 1,
            ),
            WelcomeScreenActionPanelContainer(),
            // Column(
            //   children: [
            //     Expanded(child: Text("asdf")),
            //   ],
            // ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image(
            //       image: AssetImage("assets/logo.png"),
            //       height: 150,
            //       width: 150,
            //     ),
            //     Text("adsf")
            //   ],
            // )
          ],
        ));
  }
}
