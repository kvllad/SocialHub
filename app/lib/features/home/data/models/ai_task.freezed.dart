// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiTask {

 int get task_id; String get name; int get coin_reward; String get expires_at;
/// Create a copy of AiTask
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiTaskCopyWith<AiTask> get copyWith => _$AiTaskCopyWithImpl<AiTask>(this as AiTask, _$identity);

  /// Serializes this AiTask to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiTask&&(identical(other.task_id, task_id) || other.task_id == task_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coin_reward, coin_reward) || other.coin_reward == coin_reward)&&(identical(other.expires_at, expires_at) || other.expires_at == expires_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,task_id,name,coin_reward,expires_at);

@override
String toString() {
  return 'AiTask(task_id: $task_id, name: $name, coin_reward: $coin_reward, expires_at: $expires_at)';
}


}

/// @nodoc
abstract mixin class $AiTaskCopyWith<$Res>  {
  factory $AiTaskCopyWith(AiTask value, $Res Function(AiTask) _then) = _$AiTaskCopyWithImpl;
@useResult
$Res call({
 int task_id, String name, int coin_reward, String expires_at
});




}
/// @nodoc
class _$AiTaskCopyWithImpl<$Res>
    implements $AiTaskCopyWith<$Res> {
  _$AiTaskCopyWithImpl(this._self, this._then);

  final AiTask _self;
  final $Res Function(AiTask) _then;

/// Create a copy of AiTask
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? task_id = null,Object? name = null,Object? coin_reward = null,Object? expires_at = null,}) {
  return _then(_self.copyWith(
task_id: null == task_id ? _self.task_id : task_id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coin_reward: null == coin_reward ? _self.coin_reward : coin_reward // ignore: cast_nullable_to_non_nullable
as int,expires_at: null == expires_at ? _self.expires_at : expires_at // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiTask].
extension AiTaskPatterns on AiTask {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiTask value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiTask() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiTask value)  $default,){
final _that = this;
switch (_that) {
case _AiTask():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiTask value)?  $default,){
final _that = this;
switch (_that) {
case _AiTask() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int task_id,  String name,  int coin_reward,  String expires_at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiTask() when $default != null:
return $default(_that.task_id,_that.name,_that.coin_reward,_that.expires_at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int task_id,  String name,  int coin_reward,  String expires_at)  $default,) {final _that = this;
switch (_that) {
case _AiTask():
return $default(_that.task_id,_that.name,_that.coin_reward,_that.expires_at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int task_id,  String name,  int coin_reward,  String expires_at)?  $default,) {final _that = this;
switch (_that) {
case _AiTask() when $default != null:
return $default(_that.task_id,_that.name,_that.coin_reward,_that.expires_at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiTask implements AiTask {
  const _AiTask({required this.task_id, required this.name, required this.coin_reward, required this.expires_at});
  factory _AiTask.fromJson(Map<String, dynamic> json) => _$AiTaskFromJson(json);

@override final  int task_id;
@override final  String name;
@override final  int coin_reward;
@override final  String expires_at;

/// Create a copy of AiTask
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiTaskCopyWith<_AiTask> get copyWith => __$AiTaskCopyWithImpl<_AiTask>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiTaskToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiTask&&(identical(other.task_id, task_id) || other.task_id == task_id)&&(identical(other.name, name) || other.name == name)&&(identical(other.coin_reward, coin_reward) || other.coin_reward == coin_reward)&&(identical(other.expires_at, expires_at) || other.expires_at == expires_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,task_id,name,coin_reward,expires_at);

@override
String toString() {
  return 'AiTask(task_id: $task_id, name: $name, coin_reward: $coin_reward, expires_at: $expires_at)';
}


}

/// @nodoc
abstract mixin class _$AiTaskCopyWith<$Res> implements $AiTaskCopyWith<$Res> {
  factory _$AiTaskCopyWith(_AiTask value, $Res Function(_AiTask) _then) = __$AiTaskCopyWithImpl;
@override @useResult
$Res call({
 int task_id, String name, int coin_reward, String expires_at
});




}
/// @nodoc
class __$AiTaskCopyWithImpl<$Res>
    implements _$AiTaskCopyWith<$Res> {
  __$AiTaskCopyWithImpl(this._self, this._then);

  final _AiTask _self;
  final $Res Function(_AiTask) _then;

/// Create a copy of AiTask
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? task_id = null,Object? name = null,Object? coin_reward = null,Object? expires_at = null,}) {
  return _then(_AiTask(
task_id: null == task_id ? _self.task_id : task_id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,coin_reward: null == coin_reward ? _self.coin_reward : coin_reward // ignore: cast_nullable_to_non_nullable
as int,expires_at: null == expires_at ? _self.expires_at : expires_at // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
