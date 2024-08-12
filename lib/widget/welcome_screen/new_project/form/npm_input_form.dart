part of '../main.dart';

class NPMInputForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> _formKey;

  const NPMInputForm(this._formKey, {super.key});

  @override
  State<StatefulWidget> createState() => _NPMInputFieldState();
}

class _NPMInputFieldState extends State<NPMInputForm> {
  late GlobalKey<FormBuilderState> formKey;
  String? npmPath;

  @override
  void initState() {
    setState(() {
      formKey = widget._formKey;
    });

    CUICommandLineInterface.findNpmPath().then((path) {
      if (path != null) {
        CUICommandLineInterface.findNpmVersion(path).then((version) {
          if (version != null) {
            // formKey.currentState.registerField("NPM Path", FormBuilderFieldState());
            formKey.currentState?.fields["NPM"]?.didChange(version);
            formKey.currentState?.fields["NPM Path"]?.didChange(path);
          }
          setState(() {
            npmPath = path;
          });
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CUIHiddenTextInputField(
          formKey: formKey,
          name: "NPM Path",
        ),
        Expanded(
            flex: 1,
            child: CUIFilePickerField(
              formKey: formKey,
              name: "NPM",
              validators: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                CUIFormValidator.minVersion(major: 8, minor: 6, patch: 0)
              ]),
              readOnly: true,
              autoUpdatePickerWithFieldValue: false,
              onFileChange: (result) async {
                if (result != null) {
                  String? path = result.files.first.path;
                  if (path != null) {
                    String? npmVersion =
                        await CUICommandLineInterface.findNpmVersion(path);
                    if (npmVersion != null) {
                      setState(() {
                        npmPath = path;
                        formKey.currentState?.fields["NPM"]
                            ?.didChange(npmVersion);
                        formKey.currentState?.fields["NPM Path"]
                            ?.didChange(path);
                      });
                    }
                  }
                }
              },
              pickerConfig: CUIFilePickerConfig(
                  dialogTitle: "NPM Executable",
                  type: FileType.custom,
                  allowedExtensions: [
                    CUIConstant.getConstantValue().npmExecutableFileExtensions
                  ]),
              decoration: InputDecoration(
                helperText: npmPath,
                suffixText: "Browse NPM Executable",
              ),
            ))
      ],
    );
  }
}
