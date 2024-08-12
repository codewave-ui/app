part of 'cui_form.dart';

class CUISubmitButton extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final Future<void> Function(Map<String, dynamic>) onSubmit;
  final String? submitText;
  final bool? enabled;

  const CUISubmitButton(
      {super.key,
      required this.onSubmit,
      this.submitText,
      required this.formKey,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return CUIButton(
        text: submitText ?? "Submit",
        onPressed: () async {
          if (formKey.currentState!.saveAndValidate(
              focusOnInvalid: true, autoScrollWhenFocusOnInvalid: true)) {
            await onSubmit(formKey.currentState!.value);
          }
        },
        enabled: enabled,
        variant: Variant.contained,
        color: const CUIButtonColorSuccess());
  }
}
