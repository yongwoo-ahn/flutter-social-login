import 'dart:convert';

import 'package:flutter/material.dart';

import '../../flutter_flow/lat_lng.dart';
import '../../flutter_flow/place.dart';

/// SERIALIZATION HELPERS

String dateTimeRangeToString(DateTimeRange dateTimeRange) {
  final startStr = dateTimeRange.start.millisecondsSinceEpoch.toString();
  final endStr = dateTimeRange.end.millisecondsSinceEpoch.toString();
  return '$startStr|$endStr';
}

String placeToString(FFPlace place) => jsonEncode({
      'latLng': place.latLng.serialize(),
      'name': place.name,
      'address': place.address,
      'city': place.city,
      'state': place.state,
      'country': place.country,
      'zipCode': place.zipCode,
    });

String? serializeParam(dynamic param, ParamType paramType) {
  try {
    if (param == null) {
      return null;
    }
    switch (paramType) {
      case ParamType.int:
        return param.toString();
      case ParamType.double:
        return param.toString();
      case ParamType.string:
        return param;
      case ParamType.bool:
        return param ? 'true' : 'false';
      case ParamType.dateTime:
        return (param as DateTime).millisecondsSinceEpoch.toString();
      case ParamType.dateTimeRange:
        return dateTimeRangeToString(param as DateTimeRange);
      case ParamType.latLng:
        return (param as LatLng).serialize();
      case ParamType.fFPlace:
        return placeToString(param as FFPlace);
      case ParamType.json:
        return json.encode(param);

      default:
        return null;
    }
  } catch (e) {
    debugPrint('Error serializing parameter: $e');
    return null;
  }
}

/// END SERIALIZATION HELPERS

/// DESERIALIZATION HELPERS

DateTimeRange? dateTimeRangeFromString(String dateTimeRangeStr) {
  final pieces = dateTimeRangeStr.split('|');
  if (pieces.length != 2) {
    return null;
  }
  return DateTimeRange(
    start: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.first)),
    end: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.last)),
  );
}

LatLng? latLngFromString(String latLngStr) {
  final pieces = latLngStr.split(',');
  if (pieces.length != 2) {
    return null;
  }
  return LatLng(
    double.parse(pieces.first.trim()),
    double.parse(pieces.last.trim()),
  );
}

FFPlace placeFromString(String placeStr) {
  final serializedData = jsonDecode(placeStr) as Map<String, dynamic>;
  final data = {
    'latLng': serializedData.containsKey('latLng')
        ? latLngFromString(serializedData['latLng'] as String)
        : const LatLng(0.0, 0.0),
    'name': serializedData['name'] ?? '',
    'address': serializedData['address'] ?? '',
    'city': serializedData['city'] ?? '',
    'state': serializedData['state'] ?? '',
    'country': serializedData['country'] ?? '',
    'zipCode': serializedData['zipCode'] ?? '',
  };
  return FFPlace(
    latLng: data['latLng'] as LatLng,
    name: data['name'] as String,
    address: data['address'] as String,
    city: data['city'] as String,
    state: data['state'] as String,
    country: data['country'] as String,
    zipCode: data['zipCode'] as String,
  );
}

enum ParamType {
  int,
  double,
  string,
  bool,
  dateTime,
  dateTimeRange,
  latLng,
  fFPlace,
  json,
}

dynamic deserializeParam(
  String? param,
  ParamType paramType,
) {
  try {
    if (param == null) {
      return null;
    }
    switch (paramType) {
      case ParamType.int:
        return int.tryParse(param);
      case ParamType.double:
        return double.tryParse(param);
      case ParamType.string:
        return param;
      case ParamType.bool:
        return param == 'true';
      case ParamType.dateTime:
        final milliseconds = int.tryParse(param);
        return milliseconds != null
            ? DateTime.fromMillisecondsSinceEpoch(milliseconds)
            : null;
      case ParamType.dateTimeRange:
        return dateTimeRangeFromString(param);
      case ParamType.latLng:
        return latLngFromString(param);
      case ParamType.fFPlace:
        return placeFromString(param);
      case ParamType.json:
        return json.decode(param);

      default:
        return null;
    }
  } catch (e) {
    debugPrint('Error deserializing parameter: $e');
    return null;
  }
}
