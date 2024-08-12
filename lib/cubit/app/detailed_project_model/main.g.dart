// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailedProjectModel _$DetailedProjectModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['projectName', 'projectLocationPath'],
  );
  return DetailedProjectModel(
    json['projectName'] as String,
    json['projectLocationPath'] as String,
  );
}

Map<String, dynamic> _$DetailedProjectModelToJson(
        DetailedProjectModel instance) =>
    <String, dynamic>{
      'projectName': instance.projectName,
      'projectLocationPath': instance.projectLocationPath,
    };
