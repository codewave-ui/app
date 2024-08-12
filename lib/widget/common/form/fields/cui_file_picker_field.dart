part of '../cui_form.dart';

class CUIFilePickerField extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String name;
  final FormFieldValidator<String>? validators;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final InputDecoration? decoration;
  final Future<void> Function(FilePickerResult?)? onFileChange;
  final CUIFilePickerConfig pickerConfig;
  final bool autoUpdatePickerWithFieldValue;
  final bool autoUpdateValueWhenNull;
  final bool readOnly;
  final bool enabled;

  const CUIFilePickerField(
      {super.key,
      required this.name,
      this.validators,
      this.onChanged,
      required this.formKey,
      this.initialValue,
      this.decoration,
      this.onFileChange,
      this.pickerConfig = const CUIFilePickerConfig(),
      this.readOnly = false,
      this.enabled = true,
      this.autoUpdatePickerWithFieldValue = true,
      this.autoUpdateValueWhenNull = false});

  @override
  State<CUIFilePickerField> createState() => _CUIFilePickerFieldState();
}

class _CUIFilePickerFieldState extends State<CUIFilePickerField> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    InputDecoration defaultDecoration = InputDecoration(
        prefix: loading
            ? const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(),
                  ),
                  CUIHorizontalSpacer(1)
                ],
              )
            : null,
        suffixIcon: InkWell(
          onTap: () async {
            setState(() {
              loading = true;
            });
            FilePickerResult? result = await FilePicker.platform.pickFiles(
                lockParentWindow: widget.pickerConfig.lockParentWindow,
                dialogTitle: widget.pickerConfig.dialogTitle,
                type: widget.pickerConfig.type,
                allowedExtensions: widget.pickerConfig.allowedExtensions,
                allowMultiple: widget.pickerConfig.allowMultiple);

            if (widget.autoUpdatePickerWithFieldValue) {
              if (widget.autoUpdateValueWhenNull || result != null) {
                widget.formKey.currentState?.fields[widget.name]
                    ?.didChange(result?.files.first.path);
              }
            }
            if (widget.onFileChange != null) {
              await widget.onFileChange!(result);
            }
            setState(() {
              loading = false;
            });
          },
          child: const Icon(Icons.folder_open_rounded),
        ));
    return CUITextInputField(
        formKey: widget.formKey,
        name: widget.name,
        validators: widget.validators,
        onChanged: widget.onChanged,
        initialValue: widget.initialValue,
        readOnly: widget.readOnly,
        enabled: widget.enabled && !loading,
        decoration: widget.decoration != null
            ? defaultDecoration.merge(widget.decoration)
            : defaultDecoration);
  }
}
