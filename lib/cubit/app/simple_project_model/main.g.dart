// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleProjectModel _$SimpleProjectModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['projectName', 'projectLocationPath'],
  );
  return SimpleProjectModel(
    json['projectName'] as String,
    json['projectLocationPath'] as String,
  );
}

Map<String, dynamic> _$SimpleProjectModelToJson(SimpleProjectModel instance) =>
    <String, dynamic>{
      'projectName': instance.projectName,
      'projectLocationPath': instance.projectLocationPath,
    };
