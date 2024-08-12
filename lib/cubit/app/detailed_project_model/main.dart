import 'package:json_annotation/json_annotation.dart';

part 'main.g.dart';

@JsonSerializable(explicitToJson: true)
class DetailedProjectModel {
  @JsonKey(required: true)
  String projectName;

  @JsonKey(required: true)
  String projectLocationPath;

  DetailedProjectModel(this.projectName, this.projectLocationPath);

  factory DetailedProjectModel.fromJson(Map<String, dynamic> json) =>
      _$DetailedProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailedProjectModelToJson(this);
}
