import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.idle() = _AuthStateIdle;
  const factory AuthState.loading() = _AuthStateLoading;
  const factory AuthState.success() = _AuthStateSuccess;
  const factory AuthState.failure() = _AuthStateFailure;
}
