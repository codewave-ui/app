import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CUILoading extends StatelessWidget {
  final double size;
  final Color color;
  final String? text;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingTop;
  final double? paddingBottom;
  final Color? textColor;

  const CUILoading(
      {super.key,
      required this.size,
      required this.color,
      this.text,
      this.paddingLeft,
      this.paddingRight,
      this.paddingTop,
      this.paddingBottom,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(paddingLeft ?? 0, paddingTop ?? 0,
          paddingRight ?? 0, paddingBottom ?? 0),
      child: Column(
        children: [
          LoadingAnimationWidget.threeRotatingDots(color: color, size: size),
          const SizedBox(
            height: 8,
          ),
          ...(text != null
              ? [
                  Text(
                    text!,
                    style: TextStyle(color: textColor),
                  )
                ]
              : [])
        ],
      ),
    );
  }
}
