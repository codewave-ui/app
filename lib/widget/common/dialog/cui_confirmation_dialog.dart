import 'package:codewave_ui/util/cui_logger.dart';
import 'package:codewave_ui/widget/common/cui_button.dart';
import 'package:codewave_ui/widget/common/cui_spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum CUIDialogType { confirmation, alert, custom }

enum CUIConfirmationDialogType { info, warning }

class CUIDialog extends StatelessWidget {
  final CUIDialogConfig config;

  const CUIDialog({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Widget innerWidget;
    switch (config.type) {
      case CUIDialogType.confirmation:
        CUIConfirmationDialogConfig confimationDialogConfig =
            config as CUIConfirmationDialogConfig;
        innerWidget = CUIConfirmationDialog(config: confimationDialogConfig);
      case CUIDialogType.alert:
        // TODO: Handle this case.
        innerWidget = Placeholder();
      case CUIDialogType.custom:
        CUICustomDialogConfig customDialogConfig =
            config as CUICustomDialogConfig;
        innerWidget = CUICustomDialog(config: customDialogConfig);
    }
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.surfaceBright),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: config.heightPercentage != null
              ? screenSize.height * (config.heightPercentage ?? 1)
              : ((config.height ?? screenSize.height) * 1.0),
          maxWidth: config.widthPercentage != null
              ? screenSize.width * (config.widthPercentage ?? 1)
              : ((config.width ?? screenSize.width) * 1.0),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: innerWidget),
      ),
    );
  }
}

class CUICustomDialog extends StatelessWidget {
  final CUICustomDialogConfig config;

  const CUICustomDialog({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return config.content;
  }
}

class CUIConfirmationDialog extends StatelessWidget {
  final CUIConfirmationDialogConfig config;

  const CUIConfirmationDialog({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Row(
              children: [
                Icon(config.confirmationDialogType ==
                        CUIConfirmationDialogType.warning
                    ? Icons.warning_amber_rounded
                    : Icons.info_outline_rounded),
                const CUIHorizontalSpacer(2),
                Text(
                  config.title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  textScaler: const TextScaler.linear(1.25),
                )
              ],
            )),
        Divider(
          thickness: 2,
          color: Theme.of(context).colorScheme.inverseSurface,
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child:
              config.content is String ? Text(config.content) : config.content,
        )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Negative Action
            CUIButton(
                text: config.negativeAction.actionText,
                onPressed: config.negativeAction.onClick ??
                    () {
                      CUILogger.warn(
                          "Empty callback detected! [CUIConfirmationDialog - Negative Action]");
                    },
                variant: Variant.outlined,
                color: const CUIButtonColorError()),
            const CUIHorizontalSpacer(2),
            // Positive Action
            CUIButton(
                text: config.positiveAction.actionText,
                onPressed: config.positiveAction.onClick ??
                    () {
                      CUILogger.warn(
                          "Empty callback detected! [CUIConfirmationDialog - Positive Action]");
                    },
                variant: Variant.contained,
                color: const CUIButtonColorSuccess()),
          ],
        )
      ],
    );
  }
}

sealed class CUIDialogConfig {
  final int? width;
  final int? height;
  final double? widthPercentage;
  final double? heightPercentage;
  final CUIDialogType type;

  const CUIDialogConfig(
      {required this.type,
      this.width,
      this.height,
      this.widthPercentage,
      this.heightPercentage});
}

class CUIConfirmationDialogConfig extends CUIDialogConfig {
  final String title;
  final CUIConfirmationDialogType confirmationDialogType;
  final CUIConfirmationDialogPositiveAction positiveAction;
  final CUIConfirmationDialogNegativeAction negativeAction;
  final dynamic content;

  const CUIConfirmationDialogConfig._(
      {required this.title,
      this.confirmationDialogType = CUIConfirmationDialogType.info,
      required this.positiveAction,
      required this.negativeAction,
      required this.content,
      super.width,
      super.widthPercentage,
      super.height,
      super.heightPercentage})
      : super(type: CUIDialogType.confirmation);

  factory CUIConfirmationDialogConfig({
    required String title,
    CUIConfirmationDialogType confirmationDialogType =
        CUIConfirmationDialogType.info,
    required CUIConfirmationDialogPositiveAction positiveAction,
    required CUIConfirmationDialogNegativeAction negativeAction,
    required dynamic content,
    int? width,
    int? height,
    double? widthPercentage,
    double? heightPercentage,
  }) {
    return CUIConfirmationDialogConfig._(
        title: title,
        content: content,
        negativeAction: negativeAction,
        positiveAction: positiveAction,
        confirmationDialogType: confirmationDialogType,
        height: height,
        width: width,
        widthPercentage: widthPercentage,
        heightPercentage: heightPercentage);
  }
}

class CUICustomDialogConfig extends CUIDialogConfig {
  final Widget content;

  const CUICustomDialogConfig({
    super.width,
    super.widthPercentage,
    super.height,
    required this.content,
    super.heightPercentage,
  }) : super(type: CUIDialogType.custom);
}

sealed class CUIConfirmationDialogAction {
  void Function()? onClick;
  final String actionText;

  CUIConfirmationDialogAction({this.onClick, required this.actionText});
}

class CUIConfirmationDialogPositiveAction extends CUIConfirmationDialogAction {
  CUIConfirmationDialogPositiveAction(
      {super.actionText = "OK", required super.onClick});
}

class CUIConfirmationDialogNegativeAction extends CUIConfirmationDialogAction {
  CUIConfirmationDialogNegativeAction(
      {super.actionText = "Cancel", super.onClick}) {
    onClick = onClick ??
        () {
          SmartDialog.dismiss(status: SmartStatus.dialog);
        };
  }
}
