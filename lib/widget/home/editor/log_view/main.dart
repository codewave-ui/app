import 'package:flutter/material.dart';

class CUILogView extends StatelessWidget {
  const CUILogView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Center(
        child: Text("LOG_VIEW"),
      ),
    );
  }
}
