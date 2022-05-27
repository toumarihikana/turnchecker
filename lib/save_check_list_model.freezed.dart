// // coverage:ignore-file
// // GENERATED CODE - DO NOT MODIFY BY HAND
// // ignore_for_file: type=lint
// // ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

// part of 'save_check_list_model.dart';

// // **************************************************************************
// // FreezedGenerator
// // **************************************************************************

// T _$identity<T>(T value) => value;

// final _privateConstructorUsedError = UnsupportedError(
//     'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

// SaveCheckListModel _$SaveCheckListModelFromJson(Map<String, dynamic> json) {
//   return _SaveCheckList.fromJson(json);
// }

// /// @nodoc
// mixin _$SaveCheckListModel {
//   List<Profile> get profiles => throw _privateConstructorUsedError;

//   Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
//   @JsonKey(ignore: true)
//   $SaveCheckListModelCopyWith<SaveCheckListModel> get copyWith =>
//       throw _privateConstructorUsedError;
// }

// /// @nodoc
// abstract class $SaveCheckListModelCopyWith<$Res> {
//   factory $SaveCheckListModelCopyWith(
//           SaveCheckListModel value, $Res Function(SaveCheckListModel) then) =
//       _$SaveCheckListModelCopyWithImpl<$Res>;
//   $Res call({List<Profile> profiles});
// }

// /// @nodoc
// class _$SaveCheckListModelCopyWithImpl<$Res>
//     implements $SaveCheckListModelCopyWith<$Res> {
//   _$SaveCheckListModelCopyWithImpl(this._value, this._then);

//   final SaveCheckListModel _value;
//   // ignore: unused_field
//   final $Res Function(SaveCheckListModel) _then;

//   @override
//   $Res call({
//     Object? profiles = freezed,
//   }) {
//     return _then(_value.copyWith(
//       profiles: profiles == freezed
//           ? _value.profiles
//           : profiles // ignore: cast_nullable_to_non_nullable
//               as List<Profile>,
//     ));
//   }
// }

// /// @nodoc
// abstract class _$$_SaveCheckListCopyWith<$Res>
//     implements $SaveCheckListModelCopyWith<$Res> {
//   factory _$$_SaveCheckListCopyWith(
//           _$_SaveCheckList value, $Res Function(_$_SaveCheckList) then) =
//       __$$_SaveCheckListCopyWithImpl<$Res>;
//   @override
//   $Res call({List<Profile> profiles});
// }

// /// @nodoc
// class __$$_SaveCheckListCopyWithImpl<$Res>
//     extends _$SaveCheckListModelCopyWithImpl<$Res>
//     implements _$$_SaveCheckListCopyWith<$Res> {
//   __$$_SaveCheckListCopyWithImpl(
//       _$_SaveCheckList _value, $Res Function(_$_SaveCheckList) _then)
//       : super(_value, (v) => _then(v as _$_SaveCheckList));

//   @override
//   _$_SaveCheckList get _value => super._value as _$_SaveCheckList;

//   @override
//   $Res call({
//     Object? profiles = freezed,
//   }) {
//     return _then(_$_SaveCheckList(
//       profiles: profiles == freezed
//           ? _value._profiles
//           : profiles // ignore: cast_nullable_to_non_nullable
//               as List<Profile>,
//     ));
//   }
// }

// /// @nodoc
// @JsonSerializable()
// class _$_SaveCheckList implements _SaveCheckList {
//   _$_SaveCheckList({required final List<Profile> profiles})
//       : _profiles = profiles;

//   factory _$_SaveCheckList.fromJson(Map<String, dynamic> json) =>
//       _$$_SaveCheckListFromJson(json);

//   final List<Profile> _profiles;
//   @override
//   List<Profile> get profiles {
//     // ignore: implicit_dynamic_type
//     return EqualUnmodifiableListView(_profiles);
//   }

//   @override
//   String toString() {
//     return 'SaveCheckListModel(profiles: $profiles)';
//   }

//   @override
//   bool operator ==(dynamic other) {
//     return identical(this, other) ||
//         (other.runtimeType == runtimeType &&
//             other is _$_SaveCheckList &&
//             const DeepCollectionEquality().equals(other._profiles, _profiles));
//   }

//   @JsonKey(ignore: true)
//   @override
//   int get hashCode =>
//       Object.hash(runtimeType, const DeepCollectionEquality().hash(_profiles));

//   @JsonKey(ignore: true)
//   @override
//   _$$_SaveCheckListCopyWith<_$_SaveCheckList> get copyWith =>
//       __$$_SaveCheckListCopyWithImpl<_$_SaveCheckList>(this, _$identity);

//   @override
//   Map<String, dynamic> toJson() {
//     return _$$_SaveCheckListToJson(this);
//   }
// }

// abstract class _SaveCheckList implements SaveCheckListModel {
//   factory _SaveCheckList({required final List<Profile> profiles}) =
//       _$_SaveCheckList;

//   factory _SaveCheckList.fromJson(Map<String, dynamic> json) =
//       _$_SaveCheckList.fromJson;

//   @override
//   List<Profile> get profiles => throw _privateConstructorUsedError;
//   @override
//   @JsonKey(ignore: true)
//   _$$_SaveCheckListCopyWith<_$_SaveCheckList> get copyWith =>
//       throw _privateConstructorUsedError;
// }
