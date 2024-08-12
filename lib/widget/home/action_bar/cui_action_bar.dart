import 'package:codewave_ui/widget/common/cui_button.dart';
import 'package:flutter/material.dart';

class CUIActionBar extends StatelessWidget {
  const CUIActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("ACTION BAR"),
        CUIButton(text: "TEST", onPressed: () {}, variant: Variant.outlined)
      ],
    );
  }
}
