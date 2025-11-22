// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _AuthStateIdle value)?  idle,TResult Function( _AuthStateLoading value)?  loading,TResult Function( _AuthStateSuccess value)?  success,TResult Function( _AuthStateFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthStateIdle() when idle != null:
return idle(_that);case _AuthStateLoading() when loading != null:
return loading(_that);case _AuthStateSuccess() when success != null:
return success(_that);case _AuthStateFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _AuthStateIdle value)  idle,required TResult Function( _AuthStateLoading value)  loading,required TResult Function( _AuthStateSuccess value)  success,required TResult Function( _AuthStateFailure value)  failure,}){
final _that = this;
switch (_that) {
case _AuthStateIdle():
return idle(_that);case _AuthStateLoading():
return loading(_that);case _AuthStateSuccess():
return success(_that);case _AuthStateFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _AuthStateIdle value)?  idle,TResult? Function( _AuthStateLoading value)?  loading,TResult? Function( _AuthStateSuccess value)?  success,TResult? Function( _AuthStateFailure value)?  failure,}){
final _that = this;
switch (_that) {
case _AuthStateIdle() when idle != null:
return idle(_that);case _AuthStateLoading() when loading != null:
return loading(_that);case _AuthStateSuccess() when success != null:
return success(_that);case _AuthStateFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function()?  loading,TResult Function()?  success,TResult Function()?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthStateIdle() when idle != null:
return idle();case _AuthStateLoading() when loading != null:
return loading();case _AuthStateSuccess() when success != null:
return success();case _AuthStateFailure() when failure != null:
return failure();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function()  loading,required TResult Function()  success,required TResult Function()  failure,}) {final _that = this;
switch (_that) {
case _AuthStateIdle():
return idle();case _AuthStateLoading():
return loading();case _AuthStateSuccess():
return success();case _AuthStateFailure():
return failure();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function()?  loading,TResult? Function()?  success,TResult? Function()?  failure,}) {final _that = this;
switch (_that) {
case _AuthStateIdle() when idle != null:
return idle();case _AuthStateLoading() when loading != null:
return loading();case _AuthStateSuccess() when success != null:
return success();case _AuthStateFailure() when failure != null:
return failure();case _:
  return null;

}
}

}

/// @nodoc


class _AuthStateIdle implements AuthState {
  const _AuthStateIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.idle()';
}


}




/// @nodoc


class _AuthStateLoading implements AuthState {
  const _AuthStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class _AuthStateSuccess implements AuthState {
  const _AuthStateSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.success()';
}


}




/// @nodoc


class _AuthStateFailure implements AuthState {
  const _AuthStateFailure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthStateFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.failure()';
}


}




// dart format on
