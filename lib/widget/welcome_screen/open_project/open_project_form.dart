part of 'main.dart';

class OpenProjectForm extends StatefulWidget {
  const OpenProjectForm({super.key});

  @override
  State<OpenProjectForm> createState() => _OpenProjectFormState();
}

class _OpenProjectFormState extends State<OpenProjectForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  _OpenProjectFormState();

  @override
  Widget build(BuildContext context) {
    return CUIForm(
      submitButton: CUISubmitButton(
        submitText: "Open Project",
        onSubmit: (value) {
          SmartDialog.showLoading(msg: "Opening project...");
          CUIProjectManager.isProjectValid(value["Project Location"])
              .then((result) {
            if (result) {
              if (context.mounted) {
                context.read<AppCubit>().openProject(value["Project Location"]);
                windowManager.maximize().then((value) {
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacementNamed('/project');
                });
              }
            } else {
              SmartDialog.showNotify(
                  msg: "Project is not valid!", notifyType: NotifyType.error);
            }
          }).whenComplete(() {
            SmartDialog.dismiss(status: SmartStatus.loading);
          });
          return Future.value();
        },
        formKey: _formKey,
      ),
      formKey: _formKey,
      children: [
        ProjectLocationForm(_formKey),
        // const FormVerticalSpace(),
        // NPMInputForm(_formKey),
        // const FormVerticalSpace(),
        // NodeInputForm(_formKey),
      ],
    );
  }
}
