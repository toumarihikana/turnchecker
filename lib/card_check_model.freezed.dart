// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'card_check_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CardCheckModel {
  int get id => throw _privateConstructorUsedError;
  String get cardName => throw _privateConstructorUsedError;
  bool get isCheck => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CardCheckModelCopyWith<CardCheckModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardCheckModelCopyWith<$Res> {
  factory $CardCheckModelCopyWith(
          CardCheckModel value, $Res Function(CardCheckModel) then) =
      _$CardCheckModelCopyWithImpl<$Res>;
  $Res call({int id, String cardName, bool isCheck});
}

/// @nodoc
class _$CardCheckModelCopyWithImpl<$Res>
    implements $CardCheckModelCopyWith<$Res> {
  _$CardCheckModelCopyWithImpl(this._value, this._then);

  final CardCheckModel _value;
  // ignore: unused_field
  final $Res Function(CardCheckModel) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? cardName = freezed,
    Object? isCheck = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cardName: cardName == freezed
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String,
      isCheck: isCheck == freezed
          ? _value.isCheck
          : isCheck // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_CardCheckModelListCopyWith<$Res>
    implements $CardCheckModelCopyWith<$Res> {
  factory _$$_CardCheckModelListCopyWith(_$_CardCheckModelList value,
          $Res Function(_$_CardCheckModelList) then) =
      __$$_CardCheckModelListCopyWithImpl<$Res>;
  @override
  $Res call({int id, String cardName, bool isCheck});
}

/// @nodoc
class __$$_CardCheckModelListCopyWithImpl<$Res>
    extends _$CardCheckModelCopyWithImpl<$Res>
    implements _$$_CardCheckModelListCopyWith<$Res> {
  __$$_CardCheckModelListCopyWithImpl(
      _$_CardCheckModelList _value, $Res Function(_$_CardCheckModelList) _then)
      : super(_value, (v) => _then(v as _$_CardCheckModelList));

  @override
  _$_CardCheckModelList get _value => super._value as _$_CardCheckModelList;

  @override
  $Res call({
    Object? id = freezed,
    Object? cardName = freezed,
    Object? isCheck = freezed,
  }) {
    return _then(_$_CardCheckModelList(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      cardName: cardName == freezed
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String,
      isCheck: isCheck == freezed
          ? _value.isCheck
          : isCheck // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CardCheckModelList implements _CardCheckModelList {
  _$_CardCheckModelList(
      {required this.id, required this.cardName, required this.isCheck});

  @override
  final int id;
  @override
  final String cardName;
  @override
  final bool isCheck;

  @override
  String toString() {
    return 'CardCheckModel(id: $id, cardName: $cardName, isCheck: $isCheck)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CardCheckModelList &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.cardName, cardName) &&
            const DeepCollectionEquality().equals(other.isCheck, isCheck));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(cardName),
      const DeepCollectionEquality().hash(isCheck));

  @JsonKey(ignore: true)
  @override
  _$$_CardCheckModelListCopyWith<_$_CardCheckModelList> get copyWith =>
      __$$_CardCheckModelListCopyWithImpl<_$_CardCheckModelList>(
          this, _$identity);
}

abstract class _CardCheckModelList implements CardCheckModel {
  factory _CardCheckModelList(
      {required final int id,
      required final String cardName,
      required final bool isCheck}) = _$_CardCheckModelList;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get cardName => throw _privateConstructorUsedError;
  @override
  bool get isCheck => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CardCheckModelListCopyWith<_$_CardCheckModelList> get copyWith =>
      throw _privateConstructorUsedError;
}
