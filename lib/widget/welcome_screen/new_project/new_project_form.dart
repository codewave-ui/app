part of 'main.dart';

class NewProjectForm extends StatefulWidget {
  const NewProjectForm({super.key});

  @override
  State<NewProjectForm> createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  _NewProjectFormState();

  @override
  Widget build(BuildContext context) {
    return CUIForm(
      submitButton: CUISubmitButton(
        submitText: "Create Project",
        onSubmit: (value) {
          SmartDialog.showLoading(msg: "Creating project...");
          CUIProjectManager.generateNewProject(
                  projectName: value["Project Name"],
                  projectPath: value["Project Location"] +
                      Platform.pathSeparator +
                      value["Project Name"],
                  nodePath: value["NodeJS Path"],
                  npmPath: value["NPM Path"])
              .then((value) {
            windowManager.maximize().then((value) {
              Navigator.of(context, rootNavigator: true)
                  .pushReplacementNamed('/project');
            });
          }).whenComplete(() {
            SmartDialog.dismiss(status: SmartStatus.loading);
          });
          return Future.value();
        },
        formKey: _formKey,
      ),
      formKey: _formKey,
      children: [
        NameAndLocationInputForm(_formKey),
        const FormVerticalSpace(),
        NPMInputForm(_formKey),
        const FormVerticalSpace(),
        NodeInputForm(_formKey),
      ],
    );
  }
}
