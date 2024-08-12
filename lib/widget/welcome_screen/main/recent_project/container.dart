part of '../main.dart';

class RecentProjectContainer extends StatefulWidget {
  const RecentProjectContainer({super.key});

  @override
  State<RecentProjectContainer> createState() => _RecentProjectContainerState();
}

class _RecentProjectContainerState extends State<RecentProjectContainer> {
  String searchInput;

  _RecentProjectContainerState() : searchInput = "";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppModel>(
        builder: (context, app) => SizedBox(
              width: 400,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      "Recent Projects",
                      textScaler: TextScaler.linear(1.5),
                    ),
                  ),
                  RecentProjectSearchBar(onChanged: (value) {
                    setState(() {
                      searchInput = value;
                    });
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  ProjectList(searchInput.isNotEmpty
                      ? app.recentProjects
                          .where((project) => project.projectName
                              .toLowerCase()
                              .contains(searchInput.toLowerCase()))
                          .toList()
                      : app.recentProjects)
                ],
              ),
            ));
  }
}
