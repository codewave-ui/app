import 'package:codewave_ui/util/cui_color.dart';
import 'package:flutter/material.dart';

enum Variant { elevated, outlined, text, contained }

sealed class CUIButtonColor {
  const CUIButtonColor();

  Color getColor(BuildContext context, {Variant? variant});

  Color getContrastColor(BuildContext context, {Variant? variant});
}

class CUIButtonColorSuccess extends CUIButtonColor {
  const CUIButtonColorSuccess();

  @override
  Color getColor(BuildContext context, {Variant? variant}) {
    Brightness brightness = Theme.of(context).brightness;
    if (brightness == Brightness.light) {
      return CUIColors.successLight;
    } else {
      if (variant != null && variant == Variant.contained) {
        return CUIColors.successDark;
      }
      return CUIColors.successLight;
    }
  }

  @override
  Color getContrastColor(BuildContext context, {Variant? variant}) {
    return Colors.white;
  }
}

class CUIButtonColorError extends CUIButtonColor {
  const CUIButtonColorError();

  @override
  Color getColor(BuildContext context, {Variant? variant}) {
    if (variant != null && variant == Variant.contained) {
      return Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).colorScheme.error
          : CUIColors.errorDark;
    }
    return Theme.of(context).colorScheme.error;
  }

  @override
  Color getContrastColor(BuildContext context, {Variant? variant}) {
    return Colors.white;
  }
}

class CUIButton extends StatelessWidget {
  final IconData? startIcon;
  final IconData? endIcon;
  final bool? dense;
  final CUIButtonColor? color;
  final String text;
  final VoidCallback onPressed;
  final Variant variant;
  final bool? enabled;

  const CUIButton(
      {super.key,
      this.startIcon,
      this.endIcon,
      this.dense,
      this.color,
      this.enabled,
      required this.text,
      required this.onPressed,
      required this.variant});

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case Variant.elevated:
        return ElevatedButton(
          onPressed: enabled != null && enabled == false ? null : onPressed,
          style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
              foregroundColor: enabled == null || enabled == true
                  ? WidgetStatePropertyAll(color?.getColor(context))
                  : null,
              shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10))))),
          child: Row(
            children: [
              ...(startIcon != null
                  ? [
                      Icon(
                        startIcon,
                        size: 16,
                      ),
                    ]
                  : []),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(text),
              ),
              ...(endIcon != null
                  ? [
                      Icon(
                        endIcon,
                        size: 16,
                      ),
                    ]
                  : []),
            ],
          ),
        );
      case Variant.outlined:
        return OutlinedButton(
          onPressed: enabled != null && enabled == false ? null : onPressed,
          style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
              foregroundColor: enabled == null || enabled == true
                  ? WidgetStatePropertyAll(color?.getColor(context))
                  : null,
              side: color != null
                  ? WidgetStatePropertyAll(
                      BorderSide(color: color!.getColor(context)))
                  : null,
              shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10))))),
          child: Row(
            children: [
              ...(startIcon != null
                  ? [
                      Icon(
                        startIcon,
                        size: 16,
                      ),
                    ]
                  : []),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(text),
              ),
              ...(endIcon != null
                  ? [
                      Icon(
                        endIcon,
                        size: 16,
                      ),
                    ]
                  : []),
            ],
          ),
        );
      case Variant.text:
        return TextButton(
          onPressed: enabled != null && enabled == false ? null : onPressed,
          style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
              foregroundColor: enabled == null || enabled == true
                  ? WidgetStatePropertyAll(color?.getColor(context))
                  : null,
              shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10))))),
          child: Row(
            children: [
              ...(startIcon != null
                  ? [
                      Icon(
                        startIcon,
                        size: 16,
                      ),
                    ]
                  : []),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(text),
              ),
              ...(endIcon != null
                  ? [
                      Icon(
                        endIcon,
                        size: 16,
                      ),
                    ]
                  : []),
            ],
          ),
        );
      case Variant.contained:
        return ElevatedButton(
          onPressed: enabled != null && enabled == false ? null : onPressed,
          style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16)),
              foregroundColor: enabled == null || enabled == true
                  ? WidgetStatePropertyAll(color?.getContrastColor(context))
                  : null,
              backgroundColor: enabled == null || enabled == true
                  ? WidgetStatePropertyAll(
                      color?.getColor(context, variant: variant))
                  : null,
              shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10))))),
          child: Row(
            children: [
              ...(startIcon != null
                  ? [
                      Icon(
                        startIcon,
                        size: 16,
                      ),
                    ]
                  : []),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(text),
              ),
              ...(endIcon != null
                  ? [
                      Icon(
                        endIcon,
                        size: 16,
                      ),
                    ]
                  : []),
            ],
          ),
        );
    }
  }
}
