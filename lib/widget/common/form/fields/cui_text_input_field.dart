part of '../cui_form.dart';

class CUITextInputField extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String name;
  final FormFieldValidator<String>? validators;
  final void Function(String?)? onChanged;
  final String? initialValue;
  final InputDecoration? decoration;
  final bool readOnly;
  final bool? enabled;

  const CUITextInputField(
      {super.key,
      required this.formKey,
      this.readOnly = false,
      required this.name,
      this.validators,
      this.onChanged,
      this.initialValue,
      this.decoration,
      this.enabled});

  @override
  State<CUITextInputField> createState() => _CUITextInputFieldState();
}

class _CUITextInputFieldState extends State<CUITextInputField> {
  @override
  Widget build(BuildContext context) {
    InputDecoration defaultDecoration = InputDecoration(
      labelText: widget.name,
      border: const OutlineInputBorder(),
      prefixIcon:
          (widget.decoration != null && widget.decoration?.prefix != null) ||
                  widget.validators == null
              ? null
              : (widget.formKey.currentState?.fields[widget.name]?.hasError ??
                      false)
                  ? const Icon(Icons.error, color: Colors.red)
                  : const Icon(Icons.check, color: Colors.green),
    );
    return Focus(
      child: FormBuilderTextField(
          name: widget.name,
          validator: widget.validators,
          onChanged: widget.onChanged,
          enabled: widget.enabled ?? true,
          initialValue: widget.initialValue,
          readOnly: widget.readOnly,
          decoration: widget.decoration != null
              ? defaultDecoration.merge(widget.decoration)
              : defaultDecoration),
      onFocusChange: (focus) {
        if (focus) setState(() {});
      },
    );
  }
}
