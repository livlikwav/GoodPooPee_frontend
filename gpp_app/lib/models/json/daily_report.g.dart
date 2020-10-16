// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyReport _$DailyReportFromJson(Map<String, dynamic> json) {
  return DailyReport(
    json['date'] as String,
    json['pet_id'] as int,
    json['user_id'] as int,
    json['count'] as int,
    json['success'] as int,
    (json['ratio'] as num)?.toDouble(),
    json['created_date'] as String,
    json['last_modified_date'] as String,
  );
}

Map<String, dynamic> _$DailyReportToJson(DailyReport instance) =>
    <String, dynamic>{
      'date': instance.date,
      'pet_id': instance.petId,
      'user_id': instance.userId,
      'count': instance.count,
      'success': instance.success,
      'ratio': instance.ratio,
      'created_date': instance.createdDate,
      'last_modified_date': instance.lastModifiedDate,
    };
