part of '../cui_form.dart';

class CuiCheckboxField extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String name;
  final FormFieldValidator<bool>? validators;
  final void Function(bool?)? onChanged;
  final bool? initialValue;
  final Widget? label;
  final bool? enabled;

  const CuiCheckboxField(
      {super.key,
      required this.formKey,
      required this.name,
      this.validators,
      this.onChanged,
      this.initialValue,
      this.label,
      this.enabled});

  @override
  State<CuiCheckboxField> createState() => _CuiCheckboxFieldState();
}

class _CuiCheckboxFieldState extends State<CuiCheckboxField> {
  @override
  void didUpdateWidget(covariant CuiCheckboxField oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.name + " " + widget.initialValue.toString());

    return FormBuilderCheckbox(
      name: widget.name,
      title: widget.label != null ? widget.label! : Text(widget.name),
      validator: widget.validators,
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      enabled: widget.enabled ?? true,
    );
  }
}
