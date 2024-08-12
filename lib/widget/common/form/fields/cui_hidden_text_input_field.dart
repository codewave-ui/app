part of '../cui_form.dart';

class CUIHiddenTextInputField extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String name;
  final String? initialValue;

  const CUIHiddenTextInputField(
      {super.key,
      required this.formKey,
      required this.name,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 1,
        height: 1,
        child: Visibility(
          maintainState: true,
          visible: false,
          child: CUITextInputField(
            formKey: formKey,
            name: name,
            initialValue: initialValue,
          ),
        ));
  }
}
