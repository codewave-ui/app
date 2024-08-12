part of '../main.dart';

class ProjectLocationForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> _formKey;

  const ProjectLocationForm(this._formKey, {super.key});

  @override
  State<ProjectLocationForm> createState() => _ProjectLocationFormState();
}

class _ProjectLocationFormState extends State<ProjectLocationForm> {
  late final GlobalKey<FormBuilderState> formKey;

  @override
  void initState() {
    setState(() {
      formKey = widget._formKey;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: CUIFolderPickerField(
              formKey: formKey,
              name: "Project Location",
              validators: FormBuilderValidators.required(
                  errorText: "Project location is required!"),
            ))
      ],
    );
  }
}
