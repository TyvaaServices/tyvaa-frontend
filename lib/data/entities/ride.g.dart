// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetRideCollection on Isar {
  IsarCollection<int, Ride> get rides => this.collection();
}

final RideSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Ride',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'remoteId', type: IsarType.string),
      IsarPropertySchema(name: 'villeDepart', type: IsarType.string),
      IsarPropertySchema(name: 'villeArrivee', type: IsarType.string),
      IsarPropertySchema(name: 'distanceKm', type: IsarType.long),
      IsarPropertySchema(name: 'nombrePlaces', type: IsarType.long),
      IsarPropertySchema(name: 'conducteurId', type: IsarType.string),
      IsarPropertySchema(name: 'statut', type: IsarType.string),
      IsarPropertySchema(name: 'dateDepart', type: IsarType.dateTime),
      IsarPropertySchema(name: 'prixTotal', type: IsarType.double),
      IsarPropertySchema(name: 'commission', type: IsarType.double),
      IsarPropertySchema(name: 'gpsStartLat', type: IsarType.double),
      IsarPropertySchema(name: 'gpsStartLong', type: IsarType.double),
      IsarPropertySchema(name: 'gpsStartTime', type: IsarType.dateTime),
      IsarPropertySchema(name: 'gpsEndLat', type: IsarType.double),
      IsarPropertySchema(name: 'gpsEndLong', type: IsarType.double),
      IsarPropertySchema(name: 'gpsEndTime', type: IsarType.dateTime),
      IsarPropertySchema(name: 'routeCatalogId', type: IsarType.string),
      IsarPropertySchema(name: 'driverName', type: IsarType.string),
      IsarPropertySchema(name: 'driverRating', type: IsarType.double),
      IsarPropertySchema(name: 'carModel', type: IsarType.string),
      IsarPropertySchema(name: 'carImage', type: IsarType.string),
      IsarPropertySchema(name: 'isVerified', type: IsarType.bool),
      IsarPropertySchema(name: 'isSanitized', type: IsarType.bool),
      IsarPropertySchema(name: 'createdAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'updatedAt', type: IsarType.dateTime),
    ],
    indexes: [
      IsarIndexSchema(
        name: 'remoteId',
        properties: ["remoteId"],
        unique: true,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'conducteurId',
        properties: ["conducteurId"],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'statut',
        properties: ["statut"],
        unique: false,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, Ride>(
    serialize: serializeRide,
    deserialize: deserializeRide,
    deserializeProperty: deserializeRideProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeRide(IsarWriter writer, Ride object) {
  IsarCore.writeString(writer, 1, object.remoteId);
  IsarCore.writeString(writer, 2, object.villeDepart);
  IsarCore.writeString(writer, 3, object.villeArrivee);
  IsarCore.writeLong(writer, 4, object.distanceKm);
  IsarCore.writeLong(writer, 5, object.nombrePlaces);
  IsarCore.writeString(writer, 6, object.conducteurId);
  IsarCore.writeString(writer, 7, object.statut);
  IsarCore.writeLong(
    writer,
    8,
    object.dateDepart?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  IsarCore.writeDouble(writer, 9, object.prixTotal ?? double.nan);
  IsarCore.writeDouble(writer, 10, object.commission ?? double.nan);
  IsarCore.writeDouble(writer, 11, object.gpsStartLat ?? double.nan);
  IsarCore.writeDouble(writer, 12, object.gpsStartLong ?? double.nan);
  IsarCore.writeLong(
    writer,
    13,
    object.gpsStartTime?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  IsarCore.writeDouble(writer, 14, object.gpsEndLat ?? double.nan);
  IsarCore.writeDouble(writer, 15, object.gpsEndLong ?? double.nan);
  IsarCore.writeLong(
    writer,
    16,
    object.gpsEndTime?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  {
    final value = object.routeCatalogId;
    if (value == null) {
      IsarCore.writeNull(writer, 17);
    } else {
      IsarCore.writeString(writer, 17, value);
    }
  }
  IsarCore.writeString(writer, 18, object.driverName);
  IsarCore.writeDouble(writer, 19, object.driverRating);
  IsarCore.writeString(writer, 20, object.carModel);
  IsarCore.writeString(writer, 21, object.carImage);
  IsarCore.writeBool(writer, 22, value: object.isVerified);
  IsarCore.writeBool(writer, 23, value: object.isSanitized);
  IsarCore.writeLong(
    writer,
    24,
    object.createdAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  IsarCore.writeLong(
    writer,
    25,
    object.updatedAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  return object.id;
}

@isarProtected
Ride deserializeRide(IsarReader reader) {
  final object = Ride();
  object.id = IsarCore.readId(reader);
  object.remoteId = IsarCore.readString(reader, 1) ?? '';
  object.villeDepart = IsarCore.readString(reader, 2) ?? '';
  object.villeArrivee = IsarCore.readString(reader, 3) ?? '';
  object.distanceKm = IsarCore.readLong(reader, 4);
  object.nombrePlaces = IsarCore.readLong(reader, 5);
  object.conducteurId = IsarCore.readString(reader, 6) ?? '';
  object.statut = IsarCore.readString(reader, 7) ?? '';
  {
    final value = IsarCore.readLong(reader, 8);
    if (value == -9223372036854775808) {
      object.dateDepart = null;
    } else {
      object.dateDepart = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  {
    final value = IsarCore.readDouble(reader, 9);
    if (value.isNaN) {
      object.prixTotal = null;
    } else {
      object.prixTotal = value;
    }
  }
  {
    final value = IsarCore.readDouble(reader, 10);
    if (value.isNaN) {
      object.commission = null;
    } else {
      object.commission = value;
    }
  }
  {
    final value = IsarCore.readDouble(reader, 11);
    if (value.isNaN) {
      object.gpsStartLat = null;
    } else {
      object.gpsStartLat = value;
    }
  }
  {
    final value = IsarCore.readDouble(reader, 12);
    if (value.isNaN) {
      object.gpsStartLong = null;
    } else {
      object.gpsStartLong = value;
    }
  }
  {
    final value = IsarCore.readLong(reader, 13);
    if (value == -9223372036854775808) {
      object.gpsStartTime = null;
    } else {
      object.gpsStartTime = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  {
    final value = IsarCore.readDouble(reader, 14);
    if (value.isNaN) {
      object.gpsEndLat = null;
    } else {
      object.gpsEndLat = value;
    }
  }
  {
    final value = IsarCore.readDouble(reader, 15);
    if (value.isNaN) {
      object.gpsEndLong = null;
    } else {
      object.gpsEndLong = value;
    }
  }
  {
    final value = IsarCore.readLong(reader, 16);
    if (value == -9223372036854775808) {
      object.gpsEndTime = null;
    } else {
      object.gpsEndTime = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.routeCatalogId = IsarCore.readString(reader, 17);
  object.driverName = IsarCore.readString(reader, 18) ?? '';
  object.driverRating = IsarCore.readDouble(reader, 19);
  object.carModel = IsarCore.readString(reader, 20) ?? '';
  object.carImage = IsarCore.readString(reader, 21) ?? '';
  object.isVerified = IsarCore.readBool(reader, 22);
  object.isSanitized = IsarCore.readBool(reader, 23);
  {
    final value = IsarCore.readLong(reader, 24);
    if (value == -9223372036854775808) {
      object.createdAt = null;
    } else {
      object.createdAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  {
    final value = IsarCore.readLong(reader, 25);
    if (value == -9223372036854775808) {
      object.updatedAt = null;
    } else {
      object.updatedAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  return object;
}

@isarProtected
dynamic deserializeRideProp(IsarReader reader, int property) {
  switch (property) {
    case 0:
      return IsarCore.readId(reader);
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readLong(reader, 4);
    case 5:
      return IsarCore.readLong(reader, 5);
    case 6:
      return IsarCore.readString(reader, 6) ?? '';
    case 7:
      return IsarCore.readString(reader, 7) ?? '';
    case 8:
      {
        final value = IsarCore.readLong(reader, 8);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 9:
      {
        final value = IsarCore.readDouble(reader, 9);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 10:
      {
        final value = IsarCore.readDouble(reader, 10);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 11:
      {
        final value = IsarCore.readDouble(reader, 11);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 12:
      {
        final value = IsarCore.readDouble(reader, 12);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 13:
      {
        final value = IsarCore.readLong(reader, 13);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 14:
      {
        final value = IsarCore.readDouble(reader, 14);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 15:
      {
        final value = IsarCore.readDouble(reader, 15);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 16:
      {
        final value = IsarCore.readLong(reader, 16);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 17:
      return IsarCore.readString(reader, 17);
    case 18:
      return IsarCore.readString(reader, 18) ?? '';
    case 19:
      return IsarCore.readDouble(reader, 19);
    case 20:
      return IsarCore.readString(reader, 20) ?? '';
    case 21:
      return IsarCore.readString(reader, 21) ?? '';
    case 22:
      return IsarCore.readBool(reader, 22);
    case 23:
      return IsarCore.readBool(reader, 23);
    case 24:
      {
        final value = IsarCore.readLong(reader, 24);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 25:
      {
        final value = IsarCore.readLong(reader, 25);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _RideUpdate {
  bool call({
    required int id,
    String? remoteId,
    String? villeDepart,
    String? villeArrivee,
    int? distanceKm,
    int? nombrePlaces,
    String? conducteurId,
    String? statut,
    DateTime? dateDepart,
    double? prixTotal,
    double? commission,
    double? gpsStartLat,
    double? gpsStartLong,
    DateTime? gpsStartTime,
    double? gpsEndLat,
    double? gpsEndLong,
    DateTime? gpsEndTime,
    String? routeCatalogId,
    String? driverName,
    double? driverRating,
    String? carModel,
    String? carImage,
    bool? isVerified,
    bool? isSanitized,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

class _RideUpdateImpl implements _RideUpdate {
  const _RideUpdateImpl(this.collection);

  final IsarCollection<int, Ride> collection;

  @override
  bool call({
    required int id,
    Object? remoteId = ignore,
    Object? villeDepart = ignore,
    Object? villeArrivee = ignore,
    Object? distanceKm = ignore,
    Object? nombrePlaces = ignore,
    Object? conducteurId = ignore,
    Object? statut = ignore,
    Object? dateDepart = ignore,
    Object? prixTotal = ignore,
    Object? commission = ignore,
    Object? gpsStartLat = ignore,
    Object? gpsStartLong = ignore,
    Object? gpsStartTime = ignore,
    Object? gpsEndLat = ignore,
    Object? gpsEndLong = ignore,
    Object? gpsEndTime = ignore,
    Object? routeCatalogId = ignore,
    Object? driverName = ignore,
    Object? driverRating = ignore,
    Object? carModel = ignore,
    Object? carImage = ignore,
    Object? isVerified = ignore,
    Object? isSanitized = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    return collection.updateProperties(
          [id],
          {
            if (remoteId != ignore) 1: remoteId as String?,
            if (villeDepart != ignore) 2: villeDepart as String?,
            if (villeArrivee != ignore) 3: villeArrivee as String?,
            if (distanceKm != ignore) 4: distanceKm as int?,
            if (nombrePlaces != ignore) 5: nombrePlaces as int?,
            if (conducteurId != ignore) 6: conducteurId as String?,
            if (statut != ignore) 7: statut as String?,
            if (dateDepart != ignore) 8: dateDepart as DateTime?,
            if (prixTotal != ignore) 9: prixTotal as double?,
            if (commission != ignore) 10: commission as double?,
            if (gpsStartLat != ignore) 11: gpsStartLat as double?,
            if (gpsStartLong != ignore) 12: gpsStartLong as double?,
            if (gpsStartTime != ignore) 13: gpsStartTime as DateTime?,
            if (gpsEndLat != ignore) 14: gpsEndLat as double?,
            if (gpsEndLong != ignore) 15: gpsEndLong as double?,
            if (gpsEndTime != ignore) 16: gpsEndTime as DateTime?,
            if (routeCatalogId != ignore) 17: routeCatalogId as String?,
            if (driverName != ignore) 18: driverName as String?,
            if (driverRating != ignore) 19: driverRating as double?,
            if (carModel != ignore) 20: carModel as String?,
            if (carImage != ignore) 21: carImage as String?,
            if (isVerified != ignore) 22: isVerified as bool?,
            if (isSanitized != ignore) 23: isSanitized as bool?,
            if (createdAt != ignore) 24: createdAt as DateTime?,
            if (updatedAt != ignore) 25: updatedAt as DateTime?,
          },
        ) >
        0;
  }
}

sealed class _RideUpdateAll {
  int call({
    required List<int> id,
    String? remoteId,
    String? villeDepart,
    String? villeArrivee,
    int? distanceKm,
    int? nombrePlaces,
    String? conducteurId,
    String? statut,
    DateTime? dateDepart,
    double? prixTotal,
    double? commission,
    double? gpsStartLat,
    double? gpsStartLong,
    DateTime? gpsStartTime,
    double? gpsEndLat,
    double? gpsEndLong,
    DateTime? gpsEndTime,
    String? routeCatalogId,
    String? driverName,
    double? driverRating,
    String? carModel,
    String? carImage,
    bool? isVerified,
    bool? isSanitized,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

class _RideUpdateAllImpl implements _RideUpdateAll {
  const _RideUpdateAllImpl(this.collection);

  final IsarCollection<int, Ride> collection;

  @override
  int call({
    required List<int> id,
    Object? remoteId = ignore,
    Object? villeDepart = ignore,
    Object? villeArrivee = ignore,
    Object? distanceKm = ignore,
    Object? nombrePlaces = ignore,
    Object? conducteurId = ignore,
    Object? statut = ignore,
    Object? dateDepart = ignore,
    Object? prixTotal = ignore,
    Object? commission = ignore,
    Object? gpsStartLat = ignore,
    Object? gpsStartLong = ignore,
    Object? gpsStartTime = ignore,
    Object? gpsEndLat = ignore,
    Object? gpsEndLong = ignore,
    Object? gpsEndTime = ignore,
    Object? routeCatalogId = ignore,
    Object? driverName = ignore,
    Object? driverRating = ignore,
    Object? carModel = ignore,
    Object? carImage = ignore,
    Object? isVerified = ignore,
    Object? isSanitized = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    return collection.updateProperties(id, {
      if (remoteId != ignore) 1: remoteId as String?,
      if (villeDepart != ignore) 2: villeDepart as String?,
      if (villeArrivee != ignore) 3: villeArrivee as String?,
      if (distanceKm != ignore) 4: distanceKm as int?,
      if (nombrePlaces != ignore) 5: nombrePlaces as int?,
      if (conducteurId != ignore) 6: conducteurId as String?,
      if (statut != ignore) 7: statut as String?,
      if (dateDepart != ignore) 8: dateDepart as DateTime?,
      if (prixTotal != ignore) 9: prixTotal as double?,
      if (commission != ignore) 10: commission as double?,
      if (gpsStartLat != ignore) 11: gpsStartLat as double?,
      if (gpsStartLong != ignore) 12: gpsStartLong as double?,
      if (gpsStartTime != ignore) 13: gpsStartTime as DateTime?,
      if (gpsEndLat != ignore) 14: gpsEndLat as double?,
      if (gpsEndLong != ignore) 15: gpsEndLong as double?,
      if (gpsEndTime != ignore) 16: gpsEndTime as DateTime?,
      if (routeCatalogId != ignore) 17: routeCatalogId as String?,
      if (driverName != ignore) 18: driverName as String?,
      if (driverRating != ignore) 19: driverRating as double?,
      if (carModel != ignore) 20: carModel as String?,
      if (carImage != ignore) 21: carImage as String?,
      if (isVerified != ignore) 22: isVerified as bool?,
      if (isSanitized != ignore) 23: isSanitized as bool?,
      if (createdAt != ignore) 24: createdAt as DateTime?,
      if (updatedAt != ignore) 25: updatedAt as DateTime?,
    });
  }
}

extension RideUpdate on IsarCollection<int, Ride> {
  _RideUpdate get update => _RideUpdateImpl(this);

  _RideUpdateAll get updateAll => _RideUpdateAllImpl(this);
}

sealed class _RideQueryUpdate {
  int call({
    String? remoteId,
    String? villeDepart,
    String? villeArrivee,
    int? distanceKm,
    int? nombrePlaces,
    String? conducteurId,
    String? statut,
    DateTime? dateDepart,
    double? prixTotal,
    double? commission,
    double? gpsStartLat,
    double? gpsStartLong,
    DateTime? gpsStartTime,
    double? gpsEndLat,
    double? gpsEndLong,
    DateTime? gpsEndTime,
    String? routeCatalogId,
    String? driverName,
    double? driverRating,
    String? carModel,
    String? carImage,
    bool? isVerified,
    bool? isSanitized,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

class _RideQueryUpdateImpl implements _RideQueryUpdate {
  const _RideQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Ride> query;
  final int? limit;

  @override
  int call({
    Object? remoteId = ignore,
    Object? villeDepart = ignore,
    Object? villeArrivee = ignore,
    Object? distanceKm = ignore,
    Object? nombrePlaces = ignore,
    Object? conducteurId = ignore,
    Object? statut = ignore,
    Object? dateDepart = ignore,
    Object? prixTotal = ignore,
    Object? commission = ignore,
    Object? gpsStartLat = ignore,
    Object? gpsStartLong = ignore,
    Object? gpsStartTime = ignore,
    Object? gpsEndLat = ignore,
    Object? gpsEndLong = ignore,
    Object? gpsEndTime = ignore,
    Object? routeCatalogId = ignore,
    Object? driverName = ignore,
    Object? driverRating = ignore,
    Object? carModel = ignore,
    Object? carImage = ignore,
    Object? isVerified = ignore,
    Object? isSanitized = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (remoteId != ignore) 1: remoteId as String?,
      if (villeDepart != ignore) 2: villeDepart as String?,
      if (villeArrivee != ignore) 3: villeArrivee as String?,
      if (distanceKm != ignore) 4: distanceKm as int?,
      if (nombrePlaces != ignore) 5: nombrePlaces as int?,
      if (conducteurId != ignore) 6: conducteurId as String?,
      if (statut != ignore) 7: statut as String?,
      if (dateDepart != ignore) 8: dateDepart as DateTime?,
      if (prixTotal != ignore) 9: prixTotal as double?,
      if (commission != ignore) 10: commission as double?,
      if (gpsStartLat != ignore) 11: gpsStartLat as double?,
      if (gpsStartLong != ignore) 12: gpsStartLong as double?,
      if (gpsStartTime != ignore) 13: gpsStartTime as DateTime?,
      if (gpsEndLat != ignore) 14: gpsEndLat as double?,
      if (gpsEndLong != ignore) 15: gpsEndLong as double?,
      if (gpsEndTime != ignore) 16: gpsEndTime as DateTime?,
      if (routeCatalogId != ignore) 17: routeCatalogId as String?,
      if (driverName != ignore) 18: driverName as String?,
      if (driverRating != ignore) 19: driverRating as double?,
      if (carModel != ignore) 20: carModel as String?,
      if (carImage != ignore) 21: carImage as String?,
      if (isVerified != ignore) 22: isVerified as bool?,
      if (isSanitized != ignore) 23: isSanitized as bool?,
      if (createdAt != ignore) 24: createdAt as DateTime?,
      if (updatedAt != ignore) 25: updatedAt as DateTime?,
    });
  }
}

extension RideQueryUpdate on IsarQuery<Ride> {
  _RideQueryUpdate get updateFirst => _RideQueryUpdateImpl(this, limit: 1);

  _RideQueryUpdate get updateAll => _RideQueryUpdateImpl(this);
}

class _RideQueryBuilderUpdateImpl implements _RideQueryUpdate {
  const _RideQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<Ride, Ride, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? remoteId = ignore,
    Object? villeDepart = ignore,
    Object? villeArrivee = ignore,
    Object? distanceKm = ignore,
    Object? nombrePlaces = ignore,
    Object? conducteurId = ignore,
    Object? statut = ignore,
    Object? dateDepart = ignore,
    Object? prixTotal = ignore,
    Object? commission = ignore,
    Object? gpsStartLat = ignore,
    Object? gpsStartLong = ignore,
    Object? gpsStartTime = ignore,
    Object? gpsEndLat = ignore,
    Object? gpsEndLong = ignore,
    Object? gpsEndTime = ignore,
    Object? routeCatalogId = ignore,
    Object? driverName = ignore,
    Object? driverRating = ignore,
    Object? carModel = ignore,
    Object? carImage = ignore,
    Object? isVerified = ignore,
    Object? isSanitized = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (remoteId != ignore) 1: remoteId as String?,
        if (villeDepart != ignore) 2: villeDepart as String?,
        if (villeArrivee != ignore) 3: villeArrivee as String?,
        if (distanceKm != ignore) 4: distanceKm as int?,
        if (nombrePlaces != ignore) 5: nombrePlaces as int?,
        if (conducteurId != ignore) 6: conducteurId as String?,
        if (statut != ignore) 7: statut as String?,
        if (dateDepart != ignore) 8: dateDepart as DateTime?,
        if (prixTotal != ignore) 9: prixTotal as double?,
        if (commission != ignore) 10: commission as double?,
        if (gpsStartLat != ignore) 11: gpsStartLat as double?,
        if (gpsStartLong != ignore) 12: gpsStartLong as double?,
        if (gpsStartTime != ignore) 13: gpsStartTime as DateTime?,
        if (gpsEndLat != ignore) 14: gpsEndLat as double?,
        if (gpsEndLong != ignore) 15: gpsEndLong as double?,
        if (gpsEndTime != ignore) 16: gpsEndTime as DateTime?,
        if (routeCatalogId != ignore) 17: routeCatalogId as String?,
        if (driverName != ignore) 18: driverName as String?,
        if (driverRating != ignore) 19: driverRating as double?,
        if (carModel != ignore) 20: carModel as String?,
        if (carImage != ignore) 21: carImage as String?,
        if (isVerified != ignore) 22: isVerified as bool?,
        if (isSanitized != ignore) 23: isSanitized as bool?,
        if (createdAt != ignore) 24: createdAt as DateTime?,
        if (updatedAt != ignore) 25: updatedAt as DateTime?,
      });
    } finally {
      q.close();
    }
  }
}

extension RideQueryBuilderUpdate on QueryBuilder<Ride, Ride, QOperations> {
  _RideQueryUpdate get updateFirst =>
      _RideQueryBuilderUpdateImpl(this, limit: 1);

  _RideQueryUpdate get updateAll => _RideQueryBuilderUpdateImpl(this);
}

extension RideQueryFilter on QueryBuilder<Ride, Ride, QFilterCondition> {
  QueryBuilder<Ride, Ride, QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> idGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  villeDepartGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeDepartIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  villeArriveeGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> villeArriveeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> distanceKmEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> distanceKmGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  distanceKmGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> distanceKmLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 4, value: value));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> distanceKmLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> distanceKmBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 4, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> nombrePlacesEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> nombrePlacesGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  nombrePlacesGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> nombrePlacesLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 5, value: value));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> nombrePlacesLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 5, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> nombrePlacesBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 5, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  conducteurIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 6, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 6,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 6,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 6, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> conducteurIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 6, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 7,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 7,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> statutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> dateDepartIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> dateDepartIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> dateDepartEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> dateDepartGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  dateDepartGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> dateDepartLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 8, value: value));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> dateDepartLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> dateDepartBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 8, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> prixTotalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> prixTotalIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> prixTotalEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> prixTotalGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 9, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> prixTotalGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 9, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> prixTotalLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 9, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> prixTotalLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 9, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> prixTotalBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> commissionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> commissionIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> commissionEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 10, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> commissionGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 10, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  commissionGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 10, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> commissionLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 10, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> commissionLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 10, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> commissionBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 10,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLatIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLatEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 11, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLatGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 11, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  gpsStartLatGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 11, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLatLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 11, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLatLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 11, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLatBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 11,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLongIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLongIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 12));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLongEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 12, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLongGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 12, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  gpsStartLongGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 12, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLongLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 12, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLongLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 12, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartLongBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 12,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartTimeIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartTimeEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartTimeGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  gpsStartTimeGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartTimeLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartTimeLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsStartTimeBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 13, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLatIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLatIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLatEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 14, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLatGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 14, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLatGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 14, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLatLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 14, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLatLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 14, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLatBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 14,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLongIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLongIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLongEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 15, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLongGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 15, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  gpsEndLongGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 15, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLongLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 15, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLongLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 15, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndLongBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 15,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndTimeIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndTimeEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndTimeGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  gpsEndTimeGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndTimeLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndTimeLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> gpsEndTimeBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 16, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 17));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  routeCatalogIdGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 17, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  routeCatalogIdLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 17,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 17,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 17,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 17, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> routeCatalogIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 17, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  driverNameGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 18, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 18,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 18,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 18,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 18, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 18, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverRatingEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 19, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverRatingGreaterThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 19, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition>
  driverRatingGreaterThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 19, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverRatingLessThan(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 19, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverRatingLessThanOrEqualTo(
    double value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 19, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> driverRatingBetween(
    double lower,
    double upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 19,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 20, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 20,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 20,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 20,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 20, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carModelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 20, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 21, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 21,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 21,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 21,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 21, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> carImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 21, value: ''),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> isVerifiedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 22, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> isSanitizedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 23, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 24));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 24));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> createdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 24, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> createdAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 24, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> createdAtGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 24, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> createdAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 24, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> createdAtLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 24, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> createdAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 24, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 25));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 25));
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 25, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 25, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> updatedAtGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 25, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> updatedAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 25, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> updatedAtLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 25, value: value),
      );
    });
  }

  QueryBuilder<Ride, Ride, QAfterFilterCondition> updatedAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 25, lower: lower, upper: upper),
      );
    });
  }
}

extension RideQueryObject on QueryBuilder<Ride, Ride, QFilterCondition> {}

extension RideQuerySortBy on QueryBuilder<Ride, Ride, QSortBy> {
  QueryBuilder<Ride, Ride, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByRemoteIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByVilleDepart({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByVilleDepartDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByVilleArrivee({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByVilleArriveeDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByNombrePlaces() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByNombrePlacesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByConducteurId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByConducteurIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByStatut({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByStatutDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByDateDepart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByDateDepartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByPrixTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByPrixTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByCommission() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByCommissionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsStartLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsStartLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsStartLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsStartLongDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsEndLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsEndLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsEndLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsEndLongDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByGpsEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByRouteCatalogId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByRouteCatalogIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByDriverName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByDriverNameDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByDriverRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByDriverRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByCarModel({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByCarModelDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByCarImage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByCarImageDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByIsVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByIsVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByIsSanitized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByIsSanitizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25, sort: Sort.desc);
    });
  }
}

extension RideQuerySortThenBy on QueryBuilder<Ride, Ride, QSortThenBy> {
  QueryBuilder<Ride, Ride, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByRemoteIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByVilleDepart({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByVilleDepartDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByVilleArrivee({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByVilleArriveeDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByDistanceKmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByNombrePlaces() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByNombrePlacesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByConducteurId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByConducteurIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByStatut({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByStatutDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByDateDepart() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByDateDepartDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByPrixTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByPrixTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByCommission() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByCommissionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsStartLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsStartLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsStartLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsStartLongDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsEndLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsEndLatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsEndLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsEndLongDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByGpsEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByRouteCatalogId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByRouteCatalogIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(17, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByDriverName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByDriverNameDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(18, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByDriverRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByDriverRatingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(19, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByCarModel({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByCarModelDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(20, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByCarImage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByCarImageDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(21, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByIsVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByIsVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(22, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByIsSanitized() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByIsSanitizedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(23, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(24, sort: Sort.desc);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25);
    });
  }

  QueryBuilder<Ride, Ride, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(25, sort: Sort.desc);
    });
  }
}

extension RideQueryWhereDistinct on QueryBuilder<Ride, Ride, QDistinct> {
  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByVilleDepart({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByVilleArrivee({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByDistanceKm() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByNombrePlaces() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByConducteurId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByStatut({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByDateDepart() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByPrixTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByCommission() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByGpsStartLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByGpsStartLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByGpsStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByGpsEndLat() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByGpsEndLong() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByGpsEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByRouteCatalogId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(17, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByDriverName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(18, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByDriverRating() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(19);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByCarModel({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(20, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByCarImage({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(21, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByIsVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(22);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByIsSanitized() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(23);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(24);
    });
  }

  QueryBuilder<Ride, Ride, QAfterDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(25);
    });
  }
}

extension RideQueryProperty1 on QueryBuilder<Ride, Ride, QProperty> {
  QueryBuilder<Ride, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Ride, String, QAfterProperty> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Ride, String, QAfterProperty> villeDepartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Ride, String, QAfterProperty> villeArriveeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Ride, int, QAfterProperty> distanceKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<Ride, int, QAfterProperty> nombrePlacesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<Ride, String, QAfterProperty> conducteurIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<Ride, String, QAfterProperty> statutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<Ride, DateTime?, QAfterProperty> dateDepartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<Ride, double?, QAfterProperty> prixTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<Ride, double?, QAfterProperty> commissionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<Ride, double?, QAfterProperty> gpsStartLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<Ride, double?, QAfterProperty> gpsStartLongProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<Ride, DateTime?, QAfterProperty> gpsStartTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<Ride, double?, QAfterProperty> gpsEndLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<Ride, double?, QAfterProperty> gpsEndLongProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<Ride, DateTime?, QAfterProperty> gpsEndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<Ride, String?, QAfterProperty> routeCatalogIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<Ride, String, QAfterProperty> driverNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<Ride, double, QAfterProperty> driverRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<Ride, String, QAfterProperty> carModelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<Ride, String, QAfterProperty> carImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<Ride, bool, QAfterProperty> isVerifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<Ride, bool, QAfterProperty> isSanitizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<Ride, DateTime?, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<Ride, DateTime?, QAfterProperty> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }
}

extension RideQueryProperty2<R> on QueryBuilder<Ride, R, QAfterProperty> {
  QueryBuilder<Ride, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Ride, (R, String), QAfterProperty> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Ride, (R, String), QAfterProperty> villeDepartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Ride, (R, String), QAfterProperty> villeArriveeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Ride, (R, int), QAfterProperty> distanceKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<Ride, (R, int), QAfterProperty> nombrePlacesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<Ride, (R, String), QAfterProperty> conducteurIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<Ride, (R, String), QAfterProperty> statutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<Ride, (R, DateTime?), QAfterProperty> dateDepartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<Ride, (R, double?), QAfterProperty> prixTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<Ride, (R, double?), QAfterProperty> commissionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<Ride, (R, double?), QAfterProperty> gpsStartLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<Ride, (R, double?), QAfterProperty> gpsStartLongProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<Ride, (R, DateTime?), QAfterProperty> gpsStartTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<Ride, (R, double?), QAfterProperty> gpsEndLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<Ride, (R, double?), QAfterProperty> gpsEndLongProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<Ride, (R, DateTime?), QAfterProperty> gpsEndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<Ride, (R, String?), QAfterProperty> routeCatalogIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<Ride, (R, String), QAfterProperty> driverNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<Ride, (R, double), QAfterProperty> driverRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<Ride, (R, String), QAfterProperty> carModelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<Ride, (R, String), QAfterProperty> carImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<Ride, (R, bool), QAfterProperty> isVerifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<Ride, (R, bool), QAfterProperty> isSanitizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<Ride, (R, DateTime?), QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<Ride, (R, DateTime?), QAfterProperty> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }
}

extension RideQueryProperty3<R1, R2>
    on QueryBuilder<Ride, (R1, R2), QAfterProperty> {
  QueryBuilder<Ride, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Ride, (R1, R2, String), QOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Ride, (R1, R2, String), QOperations> villeDepartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Ride, (R1, R2, String), QOperations> villeArriveeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Ride, (R1, R2, int), QOperations> distanceKmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<Ride, (R1, R2, int), QOperations> nombrePlacesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<Ride, (R1, R2, String), QOperations> conducteurIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<Ride, (R1, R2, String), QOperations> statutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<Ride, (R1, R2, DateTime?), QOperations> dateDepartProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<Ride, (R1, R2, double?), QOperations> prixTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<Ride, (R1, R2, double?), QOperations> commissionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<Ride, (R1, R2, double?), QOperations> gpsStartLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<Ride, (R1, R2, double?), QOperations> gpsStartLongProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<Ride, (R1, R2, DateTime?), QOperations> gpsStartTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<Ride, (R1, R2, double?), QOperations> gpsEndLatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<Ride, (R1, R2, double?), QOperations> gpsEndLongProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<Ride, (R1, R2, DateTime?), QOperations> gpsEndTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }

  QueryBuilder<Ride, (R1, R2, String?), QOperations> routeCatalogIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(17);
    });
  }

  QueryBuilder<Ride, (R1, R2, String), QOperations> driverNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(18);
    });
  }

  QueryBuilder<Ride, (R1, R2, double), QOperations> driverRatingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(19);
    });
  }

  QueryBuilder<Ride, (R1, R2, String), QOperations> carModelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(20);
    });
  }

  QueryBuilder<Ride, (R1, R2, String), QOperations> carImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(21);
    });
  }

  QueryBuilder<Ride, (R1, R2, bool), QOperations> isVerifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(22);
    });
  }

  QueryBuilder<Ride, (R1, R2, bool), QOperations> isSanitizedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(23);
    });
  }

  QueryBuilder<Ride, (R1, R2, DateTime?), QOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(24);
    });
  }

  QueryBuilder<Ride, (R1, R2, DateTime?), QOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(25);
    });
  }
}
