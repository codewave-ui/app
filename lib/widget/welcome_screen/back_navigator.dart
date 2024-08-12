import 'package:codewave_ui/widget/common/cui_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreenBackNavigator extends StatelessWidget {
  const WelcomeScreenBackNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return CUIButton(
      text: "Cancel",
      onPressed: () {
        Navigator.of(context).pop();
      },
      variant: Variant.outlined,
      color: const CUIButtonColorError(),
      startIcon: Icons.arrow_back,
    );
  }
}
