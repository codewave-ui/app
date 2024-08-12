import 'package:json_annotation/json_annotation.dart';

part 'main.g.dart';

@JsonSerializable()
class SimpleProjectModel {
  @JsonKey(required: true)
  String projectName;

  @JsonKey(required: true)
  String projectLocationPath;

  SimpleProjectModel(this.projectName, this.projectLocationPath);

  factory SimpleProjectModel.fromJson(Map<String, dynamic> json) =>
      _$SimpleProjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleProjectModelToJson(this);
}
