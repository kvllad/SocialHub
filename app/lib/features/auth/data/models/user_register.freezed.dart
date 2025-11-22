// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_register.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRegister {

 String get name; String get surname;@JsonKey(name: 'phone_number') String get phoneNumber; String get office;@JsonKey(name: 'date_of_birth') DateTime get dateOfBirth; String get department; List<String> get interests; String get grade;@JsonKey(name: 'company_start_date') DateTime get companyStartDate; String get password;
/// Create a copy of UserRegister
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRegisterCopyWith<UserRegister> get copyWith => _$UserRegisterCopyWithImpl<UserRegister>(this as UserRegister, _$identity);

  /// Serializes this UserRegister to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRegister&&(identical(other.name, name) || other.name == name)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.office, office) || other.office == office)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.department, department) || other.department == department)&&const DeepCollectionEquality().equals(other.interests, interests)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.companyStartDate, companyStartDate) || other.companyStartDate == companyStartDate)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,surname,phoneNumber,office,dateOfBirth,department,const DeepCollectionEquality().hash(interests),grade,companyStartDate,password);

@override
String toString() {
  return 'UserRegister(name: $name, surname: $surname, phoneNumber: $phoneNumber, office: $office, dateOfBirth: $dateOfBirth, department: $department, interests: $interests, grade: $grade, companyStartDate: $companyStartDate, password: $password)';
}


}

/// @nodoc
abstract mixin class $UserRegisterCopyWith<$Res>  {
  factory $UserRegisterCopyWith(UserRegister value, $Res Function(UserRegister) _then) = _$UserRegisterCopyWithImpl;
@useResult
$Res call({
 String name, String surname,@JsonKey(name: 'phone_number') String phoneNumber, String office,@JsonKey(name: 'date_of_birth') DateTime dateOfBirth, String department, List<String> interests, String grade,@JsonKey(name: 'company_start_date') DateTime companyStartDate, String password
});




}
/// @nodoc
class _$UserRegisterCopyWithImpl<$Res>
    implements $UserRegisterCopyWith<$Res> {
  _$UserRegisterCopyWithImpl(this._self, this._then);

  final UserRegister _self;
  final $Res Function(UserRegister) _then;

/// Create a copy of UserRegister
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? surname = null,Object? phoneNumber = null,Object? office = null,Object? dateOfBirth = null,Object? department = null,Object? interests = null,Object? grade = null,Object? companyStartDate = null,Object? password = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,surname: null == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,office: null == office ? _self.office : office // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self.interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,companyStartDate: null == companyStartDate ? _self.companyStartDate : companyStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRegister].
extension UserRegisterPatterns on UserRegister {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRegister value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRegister() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRegister value)  $default,){
final _that = this;
switch (_that) {
case _UserRegister():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRegister value)?  $default,){
final _that = this;
switch (_that) {
case _UserRegister() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String surname, @JsonKey(name: 'phone_number')  String phoneNumber,  String office, @JsonKey(name: 'date_of_birth')  DateTime dateOfBirth,  String department,  List<String> interests,  String grade, @JsonKey(name: 'company_start_date')  DateTime companyStartDate,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRegister() when $default != null:
return $default(_that.name,_that.surname,_that.phoneNumber,_that.office,_that.dateOfBirth,_that.department,_that.interests,_that.grade,_that.companyStartDate,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String surname, @JsonKey(name: 'phone_number')  String phoneNumber,  String office, @JsonKey(name: 'date_of_birth')  DateTime dateOfBirth,  String department,  List<String> interests,  String grade, @JsonKey(name: 'company_start_date')  DateTime companyStartDate,  String password)  $default,) {final _that = this;
switch (_that) {
case _UserRegister():
return $default(_that.name,_that.surname,_that.phoneNumber,_that.office,_that.dateOfBirth,_that.department,_that.interests,_that.grade,_that.companyStartDate,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String surname, @JsonKey(name: 'phone_number')  String phoneNumber,  String office, @JsonKey(name: 'date_of_birth')  DateTime dateOfBirth,  String department,  List<String> interests,  String grade, @JsonKey(name: 'company_start_date')  DateTime companyStartDate,  String password)?  $default,) {final _that = this;
switch (_that) {
case _UserRegister() when $default != null:
return $default(_that.name,_that.surname,_that.phoneNumber,_that.office,_that.dateOfBirth,_that.department,_that.interests,_that.grade,_that.companyStartDate,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRegister implements UserRegister {
   _UserRegister({required this.name, required this.surname, @JsonKey(name: 'phone_number') required this.phoneNumber, required this.office, @JsonKey(name: 'date_of_birth') required this.dateOfBirth, required this.department, required final  List<String> interests, required this.grade, @JsonKey(name: 'company_start_date') required this.companyStartDate, required this.password}): _interests = interests;
  factory _UserRegister.fromJson(Map<String, dynamic> json) => _$UserRegisterFromJson(json);

@override final  String name;
@override final  String surname;
@override@JsonKey(name: 'phone_number') final  String phoneNumber;
@override final  String office;
@override@JsonKey(name: 'date_of_birth') final  DateTime dateOfBirth;
@override final  String department;
 final  List<String> _interests;
@override List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}

@override final  String grade;
@override@JsonKey(name: 'company_start_date') final  DateTime companyStartDate;
@override final  String password;

/// Create a copy of UserRegister
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRegisterCopyWith<_UserRegister> get copyWith => __$UserRegisterCopyWithImpl<_UserRegister>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRegisterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRegister&&(identical(other.name, name) || other.name == name)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.office, office) || other.office == office)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.department, department) || other.department == department)&&const DeepCollectionEquality().equals(other._interests, _interests)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.companyStartDate, companyStartDate) || other.companyStartDate == companyStartDate)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,surname,phoneNumber,office,dateOfBirth,department,const DeepCollectionEquality().hash(_interests),grade,companyStartDate,password);

@override
String toString() {
  return 'UserRegister(name: $name, surname: $surname, phoneNumber: $phoneNumber, office: $office, dateOfBirth: $dateOfBirth, department: $department, interests: $interests, grade: $grade, companyStartDate: $companyStartDate, password: $password)';
}


}

/// @nodoc
abstract mixin class _$UserRegisterCopyWith<$Res> implements $UserRegisterCopyWith<$Res> {
  factory _$UserRegisterCopyWith(_UserRegister value, $Res Function(_UserRegister) _then) = __$UserRegisterCopyWithImpl;
@override @useResult
$Res call({
 String name, String surname,@JsonKey(name: 'phone_number') String phoneNumber, String office,@JsonKey(name: 'date_of_birth') DateTime dateOfBirth, String department, List<String> interests, String grade,@JsonKey(name: 'company_start_date') DateTime companyStartDate, String password
});




}
/// @nodoc
class __$UserRegisterCopyWithImpl<$Res>
    implements _$UserRegisterCopyWith<$Res> {
  __$UserRegisterCopyWithImpl(this._self, this._then);

  final _UserRegister _self;
  final $Res Function(_UserRegister) _then;

/// Create a copy of UserRegister
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? surname = null,Object? phoneNumber = null,Object? office = null,Object? dateOfBirth = null,Object? department = null,Object? interests = null,Object? grade = null,Object? companyStartDate = null,Object? password = null,}) {
  return _then(_UserRegister(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,surname: null == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,office: null == office ? _self.office : office // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,interests: null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,grade: null == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as String,companyStartDate: null == companyStartDate ? _self.companyStartDate : companyStartDate // ignore: cast_nullable_to_non_nullable
as DateTime,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
