part of '../cui_form.dart';

class CUIFolderPickerField extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String name;
  final String? Function(String?)? validators;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final InputDecoration? decoration;
  final Future<void> Function(String?)? onDirPathChange;
  final CUIFolderPickerConfig pickerConfig;
  final bool autoUpdatePickerWithFieldValue;
  final bool autoUpdateValueWhenNull;
  final bool readOnly;
  final bool enabled;

  const CUIFolderPickerField(
      {super.key,
      required this.name,
      this.validators,
      this.onChanged,
      required this.formKey,
      this.initialValue,
      this.decoration,
      this.onDirPathChange,
      this.pickerConfig = const CUIFolderPickerConfig(),
      this.readOnly = false,
      this.enabled = true,
      this.autoUpdatePickerWithFieldValue = true,
      this.autoUpdateValueWhenNull = false});

  @override
  State<CUIFolderPickerField> createState() => _CUIFolderPickerFieldState();
}

class _CUIFolderPickerFieldState extends State<CUIFolderPickerField> {
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
            String? path = await FilePicker.platform.getDirectoryPath(
                dialogTitle: widget.pickerConfig.dialogTitle,
                lockParentWindow: widget.pickerConfig.lockParentWindow,
                initialDirectory: widget.pickerConfig.initialDirectory);
            if (widget.autoUpdatePickerWithFieldValue) {
              if (widget.autoUpdateValueWhenNull || path != null) {
                widget.formKey.currentState?.fields[widget.name]
                    ?.didChange(path);
              }
            }
            if (widget.onDirPathChange != null) {
              await widget.onDirPathChange!(path);
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
        onChanged: widget.onChanged ?? (_ignored) => setState(() {}),
        initialValue: widget.initialValue,
        readOnly: widget.readOnly,
        enabled: widget.enabled && !loading,
        decoration: widget.decoration != null
            ? defaultDecoration.merge(widget.decoration)
            : defaultDecoration);
  }
}
