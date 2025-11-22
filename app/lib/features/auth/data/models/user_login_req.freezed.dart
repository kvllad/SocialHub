// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_login_req.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserLoginReq {

@JsonKey(name: 'phone_number') String get phoneNumber; String get password;
/// Create a copy of UserLoginReq
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserLoginReqCopyWith<UserLoginReq> get copyWith => _$UserLoginReqCopyWithImpl<UserLoginReq>(this as UserLoginReq, _$identity);

  /// Serializes this UserLoginReq to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserLoginReq&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,password);

@override
String toString() {
  return 'UserLoginReq(phoneNumber: $phoneNumber, password: $password)';
}


}

/// @nodoc
abstract mixin class $UserLoginReqCopyWith<$Res>  {
  factory $UserLoginReqCopyWith(UserLoginReq value, $Res Function(UserLoginReq) _then) = _$UserLoginReqCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'phone_number') String phoneNumber, String password
});




}
/// @nodoc
class _$UserLoginReqCopyWithImpl<$Res>
    implements $UserLoginReqCopyWith<$Res> {
  _$UserLoginReqCopyWithImpl(this._self, this._then);

  final UserLoginReq _self;
  final $Res Function(UserLoginReq) _then;

/// Create a copy of UserLoginReq
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? password = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserLoginReq].
extension UserLoginReqPatterns on UserLoginReq {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserLoginReq value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserLoginReq() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserLoginReq value)  $default,){
final _that = this;
switch (_that) {
case _UserLoginReq():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserLoginReq value)?  $default,){
final _that = this;
switch (_that) {
case _UserLoginReq() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'phone_number')  String phoneNumber,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserLoginReq() when $default != null:
return $default(_that.phoneNumber,_that.password);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'phone_number')  String phoneNumber,  String password)  $default,) {final _that = this;
switch (_that) {
case _UserLoginReq():
return $default(_that.phoneNumber,_that.password);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'phone_number')  String phoneNumber,  String password)?  $default,) {final _that = this;
switch (_that) {
case _UserLoginReq() when $default != null:
return $default(_that.phoneNumber,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserLoginReq implements UserLoginReq {
  const _UserLoginReq({@JsonKey(name: 'phone_number') required this.phoneNumber, required this.password});
  factory _UserLoginReq.fromJson(Map<String, dynamic> json) => _$UserLoginReqFromJson(json);

@override@JsonKey(name: 'phone_number') final  String phoneNumber;
@override final  String password;

/// Create a copy of UserLoginReq
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserLoginReqCopyWith<_UserLoginReq> get copyWith => __$UserLoginReqCopyWithImpl<_UserLoginReq>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserLoginReqToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserLoginReq&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,password);

@override
String toString() {
  return 'UserLoginReq(phoneNumber: $phoneNumber, password: $password)';
}


}

/// @nodoc
abstract mixin class _$UserLoginReqCopyWith<$Res> implements $UserLoginReqCopyWith<$Res> {
  factory _$UserLoginReqCopyWith(_UserLoginReq value, $Res Function(_UserLoginReq) _then) = __$UserLoginReqCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'phone_number') String phoneNumber, String password
});




}
/// @nodoc
class __$UserLoginReqCopyWithImpl<$Res>
    implements _$UserLoginReqCopyWith<$Res> {
  __$UserLoginReqCopyWithImpl(this._self, this._then);

  final _UserLoginReq _self;
  final $Res Function(_UserLoginReq) _then;

/// Create a copy of UserLoginReq
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? password = null,}) {
  return _then(_UserLoginReq(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
