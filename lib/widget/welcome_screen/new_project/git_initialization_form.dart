part of 'main.dart';

class GitInitializationForm extends StatefulWidget {
  final String projectPath;

  const GitInitializationForm({super.key, required this.projectPath});

  @override
  State<GitInitializationForm> createState() => _GitInitializationFormState();
}

class _GitInitializationFormState extends State<GitInitializationForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  late bool existingRepository;

  @override
  void initState() {
    existingRepository = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CUIDialog(
        config: CUICustomDialogConfig(
            widthPercentage: 0.7,
            heightPercentage: 0.6,
            content: CUIForm(
              formKey: _formKey,
              overwriteIsValidCheck: () {
                if (existingRepository) {
                  return _formKey.currentState!.isValid;
                }
                return true;
              },
              siblingButtonFromSubmit: [
                CUIButton(
                    text: "Cancel",
                    onPressed: () {
                      SmartDialog.dismiss(status: SmartStatus.dialog);
                    },
                    variant: Variant.outlined,
                    color: const CUIButtonColorError())
              ],
              submitButton: CUISubmitButton(
                  onSubmit: (gitFormValue) async {
                    await CUICommandLineInterface.initializeProjectWithGit(
                        widget.projectPath, gitFormValue["Git URL"]);
                    await SmartDialog.dismiss(status: SmartStatus.dialog);
                  },
                  formKey: _formKey),
              children: [
                const Text(
                  "Git Integration",
                  textScaler: TextScaler.linear(1.5),
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const Divider(
                  thickness: 2,
                ),
                CuiCheckboxField(
                  formKey: _formKey,
                  name: "Existing Repository",
                  initialValue: existingRepository,
                  onChanged: (value) {
                    if (value != null) {
                      _formKey.currentState?.fields["New Repository (git init)"]
                          ?.didChange(!value);
                      setState(() {
                        existingRepository = value;
                      });
                    }
                  },
                ),
                CUITextInputField(
                  name: "Git URL",
                  validators: existingRepository
                      ? FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          CUIFormValidator.gitUrl()
                        ])
                      : null,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                      helperText:
                          "Example: git@github.com:test-git.git, https://github.com/test-git.git"),
                  formKey: _formKey,
                  enabled: existingRepository,
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Divider(
                      // color: Theme.of(context).colorScheme.inverseSurface,
                      thickness: 2,
                    )),
                CuiCheckboxField(
                  formKey: _formKey,
                  name: "New Repository (git init)",
                  initialValue: !existingRepository,
                  onChanged: (value) {
                    if (value != null) {
                      if (_formKey.currentState?.fields["Existing Repository"]
                              ?.value !=
                          !value) {
                        _formKey.currentState?.fields["Existing Repository"]
                            ?.didChange(!value);
                      }
                      setState(() {
                        existingRepository = !value;
                      });
                    }
                  },
                ),
              ],
            )));
  }
}
