import 'package:flutter/material.dart';

class CUIHorizontalSpacer extends StatelessWidget {
  final double? multiplier;

  const CUIHorizontalSpacer(this.multiplier, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 8 * (multiplier ?? 0),
    );
  }
}

class CUIVerticalSpacer extends StatelessWidget {
  final double? multiplier;

  const CUIVerticalSpacer(this.multiplier, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8 * (multiplier ?? 0),
    );
  }
}
