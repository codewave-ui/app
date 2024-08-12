part of '../main.dart';

class NodeInputForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> _formKey;

  const NodeInputForm(this._formKey, {super.key});

  @override
  State<StatefulWidget> createState() => _NodeInputFieldState();
}

class _NodeInputFieldState extends State<NodeInputForm> {
  late final GlobalKey<FormBuilderState> formKey;
  String? nodePath;

  @override
  void initState() {
    setState(() {
      formKey = widget._formKey;
    });

    CUICommandLineInterface.findNodePath().then((path) {
      if (path != null) {
        CUICommandLineInterface.findNodeVersion(path).then((version) {
          if (version != null) {
            formKey.currentState?.fields["NodeJS"]?.didChange(version);
            formKey.currentState?.fields["NodeJS Path"]?.didChange(path);
          }
          setState(() {
            nodePath = path;
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
          name: 'NodeJS Path',
        ),
        Expanded(
            flex: 1,
            child: CUIFilePickerField(
              formKey: formKey,
              name: "NodeJS",
              validators: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                CUIFormValidator.minVersion(major: 18, minor: 0, patch: 0)
              ]),
              onChanged: (value) {
                formKey.currentState!.validate();
              },
              readOnly: true,
              autoUpdatePickerWithFieldValue: false,
              onFileChange: (result) async {
                if (result != null) {
                  String? path = result.files.first.path;
                  if (path != null) {
                    String? nodeVersion =
                        await CUICommandLineInterface.findNodeVersion(path);
                    if (nodeVersion != null) {
                      setState(() {
                        nodePath = path;
                        formKey.currentState?.fields["NodeJS"]
                            ?.didChange(nodeVersion);
                        formKey.currentState?.fields["NodeJS Path"]
                            ?.didChange(path);
                      });
                    }
                  }
                }
              },
              pickerConfig: CUIFilePickerConfig(
                  dialogTitle: "NodeJS Executable",
                  type: FileType.custom,
                  allowedExtensions: [
                    CUIConstant.getConstantValue().nodeExecutableFileExtensions
                  ]),
              decoration: InputDecoration(
                helperText: nodePath,
                suffixText: "Browse NodeJS Executable",
              ),
            ))
      ],
    );
  }
}
