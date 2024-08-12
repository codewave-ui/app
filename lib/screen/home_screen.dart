import 'package:codewave_ui/cubit/app/app_cubit.dart';
import 'package:codewave_ui/cubit/app/app_model.dart';
import 'package:codewave_ui/cubit/theme/theme_cubit.dart';
import 'package:codewave_ui/widget/home/action_bar/cui_action_bar.dart';
import 'package:codewave_ui/widget/home/editor/cui_editor_container.dart';
import 'package:codewave_ui/widget/home/top_menu_bar/cui_top_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppModel>(
      builder: (context, project) {
        return Scaffold(
            // appBar: AppBar(
            //   // TRY THIS: Try changing the color here to a specific color (to
            //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            //   // change color while the other colors stay the same.
            //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            //   // Here we take the value from the MyHomePage object that was created by
            //   // the App.build method, and use it to set our appbar title.
            //   title: Text(widget.title),
            // ),
            body: Column(
              children: [
                CUITopMenuBar(),
                CUIActionBar(),
                Expanded(
                  child: CUIEditorContainer(),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.brightness_1),
              onPressed: () async {
                context.read<ThemeCubit>().toggleBrightness();
              },
            )
            // FloatingActionButton(
            //   child: const Icon(Icons.brightness_6),
            //   onPressed: () => context.read<BrightnessCubit>().toggleBrightness(),
            // ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: _incrementCounter,
            //   tooltip: 'Increment',
            //   child: const Icon(Icons.add),
            // ), // This trailing comma makes auto-formatting nicer for build methods.
            );
      },
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
  }
}
