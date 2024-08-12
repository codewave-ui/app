// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppModel _$AppModelFromJson(Map<String, dynamic> json) => AppModel(
      json['currentProject'] == null
          ? null
          : DetailedProjectModel.fromJson(
              json['currentProject'] as Map<String, dynamic>),
      (json['recentProjects'] as List<dynamic>)
          .map((e) => SimpleProjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppModelToJson(AppModel instance) => <String, dynamic>{
      'currentProject': instance.currentProject?.toJson(),
      'recentProjects': instance.recentProjects.map((e) => e.toJson()).toList(),
    };
