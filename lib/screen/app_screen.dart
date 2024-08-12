import 'package:codewave_ui/cubit/theme/theme_cubit.dart';
import 'package:codewave_ui/screen/home_screen.dart';
import 'package:codewave_ui/screen/welcome_screen.dart';
import 'package:codewave_ui/theme/theme.dart';
import 'package:codewave_ui/theme/util.theme.dart';
import 'package:codewave_ui/util/cui_color.dart';
import 'package:codewave_ui/widget/common/dialog/cui_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../widget/common/dialog/cui_toast.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, Brightness>(
      builder: (context, brightness) {
        TextTheme textTheme =
            createTextTheme(context, brightness, "Quicksand", "Quicksand");

        MaterialTheme theme = MaterialTheme(textTheme);

        return MaterialApp(
          theme: brightness == Brightness.light ? theme.light() : theme.dark(),
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(
            notifyStyle: FlutterSmartNotifyStyle(
                successBuilder: (String message) => CUIToast(
                      lightThemeStyle: CUIToastStyle(
                        borderColor: CUIColors.successLight,
                        backgroundColor: CUIColors.successLight,
                        contentColor: Colors.white,
                      ),
                      darkThemeStyle: CUIToastStyle(
                          contentColor: Colors.white,
                          borderColor: CUIColors.successDark,
                          backgroundColor: CUIColors.successDark),
                      text: message,
                      icon: Icons.check,
                    ),
                errorBuilder: (String message) => CUIToast(
                      lightThemeStyle: CUIToastStyle(
                          borderColor: CUIColors.errorLight,
                          backgroundColor: CUIColors.errorLight,
                          contentColor: Colors.white),
                      darkThemeStyle: CUIToastStyle(
                          contentColor: Colors.white,
                          borderColor: CUIColors.errorDark,
                          backgroundColor: CUIColors.errorDark),
                      text: message,
                      icon: Icons.close,
                    )),
            loadingBuilder: (String message) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CUILoading(
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                  text: message,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => const WelcomeScreen(),
            '/project': (BuildContext context) =>
                const MyHomePage(title: 'TEST')
          },
        );
      },
    );
  }
}
