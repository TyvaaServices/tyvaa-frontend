// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetUserCollection on Isar {
  IsarCollection<int, User> get users => this.collection();
}

final UserSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'User',
    idName: 'id',
    embedded: false,
    properties: [
      IsarPropertySchema(name: 'remoteId', type: IsarType.string),
      IsarPropertySchema(name: 'fullName', type: IsarType.string),
      IsarPropertySchema(name: 'phoneNumber', type: IsarType.string),
      IsarPropertySchema(name: 'email', type: IsarType.string),
      IsarPropertySchema(name: 'fcmToken', type: IsarType.string),
      IsarPropertySchema(name: 'birthDate', type: IsarType.dateTime),
      IsarPropertySchema(name: 'sexe', type: IsarType.string),
      IsarPropertySchema(name: 'isConducteurApproved', type: IsarType.bool),
      IsarPropertySchema(name: 'role', type: IsarType.string),
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
        name: 'phoneNumber',
        properties: ["phoneNumber"],
        unique: true,
        hash: false,
      ),
    ],
  ),
  converter: IsarObjectConverter<int, User>(
    serialize: serializeUser,
    deserialize: deserializeUser,
    deserializeProperty: deserializeUserProp,
  ),
  getEmbeddedSchemas: () => [],
);

@isarProtected
int serializeUser(IsarWriter writer, User object) {
  IsarCore.writeString(writer, 1, object.remoteId);
  IsarCore.writeString(writer, 2, object.fullName);
  IsarCore.writeString(writer, 3, object.phoneNumber);
  {
    final value = object.email;
    if (value == null) {
      IsarCore.writeNull(writer, 4);
    } else {
      IsarCore.writeString(writer, 4, value);
    }
  }
  {
    final value = object.fcmToken;
    if (value == null) {
      IsarCore.writeNull(writer, 5);
    } else {
      IsarCore.writeString(writer, 5, value);
    }
  }
  IsarCore.writeLong(
    writer,
    6,
    object.birthDate?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  {
    final value = object.sexe;
    if (value == null) {
      IsarCore.writeNull(writer, 7);
    } else {
      IsarCore.writeString(writer, 7, value);
    }
  }
  IsarCore.writeBool(writer, 8, value: object.isConducteurApproved);
  IsarCore.writeString(writer, 9, object.role);
  IsarCore.writeLong(
    writer,
    10,
    object.createdAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  IsarCore.writeLong(
    writer,
    11,
    object.updatedAt?.toUtc().microsecondsSinceEpoch ?? -9223372036854775808,
  );
  return object.id;
}

@isarProtected
User deserializeUser(IsarReader reader) {
  final object = User();
  object.id = IsarCore.readId(reader);
  object.remoteId = IsarCore.readString(reader, 1) ?? '';
  object.fullName = IsarCore.readString(reader, 2) ?? '';
  object.phoneNumber = IsarCore.readString(reader, 3) ?? '';
  object.email = IsarCore.readString(reader, 4);
  object.fcmToken = IsarCore.readString(reader, 5);
  {
    final value = IsarCore.readLong(reader, 6);
    if (value == -9223372036854775808) {
      object.birthDate = null;
    } else {
      object.birthDate = DateTime.fromMicrosecondsSinceEpoch(
        value,
        isUtc: true,
      ).toLocal();
    }
  }
  object.sexe = IsarCore.readString(reader, 7);
  object.isConducteurApproved = IsarCore.readBool(reader, 8);
  object.role = IsarCore.readString(reader, 9) ?? '';
  {
    final value = IsarCore.readLong(reader, 10);
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
    final value = IsarCore.readLong(reader, 11);
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
dynamic deserializeUserProp(IsarReader reader, int property) {
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
      return IsarCore.readString(reader, 4);
    case 5:
      return IsarCore.readString(reader, 5);
    case 6:
      {
        final value = IsarCore.readLong(reader, 6);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 7:
      return IsarCore.readString(reader, 7);
    case 8:
      return IsarCore.readBool(reader, 8);
    case 9:
      return IsarCore.readString(reader, 9) ?? '';
    case 10:
      {
        final value = IsarCore.readLong(reader, 10);
        if (value == -9223372036854775808) {
          return null;
        } else {
          return DateTime.fromMicrosecondsSinceEpoch(
            value,
            isUtc: true,
          ).toLocal();
        }
      }
    case 11:
      {
        final value = IsarCore.readLong(reader, 11);
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

sealed class _UserUpdate {
  bool call({
    required int id,
    String? remoteId,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? fcmToken,
    DateTime? birthDate,
    String? sexe,
    bool? isConducteurApproved,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

class _UserUpdateImpl implements _UserUpdate {
  const _UserUpdateImpl(this.collection);

  final IsarCollection<int, User> collection;

  @override
  bool call({
    required int id,
    Object? remoteId = ignore,
    Object? fullName = ignore,
    Object? phoneNumber = ignore,
    Object? email = ignore,
    Object? fcmToken = ignore,
    Object? birthDate = ignore,
    Object? sexe = ignore,
    Object? isConducteurApproved = ignore,
    Object? role = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    return collection.updateProperties(
          [id],
          {
            if (remoteId != ignore) 1: remoteId as String?,
            if (fullName != ignore) 2: fullName as String?,
            if (phoneNumber != ignore) 3: phoneNumber as String?,
            if (email != ignore) 4: email as String?,
            if (fcmToken != ignore) 5: fcmToken as String?,
            if (birthDate != ignore) 6: birthDate as DateTime?,
            if (sexe != ignore) 7: sexe as String?,
            if (isConducteurApproved != ignore)
              8: isConducteurApproved as bool?,
            if (role != ignore) 9: role as String?,
            if (createdAt != ignore) 10: createdAt as DateTime?,
            if (updatedAt != ignore) 11: updatedAt as DateTime?,
          },
        ) >
        0;
  }
}

sealed class _UserUpdateAll {
  int call({
    required List<int> id,
    String? remoteId,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? fcmToken,
    DateTime? birthDate,
    String? sexe,
    bool? isConducteurApproved,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

class _UserUpdateAllImpl implements _UserUpdateAll {
  const _UserUpdateAllImpl(this.collection);

  final IsarCollection<int, User> collection;

  @override
  int call({
    required List<int> id,
    Object? remoteId = ignore,
    Object? fullName = ignore,
    Object? phoneNumber = ignore,
    Object? email = ignore,
    Object? fcmToken = ignore,
    Object? birthDate = ignore,
    Object? sexe = ignore,
    Object? isConducteurApproved = ignore,
    Object? role = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    return collection.updateProperties(id, {
      if (remoteId != ignore) 1: remoteId as String?,
      if (fullName != ignore) 2: fullName as String?,
      if (phoneNumber != ignore) 3: phoneNumber as String?,
      if (email != ignore) 4: email as String?,
      if (fcmToken != ignore) 5: fcmToken as String?,
      if (birthDate != ignore) 6: birthDate as DateTime?,
      if (sexe != ignore) 7: sexe as String?,
      if (isConducteurApproved != ignore) 8: isConducteurApproved as bool?,
      if (role != ignore) 9: role as String?,
      if (createdAt != ignore) 10: createdAt as DateTime?,
      if (updatedAt != ignore) 11: updatedAt as DateTime?,
    });
  }
}

extension UserUpdate on IsarCollection<int, User> {
  _UserUpdate get update => _UserUpdateImpl(this);

  _UserUpdateAll get updateAll => _UserUpdateAllImpl(this);
}

sealed class _UserQueryUpdate {
  int call({
    String? remoteId,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? fcmToken,
    DateTime? birthDate,
    String? sexe,
    bool? isConducteurApproved,
    String? role,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

class _UserQueryUpdateImpl implements _UserQueryUpdate {
  const _UserQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<User> query;
  final int? limit;

  @override
  int call({
    Object? remoteId = ignore,
    Object? fullName = ignore,
    Object? phoneNumber = ignore,
    Object? email = ignore,
    Object? fcmToken = ignore,
    Object? birthDate = ignore,
    Object? sexe = ignore,
    Object? isConducteurApproved = ignore,
    Object? role = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (remoteId != ignore) 1: remoteId as String?,
      if (fullName != ignore) 2: fullName as String?,
      if (phoneNumber != ignore) 3: phoneNumber as String?,
      if (email != ignore) 4: email as String?,
      if (fcmToken != ignore) 5: fcmToken as String?,
      if (birthDate != ignore) 6: birthDate as DateTime?,
      if (sexe != ignore) 7: sexe as String?,
      if (isConducteurApproved != ignore) 8: isConducteurApproved as bool?,
      if (role != ignore) 9: role as String?,
      if (createdAt != ignore) 10: createdAt as DateTime?,
      if (updatedAt != ignore) 11: updatedAt as DateTime?,
    });
  }
}

extension UserQueryUpdate on IsarQuery<User> {
  _UserQueryUpdate get updateFirst => _UserQueryUpdateImpl(this, limit: 1);

  _UserQueryUpdate get updateAll => _UserQueryUpdateImpl(this);
}

class _UserQueryBuilderUpdateImpl implements _UserQueryUpdate {
  const _UserQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<User, User, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? remoteId = ignore,
    Object? fullName = ignore,
    Object? phoneNumber = ignore,
    Object? email = ignore,
    Object? fcmToken = ignore,
    Object? birthDate = ignore,
    Object? sexe = ignore,
    Object? isConducteurApproved = ignore,
    Object? role = ignore,
    Object? createdAt = ignore,
    Object? updatedAt = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (remoteId != ignore) 1: remoteId as String?,
        if (fullName != ignore) 2: fullName as String?,
        if (phoneNumber != ignore) 3: phoneNumber as String?,
        if (email != ignore) 4: email as String?,
        if (fcmToken != ignore) 5: fcmToken as String?,
        if (birthDate != ignore) 6: birthDate as DateTime?,
        if (sexe != ignore) 7: sexe as String?,
        if (isConducteurApproved != ignore) 8: isConducteurApproved as bool?,
        if (role != ignore) 9: role as String?,
        if (createdAt != ignore) 10: createdAt as DateTime?,
        if (updatedAt != ignore) 11: updatedAt as DateTime?,
      });
    } finally {
      q.close();
    }
  }
}

extension UserQueryBuilderUpdate on QueryBuilder<User, User, QOperations> {
  _UserQueryUpdate get updateFirst =>
      _UserQueryBuilderUpdateImpl(this, limit: 1);

  _UserQueryUpdate get updateAll => _UserQueryBuilderUpdateImpl(this);
}

extension UserQueryFilter on QueryBuilder<User, User, QFilterCondition> {
  QueryBuilder<User, User, QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idGreaterThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idLessThan(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 0, value: value));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 0, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> idBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 0, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdGreaterThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 1, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdLessThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdContains(
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

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdMatches(
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

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 1, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fullNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fullNameGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition> fullNameGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<User, User, QAfterFilterCondition> fullNameLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 2, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fullNameLessThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> fullNameBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> fullNameStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> fullNameEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> fullNameContains(
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

  QueryBuilder<User, User, QAfterFilterCondition> fullNameMatches(
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

  QueryBuilder<User, User, QAfterFilterCondition> fullNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fullNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 2, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberGreaterThan(
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

  QueryBuilder<User, User, QAfterFilterCondition>
  phoneNumberGreaterThanOrEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 3, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberLessThanOrEqualTo(
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

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberBetween(
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

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberContains(
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

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberMatches(
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

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> phoneNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 3, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 4));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailGreaterThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 4, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailLessThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailBetween(
    String? lower,
    String? upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 4, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 5));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenGreaterThan(
    String? value, {
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

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenGreaterThanOrEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 5, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenLessThanOrEqualTo(
    String? value, {
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

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenContains(
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

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenMatches(
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

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> fcmTokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 5, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> birthDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> birthDateIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 6));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> birthDateEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> birthDateGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> birthDateGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> birthDateLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(LessCondition(property: 6, value: value));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> birthDateLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 6, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> birthDateBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 6, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> sexeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> sexeIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 7));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> sexeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> sexeGreaterThan(
    String? value, {
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

  QueryBuilder<User, User, QAfterFilterCondition> sexeGreaterThanOrEqualTo(
    String? value, {
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

  QueryBuilder<User, User, QAfterFilterCondition> sexeLessThan(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 7, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> sexeLessThanOrEqualTo(
    String? value, {
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

  QueryBuilder<User, User, QAfterFilterCondition> sexeBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<User, User, QAfterFilterCondition> sexeStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> sexeEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> sexeContains(
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

  QueryBuilder<User, User, QAfterFilterCondition> sexeMatches(
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

  QueryBuilder<User, User, QAfterFilterCondition> sexeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> sexeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 7, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> isConducteurApprovedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 8, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> roleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> roleGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<User, User, QAfterFilterCondition> roleGreaterThanOrEqualTo(
    String value, {
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

  QueryBuilder<User, User, QAfterFilterCondition> roleLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 9, value: value, caseSensitive: caseSensitive),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> roleLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
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

  QueryBuilder<User, User, QAfterFilterCondition> roleBetween(
    String lower,
    String upper, {
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

  QueryBuilder<User, User, QAfterFilterCondition> roleStartsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> roleEndsWith(
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

  QueryBuilder<User, User, QAfterFilterCondition> roleContains(
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

  QueryBuilder<User, User, QAfterFilterCondition> roleMatches(
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

  QueryBuilder<User, User, QAfterFilterCondition> roleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> roleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(property: 9, value: ''),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> createdAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 10));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> createdAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> createdAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> createdAtGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> createdAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> createdAtLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 10, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> createdAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 10, lower: lower, upper: upper),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> updatedAtIsNotNull() {
    return QueryBuilder.apply(not(), (query) {
      return query.addFilterCondition(const IsNullCondition(property: 11));
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> updatedAtEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> updatedAtGreaterThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> updatedAtLessThan(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> updatedAtLessThanOrEqualTo(
    DateTime? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(property: 11, value: value),
      );
    });
  }

  QueryBuilder<User, User, QAfterFilterCondition> updatedAtBetween(
    DateTime? lower,
    DateTime? upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(property: 11, lower: lower, upper: upper),
      );
    });
  }
}

extension UserQueryObject on QueryBuilder<User, User, QFilterCondition> {}

extension UserQuerySortBy on QueryBuilder<User, User, QSortBy> {
  QueryBuilder<User, User, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByRemoteIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByFullName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByFullNameDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByPhoneNumber({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByPhoneNumberDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByEmail({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByEmailDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByFcmToken({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByFcmTokenDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByBirthDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByBirthDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortBySexe({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortBySexeDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByIsConducteurApproved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByIsConducteurApprovedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByRole({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByRoleDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }
}

extension UserQuerySortThenBy on QueryBuilder<User, User, QSortThenBy> {
  QueryBuilder<User, User, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(0, sort: Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByRemoteIdDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByFullName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByFullNameDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByPhoneNumber({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByPhoneNumberDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByEmail({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByEmailDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByFcmToken({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByFcmTokenDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(5, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByBirthDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByBirthDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(6, sort: Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenBySexe({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenBySexeDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(7, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByIsConducteurApproved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByIsConducteurApprovedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(8, sort: Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByRole({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByRoleDesc({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(9, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(10, sort: Sort.desc);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11);
    });
  }

  QueryBuilder<User, User, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(11, sort: Sort.desc);
    });
  }
}

extension UserQueryWhereDistinct on QueryBuilder<User, User, QDistinct> {
  QueryBuilder<User, User, QAfterDistinct> distinctByRemoteId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByFullName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByPhoneNumber({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByEmail({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByFcmToken({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByBirthDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(6);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctBySexe({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(7, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByIsConducteurApproved() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(8);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByRole({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(9, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(10);
    });
  }

  QueryBuilder<User, User, QAfterDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(11);
    });
  }
}

extension UserQueryProperty1 on QueryBuilder<User, User, QProperty> {
  QueryBuilder<User, int, QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<User, String, QAfterProperty> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<User, String, QAfterProperty> fullNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<User, String, QAfterProperty> phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<User, String?, QAfterProperty> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<User, String?, QAfterProperty> fcmTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<User, DateTime?, QAfterProperty> birthDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<User, String?, QAfterProperty> sexeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<User, bool, QAfterProperty> isConducteurApprovedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<User, String, QAfterProperty> roleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<User, DateTime?, QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<User, DateTime?, QAfterProperty> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension UserQueryProperty2<R> on QueryBuilder<User, R, QAfterProperty> {
  QueryBuilder<User, (R, int), QAfterProperty> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<User, (R, String), QAfterProperty> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<User, (R, String), QAfterProperty> fullNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<User, (R, String), QAfterProperty> phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<User, (R, String?), QAfterProperty> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<User, (R, String?), QAfterProperty> fcmTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<User, (R, DateTime?), QAfterProperty> birthDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<User, (R, String?), QAfterProperty> sexeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<User, (R, bool), QAfterProperty> isConducteurApprovedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<User, (R, String), QAfterProperty> roleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<User, (R, DateTime?), QAfterProperty> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<User, (R, DateTime?), QAfterProperty> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}

extension UserQueryProperty3<R1, R2>
    on QueryBuilder<User, (R1, R2), QAfterProperty> {
  QueryBuilder<User, (R1, R2, int), QOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(0);
    });
  }

  QueryBuilder<User, (R1, R2, String), QOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<User, (R1, R2, String), QOperations> fullNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<User, (R1, R2, String), QOperations> phoneNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<User, (R1, R2, String?), QOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<User, (R1, R2, String?), QOperations> fcmTokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }

  QueryBuilder<User, (R1, R2, DateTime?), QOperations> birthDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(6);
    });
  }

  QueryBuilder<User, (R1, R2, String?), QOperations> sexeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(7);
    });
  }

  QueryBuilder<User, (R1, R2, bool), QOperations>
  isConducteurApprovedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(8);
    });
  }

  QueryBuilder<User, (R1, R2, String), QOperations> roleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(9);
    });
  }

  QueryBuilder<User, (R1, R2, DateTime?), QOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(10);
    });
  }

  QueryBuilder<User, (R1, R2, DateTime?), QOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(11);
    });
  }
}
