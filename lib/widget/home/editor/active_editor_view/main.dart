import 'package:flutter/material.dart';

class CUIActiveEditorView extends StatelessWidget {
  const CUIActiveEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surfaceContainer,
      child: Center(
        child: Text("ACTIVE_EDITOR_VIEW"),
      ),
    );
  }
}
