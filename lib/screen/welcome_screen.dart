import 'package:codewave_ui/widget/welcome_screen/main/main.dart';
import 'package:codewave_ui/widget/welcome_screen/new_project/main.dart';
import 'package:codewave_ui/widget/welcome_screen/open_project/main.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings route) {
          WidgetBuilder builder;
          switch (route.name) {
            case '/':
              builder = (_) => const WelcomeScreenMain();
            case '/welcome/open':
              builder = (_) => const OpenProjectScreen();
            case '/welcome/new':
              builder = (_) => const NewProjectScreen();
            default:
              throw Exception('Invalid route: ${route.name}');
          }
          return MaterialPageRoute(builder: builder, settings: route);
        });
  }
}
