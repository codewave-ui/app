part of '../main.dart';

class NameAndLocationInputForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> _formKey;

  const NameAndLocationInputForm(this._formKey, {super.key});

  @override
  State<NameAndLocationInputForm> createState() =>
      _NameAndLocationInputFormState();
}

class _NameAndLocationInputFormState extends State<NameAndLocationInputForm> {
  late final GlobalKey<FormBuilderState> formKey;
  String finalPath = "";

  @override
  void initState() {
    setState(() {
      formKey = widget._formKey;
    });
    getApplicationDocumentsDirectory().then((dir) {
      setState(() {
        finalPath = "${dir.path}${Platform.pathSeparator}Untitled";
        formKey.currentState?.fields["Project Location"]?.didChange(dir.path);
      });
    }, onError: (err) {
      SmartDialog.showNotify(msg: err.toString(), notifyType: NotifyType.error);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: CUITextInputField(
              formKey: formKey,
              initialValue: 'Untitled',
              name: "Project Name",
              validators: FormBuilderValidators.required(
                  errorText: "Project name is required!"),
              onChanged: (value) {
                setState(() {
                  finalPath =
                      formKey.currentState?.fields["Project Location"]?.value +
                          Platform.pathSeparator +
                          (value ?? "");
                });
              },
            )),
        const FormHorizontalSpace(),
        Expanded(
            flex: 2,
            child: CUIFolderPickerField(
                formKey: formKey,
                name: "Project Location",
                validators: FormBuilderValidators.required(
                    errorText: "Project location is required!"),
                onChanged: (value) {
                  setState(() {
                    finalPath = (value ?? "") +
                        Platform.pathSeparator +
                        formKey.currentState?.fields["Project Name"]?.value;
                  });
                },
                decoration: InputDecoration(
                    helperText: "Project will be created on $finalPath"),
                onDirPathChange: (String? path) async {
                  if (path != null) {
                    setState(() {
                      finalPath = path +
                          Platform.pathSeparator +
                          formKey.currentState?.fields["Project Name"]?.value;
                    });
                  }
                }))
      ],
    );
  }
}
