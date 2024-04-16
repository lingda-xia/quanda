// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) => SearchResult(
      address: json['address'] as String,
      distance: json['distance'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'address': instance.address,
      'distance': instance.distance,
      'city': instance.city,
      'district': instance.district,
      'name': instance.name,
      'location': instance.location,
    };
