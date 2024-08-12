import 'package:flutter/material.dart';

class CUIToast extends StatelessWidget {
  final CUIToastStyle lightThemeStyle;
  final CUIToastStyle darkThemeStyle;
  final String text;
  final IconData icon;

  const CUIToast(
      {super.key,
      required this.lightThemeStyle,
      required this.darkThemeStyle,
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: Container()),
          DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      width: 1,
                      style: BorderStyle.solid,
                      color: brightness == Brightness.light
                          ? lightThemeStyle.borderColor
                          : darkThemeStyle.borderColor),
                  color: brightness == Brightness.light
                      ? lightThemeStyle.backgroundColor
                      : darkThemeStyle.backgroundColor),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: brightness == Brightness.light
                          ? lightThemeStyle.contentColor
                          : darkThemeStyle.contentColor,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          color: brightness == Brightness.light
                              ? lightThemeStyle.contentColor
                              : darkThemeStyle.contentColor),
                    )
                  ],
                ),
              )),
          const SizedBox(
            height: 16,
          )
        ]);
  }
}

class CUIToastStyle {
  final Color borderColor;
  final Color backgroundColor;
  final Color contentColor;

  CUIToastStyle(
      {required this.borderColor,
      required this.backgroundColor,
      required this.contentColor});
}
