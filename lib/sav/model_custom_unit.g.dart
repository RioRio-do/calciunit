// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_custom_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomUnitImpl _$$CustomUnitImplFromJson(Map<String, dynamic> json) =>
    _$CustomUnitImpl(
      id: json['id'] as String,
      constant: json['constant'] as String,
      abbreviation: json['abbreviation'] as String,
      displayName: json['displayName'] as String,
      unitType: (json['unitType'] as num?)?.toInt() ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$CustomUnitImplToJson(_$CustomUnitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'constant': instance.constant,
      'abbreviation': instance.abbreviation,
      'displayName': instance.displayName,
      'unitType': instance.unitType,
      'isFavorite': instance.isFavorite,
    };

_$CustomUnitsImpl _$$CustomUnitsImplFromJson(Map<String, dynamic> json) =>
    _$CustomUnitsImpl(
      units: (json['units'] as List<dynamic>?)
              ?.map((e) => CustomUnit.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CustomUnitsImplToJson(_$CustomUnitsImpl instance) =>
    <String, dynamic>{
      'units': instance.units,
    };
