import 'package:codewave_ui/cubit/app/detailed_project_model/main.dart';
import 'package:codewave_ui/cubit/app/simple_project_model/main.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AppModel {
  DetailedProjectModel? currentProject;
  List<SimpleProjectModel> recentProjects;

  AppModel(this.currentProject, this.recentProjects);

  factory AppModel.fromJson(Map<String, dynamic> json) =>
      _$AppModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppModelToJson(this);
}
