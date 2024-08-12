import 'package:codewave_ui/widget/common/cui_spacer.dart';
import 'package:flutter/material.dart';

class EmptyOverlay extends StatelessWidget {
  const EmptyOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/no-data.png"),
            height: 36,
            width: 36,
          ),
          CUIHorizontalSpacer(1),
          Text(
            "Empty Data!",
            textScaler: TextScaler.linear(1.2),
          )
        ],
      ),
    );
  }
}
