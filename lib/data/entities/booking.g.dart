// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetBookingCollection on Isar {
  IsarCollection<int, Booking> get bookings => this.collection();
}

final BookingSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Booking',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'remoteId', type: IsarType.string),
      IsarPropertySchema(name: 'passagerId', type: IsarType.string),
      IsarPropertySchema(name: 'trajetId', type: IsarType.string),
      IsarPropertySchema(name: 'nombrePlacesReservees', type: IsarType.long),
      IsarPropertySchema(name: 'statut', type: IsarType.string),
      IsarPropertySchema(name: 'montantTotal', type: IsarType.double),
      IsarPropertySchema(name: 'prixParPassager', type: IsarType.double),
      IsarPropertySchema(name: 'amountPaid', type: IsarType.double),
      IsarPropertySchema(name: 'paymentMethod', type: IsarType.string),
      IsarPropertySchema(
        name: 'paiementConducteurConfirme',
        type: IsarType.bool,
      ),
      IsarPropertySchema(
        name: 'cancellationPenaltyAmount',
        type: IsarType.long,
      ),
      IsarPropertySchema(name: 'refundAmount', type: IsarType.long),
      IsarPropertySchema(name: 'cancelledAt', type: IsarType.dateTime),
      IsarPropertySchema(name: 'cancellationReason', type: IsarType.string),
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
        name: 'passagerId',
        properties: ["passagerId"],
        unique: false,
        hash: false,
      ),
      IsarIndexSchema(
        name: 'trajetId',
        properties: ["trajetId"],
        unique: false,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, Booking>(
    serialize: serializeBooking,
    deserialize: deserializeBooking,
    deserializeProperty: deserializeBookingProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeBooking(IsarWriter writer, Booking object) {
  IsarCore.writeString(writer, 1, object.remoteId);
  IsarCore.writeString(writer, 2, object.passagerId);
  IsarCore.writeString(writer, 3, object.trajetId);
  IsarCore.writeLong(writer, 4, object.nombrePlacesReservees);
  IsarCore.writeString(writer, 5, object.statut);
  IsarCore.writeDouble(writer, 6, object.montantTotal ?? double.nan);
  IsarCore.writeDouble(writer, 7, object.prixParPassager ?? double.nan);
  IsarCore.writeDouble(writer, 8, object.amountPaid ?? double.nan);
  {
    final value = object.paymentMethod;
    if (value == null) {
      IsarCore.writeNull(writer, 9);
    } else {
      IsarCore.writeString(writer, 9, value);
    }
  }
  IsarCore.writeBool(writer, 10, value: object.paiementConducteurConfirme);
  IsarCore.writeLong(writer, 11, object.cancellationPenaltyAmount);
  IsarCore.writeLong(writer, 12, object.refundAmount);
  IsarCore.writeLong(
    writer,
    13,
    object.cancelledAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  {
    final value = object.cancellationReason;
    if (value == null) {
      IsarCore.writeNull(writer, 14);
    } else {
      IsarCore.writeString(writer, 14, value);
    }
  }
  IsarCore.writeLong(
    writer,
    15,
    object.createdAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  IsarCore.writeLong(
    writer,
    16,
    object.updatedAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  return object.id;
}

@isarProtected
Booking deserializeBooking(IsarReader reader) {
  final object = Booking();
  object.id = IsarCore.readId(reader);
  object.remoteId = IsarCore.readString(reader, 1) ?? '';
  object.passagerId = IsarCore.readString(reader, 2) ?? '';
  object.trajetId = IsarCore.readString(reader, 3) ?? '';
  object.nombrePlacesReservees = IsarCore.readLong(reader, 4);
  object.statut = IsarCore.readString(reader, 5) ?? '';
  {
    final value = IsarCore.readDouble(reader, 6);
    if (value.isNaN) {
      object.montantTotal = null;
    } else {
      object.montantTotal = value;
    }
  }
  {
    final value = IsarCore.readDouble(reader, 7);
    if (value.isNaN) {
      object.prixParPassager = null;
    } else {
      object.prixParPassager = value;
    }
  }
  {
    final value = IsarCore.readDouble(reader, 8);
    if (value.isNaN) {
      object.amountPaid = null;
    } else {
      object.amountPaid = value;
    }
  }
  object.paymentMethod = IsarCore.readString(reader, 9);
  object.paiementConducteurConfirme = IsarCore.readBool(reader, 10);
  object.cancellationPenaltyAmount = IsarCore.readLong(reader, 11);
  object.refundAmount = IsarCore.readLong(reader, 12);
  {
    final value = IsarCore.readLong(reader, 13);
    if (value == -9223372036854775808) {
      object.cancelledAt = null;
    } else {
      object.cancelledAt = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.cancellationReason = IsarCore.readString(reader, 14);
  {
    final value = IsarCore.readLong(reader, 15);
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
    final value = IsarCore.readLong(reader, 16);
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
dynamic deserializeBookingProp(IsarReader reader, int property) {
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
      return IsarCore.readString(reader, 5) ?? '';
    case 6:
      {
        final value = IsarCore.readDouble(reader, 6);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 7:
      {
        final value = IsarCore.readDouble(reader, 7);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 8:
      {
        final value = IsarCore.readDouble(reader, 8);
        if (value.isNaN) {
          return null;
        } else {
          return value;
        }
      }
    case 9:
      return IsarCore.readString(reader, 9);
    case 10:
      return IsarCore.readBool(reader, 10);
    case 11:
      return IsarCore.readLong(reader, 11);
    case 12:
      return IsarCore.readLong(reader, 12);
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
      return IsarCore.readString(reader, 14);
    case 15:
      {
        final value = IsarCore.readLong(reader, 15);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
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
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _BookingUpdate {
  bool call({
    required int id,
    String? remoteId,
    String? passagerId,
    String? trajetId,
    int? nombrePlacesReservees,
    String? statut,
    double? montantTotal,
    double? prixParPassager,
    double? amountPaid,
    String? paymentMethod,
    bool? paiementConducteurConfirme,
    int? cancellationPenaltyAmount,
    int? refundAmount,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

class _BookingUpdateImpl implements _BookingUpdate {
  const _BookingUpdateImpl(this.collection);

  final IsarCollection<int, Booking> collection;

  @override
  bool call({
    required int id,
    Object? remoteId = ignore,
    Object? passagerId = ignore,
    Object? trajetId = ignore,
    Object? nombrePlacesReservees = ignore,
    Object? statut = ignore,
    Object? montantTotal = ignore,
    Object? prixParPassager = ignore,
    Object? amountPaid = ignore,
    Object? paymentMethod = ignore,
    Object? paiementConducteurConfirme = ignore,
    Object? cancellationPenaltyAmount = ignore,
    Object? refundAmount = ignore,
    Object? cancelledAt = ignore,
    Object? cancellationReason = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    return collection.updateProperties(
          [id],
          {
            if (remoteId != ignore) 1: remoteId as String?,
            if (passagerId != ignore) 2: passagerId as String?,
            if (trajetId != ignore) 3: trajetId as String?,
            if (nombrePlacesReservees != ignore)
              4: nombrePlacesReservees as int?,
            if (statut != ignore) 5: statut as String?,
            if (montantTotal != ignore) 6: montantTotal as double?,
            if (prixParPassager != ignore) 7: prixParPassager as double?,
            if (amountPaid != ignore) 8: amountPaid as double?,
            if (paymentMethod != ignore) 9: paymentMethod as String?,
            if (paiementConducteurConfirme != ignore)
              10: paiementConducteurConfirme as bool?,
            if (cancellationPenaltyAmount != ignore)
              11: cancellationPenaltyAmount as int?,
            if (refundAmount != ignore) 12: refundAmount as int?,
            if (cancelledAt != ignore) 13: cancelledAt as DateTime?,
            if (cancellationReason != ignore) 14: cancellationReason as String?,
            if (createdAt != ignore) 15: createdAt as DateTime?,
            if (updatedAt != ignore) 16: updatedAt as DateTime?,
          },
        ) >
        0;
  }
}

sealed class _BookingUpdateAll {
  int call({
    required List<int> id,
    String? remoteId,
    String? passagerId,
    String? trajetId,
    int? nombrePlacesReservees,
    String? statut,
    double? montantTotal,
    double? prixParPassager,
    double? amountPaid,
    String? paymentMethod,
    bool? paiementConducteurConfirme,
    int? cancellationPenaltyAmount,
    int? refundAmount,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

class _BookingUpdateAllImpl implements _BookingUpdateAll {
  const _BookingUpdateAllImpl(this.collection);

  final IsarCollection<int, Booking> collection;

  @override
  int call({
    required List<int> id,
    Object? remoteId = ignore,
    Object? passagerId = ignore,
    Object? trajetId = ignore,
    Object? nombrePlacesReservees = ignore,
    Object? statut = ignore,
    Object? montantTotal = ignore,
    Object? prixParPassager = ignore,
    Object? amountPaid = ignore,
    Object? paymentMethod = ignore,
    Object? paiementConducteurConfirme = ignore,
    Object? cancellationPenaltyAmount = ignore,
    Object? refundAmount = ignore,
    Object? cancelledAt = ignore,
    Object? cancellationReason = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    return collection.updateProperties(id, {
      if (remoteId != ignore) 1: remoteId as String?,
      if (passagerId != ignore) 2: passagerId as String?,
      if (trajetId != ignore) 3: trajetId as String?,
      if (nombrePlacesReservees != ignore) 4: nombrePlacesReservees as int?,
      if (statut != ignore) 5: statut as String?,
      if (montantTotal != ignore) 6: montantTotal as double?,
      if (prixParPassager != ignore) 7: prixParPassager as double?,
      if (amountPaid != ignore) 8: amountPaid as double?,
      if (paymentMethod != ignore) 9: paymentMethod as String?,
      if (paiementConducteurConfirme != ignore)
        10: paiementConducteurConfirme as bool?,
      if (cancellationPenaltyAmount != ignore)
        11: cancellationPenaltyAmount as int?,
      if (refundAmount != ignore) 12: refundAmount as int?,
      if (cancelledAt != ignore) 13: cancelledAt as DateTime?,
      if (cancellationReason != ignore) 14: cancellationReason as String?,
      if (createdAt != ignore) 15: createdAt as DateTime?,
      if (updatedAt != ignore) 16: updatedAt as DateTime?,
    });
  }
}

extension BookingUpdate on IsarCollection<int, Booking> {
  _BookingUpdate get update => _BookingUpdateImpl(this);

  _BookingUpdateAll get updateAll => _BookingUpdateAllImpl(this);
}

sealed class _BookingQueryUpdate {
  int call({
    String? remoteId,
    String? passagerId,
    String? trajetId,
    int? nombrePlacesReservees,
    String? statut,
    double? montantTotal,
    double? prixParPassager,
    double? amountPaid,
    String? paymentMethod,
    bool? paiementConducteurConfirme,
    int? cancellationPenaltyAmount,
    int? refundAmount,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

class _BookingQueryUpdateImpl implements _BookingQueryUpdate {
  const _BookingQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Booking> query;
  final int? limit;

  @override
  int call({
    Object? remoteId = ignore,
    Object? passagerId = ignore,
    Object? trajetId = ignore,
    Object? nombrePlacesReservees = ignore,
    Object? statut = ignore,
    Object? montantTotal = ignore,
    Object? prixParPassager = ignore,
    Object? amountPaid = ignore,
    Object? paymentMethod = ignore,
    Object? paiementConducteurConfirme = ignore,
    Object? cancellationPenaltyAmount = ignore,
    Object? refundAmount = ignore,
    Object? cancelledAt = ignore,
    Object? cancellationReason = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (remoteId != ignore) 1: remoteId as String?,
      if (passagerId != ignore) 2: passagerId as String?,
      if (trajetId != ignore) 3: trajetId as String?,
      if (nombrePlacesReservees != ignore) 4: nombrePlacesReservees as int?,
      if (statut != ignore) 5: statut as String?,
      if (montantTotal != ignore) 6: montantTotal as double?,
      if (prixParPassager != ignore) 7: prixParPassager as double?,
      if (amountPaid != ignore) 8: amountPaid as double?,
      if (paymentMethod != ignore) 9: paymentMethod as String?,
      if (paiementConducteurConfirme != ignore)
        10: paiementConducteurConfirme as bool?,
      if (cancellationPenaltyAmount != ignore)
        11: cancellationPenaltyAmount as int?,
      if (refundAmount != ignore) 12: refundAmount as int?,
      if (cancelledAt != ignore) 13: cancelledAt as DateTime?,
      if (cancellationReason != ignore) 14: cancellationReason as String?,
      if (createdAt != ignore) 15: createdAt as DateTime?,
      if (updatedAt != ignore) 16: updatedAt as DateTime?,
    });
  }
}

extension BookingQueryUpdate on IsarQuery<Booking> {
  _BookingQueryUpdate get updateFirst =>
      _BookingQueryUpdateImpl(this, limit: 1);

  _BookingQueryUpdate get updateAll => _BookingQueryUpdateImpl(this);
}

class _BookingQueryBuilderUpdateImpl implements _BookingQueryUpdate {
  const _BookingQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<Booking, Booking, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? remoteId = ignore,
    Object? passagerId = ignore,
    Object? trajetId = ignore,
    Object? nombrePlacesReservees = ignore,
    Object? statut = ignore,
    Object? montantTotal = ignore,
    Object? prixParPassager = ignore,
    Object? amountPaid = ignore,
    Object? paymentMethod = ignore,
    Object? paiementConducteurConfirme = ignore,
    Object? cancellationPenaltyAmount = ignore,
    Object? refundAmount = ignore,
    Object? cancelledAt = ignore,
    Object? cancellationReason = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (remoteId != ignore) 1: remoteId as String?,
        if (passagerId != ignore) 2: passagerId as String?,
        if (trajetId != ignore) 3: trajetId as String?,
        if (nombrePlacesReservees != ignore) 4: nombrePlacesReservees as int?,
        if (statut != ignore) 5: statut as String?,
        if (montantTotal != ignore) 6: montantTotal as double?,
        if (prixParPassager != ignore) 7: prixParPassager as double?,
        if (amountPaid != ignore) 8: amountPaid as double?,
        if (paymentMethod != ignore) 9: paymentMethod as String?,
        if (paiementConducteurConfirme != ignore)
          10: paiementConducteurConfirme as bool?,
        if (cancellationPenaltyAmount != ignore)
          11: cancellationPenaltyAmount as int?,
        if (refundAmount != ignore) 12: refundAmount as int?,
        if (cancelledAt != ignore) 13: cancelledAt as DateTime?,
        if (cancellationReason != ignore) 14: cancellationReason as String?,
        if (createdAt != ignore) 15: createdAt as DateTime?,
        if (updatedAt != ignore) 16: updatedAt as DateTime?,
      });
    } finally {
      q.close();
    }
  }
}

extension BookingQueryBuilderUpdate
    on QueryBuilder<Booking, Booking, QOperations> {
  _BookingQueryUpdate get updateFirst =>
      _BookingQueryBuilderUpdateImpl(this, limit: 1);

  _BookingQueryUpdate get updateAll => _BookingQueryBuilderUpdateImpl(this);
}

extension BookingQueryFilter
    on QueryBuilder<Booking, Booking, QFilterCondition> {
  QueryBuilder<Booking, Booking, QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> idGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdGreaterThan(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  remoteIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  remoteIdLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdBetween(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdStartsWith(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdEndsWith(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdContains(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdMatches(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdGreaterThan(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  passagerIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  passagerIdLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdBetween(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdStartsWith(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdEndsWith(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdContains(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdMatches(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> passagerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdGreaterThan(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  trajetIdGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  trajetIdLessThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdBetween(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdStartsWith(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdEndsWith(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdContains(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdMatches(
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

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> trajetIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  nombrePlacesReserveesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  nombrePlacesReserveesGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  nombrePlacesReserveesGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  nombrePlacesReserveesLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 4, value: value));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  nombrePlacesReserveesLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 4, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  nombrePlacesReserveesBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 4, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  statutGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> statutIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> montantTotalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  montantTotalIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> montantTotalEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> montantTotalGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 6, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  montantTotalGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 6, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> montantTotalLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 6, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  montantTotalLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 6, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> montantTotalBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 6,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  prixParPassagerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  prixParPassagerIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> prixParPassagerEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  prixParPassagerGreaterThan(double? value, {double epsilon = Filter.epsilon}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 7, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  prixParPassagerGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 7, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> prixParPassagerLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 7, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  prixParPassagerLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 7, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> prixParPassagerBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 7,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> amountPaidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> amountPaidIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 8));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> amountPaidEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> amountPaidGreaterThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 8, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  amountPaidGreaterThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 8, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> amountPaidLessThan(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 8, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  amountPaidLessThanOrEqualTo(
    double? value, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 8, value: value, epsilon: epsilon),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> amountPaidBetween(
    double? lower,
    double? upper, {
    double epsilon = Filter.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 8,
          lower: lower,
          upper: upper,

          epsilon: epsilon,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> paymentMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  paymentMethodIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 9));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> paymentMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  paymentMethodGreaterThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  paymentMethodGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> paymentMethodLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  paymentMethodLessThanOrEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> paymentMethodBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 9,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> paymentMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> paymentMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> paymentMethodContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 9,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> paymentMethodMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 9,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> paymentMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  paymentMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  paiementConducteurConfirmeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationPenaltyAmountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationPenaltyAmountGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationPenaltyAmountGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationPenaltyAmountLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationPenaltyAmountLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationPenaltyAmountBetween(int lower, int upper) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 11, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> refundAmountEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> refundAmountGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  refundAmountGreaterThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> refundAmountLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  refundAmountLessThanOrEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 12, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> refundAmountBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 12, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> cancelledAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> cancelledAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 13));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> cancelledAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> cancelledAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancelledAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> cancelledAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancelledAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 13, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> cancelledAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 13, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 14));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonGreaterThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonLessThan(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 14, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 14,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 14,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 14,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 14, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  cancellationReasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 14, value: ''),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 15));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> createdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> createdAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  createdAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> createdAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  createdAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 15, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> createdAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 15, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 16));
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  updatedAtGreaterThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> updatedAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition>
  updatedAtLessThanOrEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 16, value: value),
      );
    });
  }

  QueryBuilder<Booking, Booking, QAfterFilterCondition> updatedAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 16, lower: lower, upper: upper),
      );
    });
  }
}

extension BookingQueryObject
    on QueryBuilder<Booking, Booking, QFilterCondition> {}

extension BookingQuerySortBy on QueryBuilder<Booking, Booking, QSortBy> {
  QueryBuilder<Booking, Booking, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByRemoteIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByPassagerId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByPassagerIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByTrajetId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByTrajetIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByNombrePlacesReservees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  sortByNombrePlacesReserveesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByStatut({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByStatutDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByMontantTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByMontantTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByPrixParPassager() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByPrixParPassagerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByAmountPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByAmountPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByPaymentMethod({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByPaymentMethodDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  sortByPaiementConducteurConfirme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  sortByPaiementConducteurConfirmeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  sortByCancellationPenaltyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  sortByCancellationPenaltyAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByRefundAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByRefundAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByCancelledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByCancelledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByCancellationReason({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByCancellationReasonDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }
}

extension BookingQuerySortThenBy
    on QueryBuilder<Booking, Booking, QSortThenBy> {
  QueryBuilder<Booking, Booking, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByRemoteIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByPassagerId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByPassagerIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByTrajetId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByTrajetIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByNombrePlacesReservees() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  thenByNombrePlacesReserveesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByStatut({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByStatutDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByMontantTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByMontantTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByPrixParPassager() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByPrixParPassagerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByAmountPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByAmountPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByPaymentMethod({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByPaymentMethodDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  thenByPaiementConducteurConfirme() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  thenByPaiementConducteurConfirmeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  thenByCancellationPenaltyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy>
  thenByCancellationPenaltyAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByRefundAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByRefundAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(12, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByCancelledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByCancelledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(13, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByCancellationReason({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByCancellationReasonDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(14, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(15, sort: Sort.desc);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16);
    });
  }

  QueryBuilder<Booking, Booking, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(16, sort: Sort.desc);
    });
  }
}

extension BookingQueryWhereDistinct
    on QueryBuilder<Booking, Booking, QDistinct> {
  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByPassagerId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByTrajetId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct>
  distinctByNombrePlacesReservees() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByStatut({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByMontantTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByPrixParPassager() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByAmountPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByPaymentMethod({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct>
  distinctByPaiementConducteurConfirme() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct>
  distinctByCancellationPenaltyAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByRefundAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(12);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByCancelledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(13);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByCancellationReason({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(14, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(15);
    });
  }

  QueryBuilder<Booking, Booking, QAfterDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(16);
    });
  }
}

extension BookingQueryProperty1 on QueryBuilder<Booking, Booking, QProperty> {
  QueryBuilder<Booking, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Booking, String, QAfterProperty> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Booking, String, QAfterProperty> passagerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Booking, String, QAfterProperty> trajetIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Booking, int, QAfterProperty> nombrePlacesReserveesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<Booking, String, QAfterProperty> statutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<Booking, double?, QAfterProperty> montantTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<Booking, double?, QAfterProperty> prixParPassagerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<Booking, double?, QAfterProperty> amountPaidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<Booking, String?, QAfterProperty> paymentMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<Booking, bool, QAfterProperty>
  paiementConducteurConfirmeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<Booking, int, QAfterProperty>
  cancellationPenaltyAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<Booking, int, QAfterProperty> refundAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<Booking, DateTime?, QAfterProperty> cancelledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<Booking, String?, QAfterProperty> cancellationReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<Booking, DateTime?, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<Booking, DateTime?, QAfterProperty> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }
}

extension BookingQueryProperty2<R> on QueryBuilder<Booking, R, QAfterProperty> {
  QueryBuilder<Booking, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Booking, (R, String), QAfterProperty> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Booking, (R, String), QAfterProperty> passagerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Booking, (R, String), QAfterProperty> trajetIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Booking, (R, int), QAfterProperty>
  nombrePlacesReserveesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<Booking, (R, String), QAfterProperty> statutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<Booking, (R, double?), QAfterProperty> montantTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<Booking, (R, double?), QAfterProperty>
  prixParPassagerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<Booking, (R, double?), QAfterProperty> amountPaidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<Booking, (R, String?), QAfterProperty> paymentMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<Booking, (R, bool), QAfterProperty>
  paiementConducteurConfirmeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<Booking, (R, int), QAfterProperty>
  cancellationPenaltyAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<Booking, (R, int), QAfterProperty> refundAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<Booking, (R, DateTime?), QAfterProperty> cancelledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<Booking, (R, String?), QAfterProperty>
  cancellationReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<Booking, (R, DateTime?), QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<Booking, (R, DateTime?), QAfterProperty> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }
}

extension BookingQueryProperty3<R1, R2>
    on QueryBuilder<Booking, (R1, R2), QAfterProperty> {
  QueryBuilder<Booking, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<Booking, (R1, R2, String), QOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Booking, (R1, R2, String), QOperations> passagerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Booking, (R1, R2, String), QOperations> trajetIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<Booking, (R1, R2, int), QOperations>
  nombrePlacesReserveesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<Booking, (R1, R2, String), QOperations> statutProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<Booking, (R1, R2, double?), QOperations> montantTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<Booking, (R1, R2, double?), QOperations>
  prixParPassagerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<Booking, (R1, R2, double?), QOperations> amountPaidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<Booking, (R1, R2, String?), QOperations>
  paymentMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<Booking, (R1, R2, bool), QOperations>
  paiementConducteurConfirmeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<Booking, (R1, R2, int), QOperations>
  cancellationPenaltyAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }

  QueryBuilder<Booking, (R1, R2, int), QOperations> refundAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(12);
    });
  }

  QueryBuilder<Booking, (R1, R2, DateTime?), QOperations>
  cancelledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(13);
    });
  }

  QueryBuilder<Booking, (R1, R2, String?), QOperations>
  cancellationReasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(14);
    });
  }

  QueryBuilder<Booking, (R1, R2, DateTime?), QOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(15);
    });
  }

  QueryBuilder<Booking, (R1, R2, DateTime?), QOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(16);
    });
  }
}
