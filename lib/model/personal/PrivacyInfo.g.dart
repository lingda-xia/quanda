// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PrivacyInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacyInfo _$PrivacyInfoFromJson(Map<String, dynamic> json) => PrivacyInfo(
      json['qrcodeStatus'] as int,
      json['nearbyStatus'] as int,
      json['sexStatus'] as int,
      json['ageStatus'] as int,
      json['addressStatus'] as int,
      json['homeShareStatus'] as int,
      json['contentShareStatus'] as int,
      json['searchStatus'] as int,
    );

Map<String, dynamic> _$PrivacyInfoToJson(PrivacyInfo instance) =>
    <String, dynamic>{
      'qrcodeStatus': instance.qrcodeStatus,
      'nearbyStatus': instance.nearbyStatus,
      'sexStatus': instance.sexStatus,
      'ageStatus': instance.ageStatus,
      'addressStatus': instance.addressStatus,
      'homeShareStatus': instance.homeShareStatus,
      'contentShareStatus': instance.contentShareStatus,
      'searchStatus': instance.searchStatus,
    };
