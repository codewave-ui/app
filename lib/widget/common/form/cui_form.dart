import 'package:codewave_ui/widget/common/cui_button.dart';
import 'package:codewave_ui/widget/common/cui_spacer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

part 'cui_submit_button.dart';
part 'fields/cui_checkbox_field.dart';
part 'fields/cui_file_picker_field.dart';
part 'fields/cui_folder_picker_field.dart';
part 'fields/cui_hidden_text_input_field.dart';
part 'fields/cui_text_input_field.dart';

sealed class CUIBasePickerConfig {
  final String? dialogTitle;
  final bool lockParentWindow;

  const CUIBasePickerConfig({this.dialogTitle, this.lockParentWindow = true});
}

class CUIFilePickerConfig extends CUIBasePickerConfig {
  final FileType type;
  final List<String>? allowedExtensions;
  final bool allowMultiple;

  const CUIFilePickerConfig(
      {this.type = FileType.any,
      this.allowedExtensions,
      this.allowMultiple = false,
      super.dialogTitle = "File Picker",
      super.lockParentWindow = true});
}

class CUIFolderPickerConfig extends CUIBasePickerConfig {
  final String? initialDirectory;

  const CUIFolderPickerConfig(
      {this.initialDirectory,
      super.dialogTitle = "Folder Picker",
      super.lockParentWindow = true});
}

class CUIForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<Widget> children;
  final CUISubmitButton submitButton;
  final List<Widget>? siblingButtonFromSubmit;
  final bool Function()? overwriteIsValidCheck;

  const CUIForm(
      {super.key,
      required this.formKey,
      required this.children,
      required this.submitButton,
      this.siblingButtonFromSubmit,
      this.overwriteIsValidCheck});

  @override
  State<CUIForm> createState() => _CUIFormState();
}

class _CUIFormState extends State<CUIForm> {
  late GlobalKey<FormBuilderState> formKey;
  bool isValid = false;

  @override
  void initState() {
    formKey = widget.formKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> finalSiblingFromSubmitButton = [];
    if (widget.siblingButtonFromSubmit != null) {
      for (var widget in widget.siblingButtonFromSubmit!) {
        if (finalSiblingFromSubmitButton.isNotEmpty) {
          finalSiblingFromSubmitButton.add(const CUIHorizontalSpacer(2));
        }
        finalSiblingFromSubmitButton.add(widget);
      }
      if (finalSiblingFromSubmitButton.isNotEmpty) {
        finalSiblingFromSubmitButton.add(const CUIHorizontalSpacer(2));
      }
    }
    return FormBuilder(
        key: formKey,
        onChanged: () {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            setState(() {
              if (widget.overwriteIsValidCheck != null) {
                isValid = widget.overwriteIsValidCheck!();
              } else {
                isValid = formKey.currentState!.isValid;
              }
            });
          });
        },
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            ...widget.children,
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...(finalSiblingFromSubmitButton),
                CUISubmitButton(
                  onSubmit: widget.submitButton.onSubmit,
                  formKey: formKey,
                  submitText: widget.submitButton.submitText,
                  enabled: isValid && widget.submitButton.enabled == true,
                )
              ],
            ))
          ],
        ));
  }
}

class FormHorizontalSpace extends StatelessWidget {
  const FormHorizontalSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return const CUIHorizontalSpacer(2.5);
  }
}

class FormVerticalSpace extends StatelessWidget {
  const FormVerticalSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return const CUIVerticalSpacer(2.5);
  }
}

extension InputDecorationExtension on InputDecoration {
  InputDecoration merge(InputDecoration? other) {
    return InputDecoration(
      icon: other?.icon ?? icon,
      labelText: other?.labelText ?? labelText,
      labelStyle: other?.labelStyle ?? labelStyle,
      helperText: other?.helperText ?? helperText,
      helperStyle: other?.helperStyle ?? helperStyle,
      hintText: other?.hintText ?? hintText,
      hintStyle: other?.hintStyle ?? hintStyle,
      hintMaxLines: other?.hintMaxLines ?? hintMaxLines,
      errorText: other?.errorText ?? errorText,
      errorStyle: other?.errorStyle ?? errorStyle,
      errorMaxLines: other?.errorMaxLines ?? errorMaxLines,
      floatingLabelBehavior:
          other?.floatingLabelBehavior ?? floatingLabelBehavior,
      isCollapsed: other?.isCollapsed ?? isCollapsed,
      isDense: other?.isDense ?? isDense,
      contentPadding: other?.contentPadding ?? contentPadding,
      prefixIcon: other?.prefixIcon ?? prefixIcon,
      prefix: other?.prefix ?? prefix,
      prefixText: other?.prefixText ?? prefixText,
      prefixStyle: other?.prefixStyle ?? prefixStyle,
      suffixIcon: other?.suffixIcon ?? suffixIcon,
      suffix: other?.suffix ?? suffix,
      suffixText: other?.suffixText ?? suffixText,
      suffixStyle: other?.suffixStyle ?? suffixStyle,
      counter: other?.counter ?? counter,
      counterText: other?.counterText ?? counterText,
      counterStyle: other?.counterStyle ?? counterStyle,
      filled: other?.filled ?? filled,
      fillColor: other?.fillColor ?? fillColor,
      focusColor: other?.focusColor ?? focusColor,
      hoverColor: other?.hoverColor ?? hoverColor,
      errorBorder: other?.errorBorder ?? errorBorder,
      focusedBorder: other?.focusedBorder ?? focusedBorder,
      focusedErrorBorder: other?.focusedErrorBorder ?? focusedErrorBorder,
      disabledBorder: other?.disabledBorder ?? disabledBorder,
      enabledBorder: other?.enabledBorder ?? enabledBorder,
      border: other?.border ?? border,
      enabled: other?.enabled ?? enabled,
      semanticCounterText: other?.semanticCounterText ?? semanticCounterText,
      alignLabelWithHint: other?.alignLabelWithHint ?? alignLabelWithHint,
    );
  }
}
