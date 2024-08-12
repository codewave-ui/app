import 'dart:io';

import 'package:codewave_ui/cubit/app/app_model.dart';
import 'package:codewave_ui/cubit/app/detailed_project_model/main.dart';
import 'package:codewave_ui/cubit/app/simple_project_model/main.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppCubit extends HydratedCubit<AppModel> {
  AppCubit(super.state);

  @override
  AppModel? fromJson(Map<String, dynamic> json) {
    return AppModel.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppModel state) {
    return this.state.toJson();
  }

  void openProject(String path) {
    AppModel newAppModel = AppModel(state.currentProject, state.recentProjects);
    // String finalPath = path.replaceAll("\\", "/");

    for (SimpleProjectModel project in state.recentProjects) {
      if (project.projectLocationPath == path) {
        newAppModel.currentProject = DetailedProjectModel(
            project.projectName, project.projectLocationPath);
        newAppModel.recentProjects.remove(project);
        newAppModel.recentProjects.insert(0, project);
      } else {
        newAppModel.recentProjects.add(project);
      }
    }

    if (newAppModel.currentProject == null) {
      var lastIdx = path.lastIndexOf(Platform.pathSeparator);
      var projectName = path.substring(lastIdx + 1);
      DetailedProjectModel newProject = DetailedProjectModel(projectName, path);
      newAppModel.currentProject = newProject;
      newAppModel.recentProjects
          .insert(0, SimpleProjectModel(projectName, path));
    }

    emit(newAppModel);
  }

  void deleteProject(int index) {
    AppModel newAppModel = AppModel(state.currentProject, state.recentProjects);
    newAppModel.recentProjects.removeAt(index);
    emit(newAppModel);
  }

  void closeProject() {
    AppModel newAppModel = AppModel(null, state.recentProjects);
    emit(newAppModel);
  }
}
