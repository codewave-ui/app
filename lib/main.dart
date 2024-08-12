import 'package:codewave_ui/cubit/app/app_cubit.dart';
import 'package:codewave_ui/cubit/app/app_model.dart';
import 'package:codewave_ui/cubit/theme/theme_cubit.dart';
import 'package:codewave_ui/screen/app_screen.dart';
import 'package:codewave_ui/util/cui_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await CUILogger.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  Size minimumSize = const Size(1000, 600);

  WindowOptions windowOptions = WindowOptions(
      size: minimumSize,
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.normal,
      minimumSize: minimumSize,
      title: "Codewave UI");
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  SmartDialog.config.custom = SmartConfigCustom(
      maskColor: Colors.black54,
      alignment: Alignment.center,
      backDismiss: false,
      clickMaskDismiss: false,
      animationTime: const Duration(milliseconds: 250));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    return MultiBlocProvider(providers: [
      BlocProvider<ThemeCubit>(
        create: (_) => ThemeCubit(brightness),
      ),
      BlocProvider<AppCubit>(create: (_) => AppCubit(AppModel(null, [])))
    ], child: const AppScreen());
  }
}
