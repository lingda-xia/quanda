// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['address'] as String,
      json['street'] as String,
      json['country'] as String,
      json['province'] as String,
      json['city'] as String,
      json['district'] as String,
      (json['latitude'] as num).toDouble(),
      (json['longitude'] as num).toDouble(),
      json['adCode'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address': instance.address,
      'street': instance.street,
      'country': instance.country,
      'province': instance.province,
      'city': instance.city,
      'district': instance.district,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'adCode': instance.adCode,
    };
