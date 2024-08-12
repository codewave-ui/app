part of '../main.dart';

class ProjectList extends StatelessWidget {
  final List<SimpleProjectModel> recentProjects;

  const ProjectList(this.recentProjects, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: recentProjects.isNotEmpty
            ? ListView.builder(
                clipBehavior: Clip.antiAlias,
                padding: const EdgeInsets.all(8),
                itemCount: recentProjects.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 0.3, color: Colors.grey))),
                    child: ListTile(
                      trailing: IconButton(
                          onPressed: () {
                            context.read<AppCubit>().deleteProject(index);
                          },
                          icon: const Icon(Icons.close)),
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 2),
                      subtitle: Text(recentProjects[index].projectLocationPath),
                      onTap: () {
                        context.read<AppCubit>().openProject(
                            recentProjects[index].projectLocationPath);
                        windowManager.maximize().then((value) {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacementNamed('/project');
                        });
                      },
                      title: Text(recentProjects[index].projectName),
                    ),
                  );
                })
            : const EmptyOverlay());
  }
}
