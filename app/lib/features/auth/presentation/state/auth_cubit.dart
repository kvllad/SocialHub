// import 'package:app/features/auth/data/repos/auth_repository.dart';
// import 'package:app/features/auth/presentation/state/auth_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit(AuthRepository repo) : _authRepository = repo, super(const AuthState(name: '123'));

//   final AuthRepository _authRepository;

//   Future<void> login() async {
//     emit(state(AuthS));
//     try {
//       await _authRepository.login();
//       emit(state.copyWith(status: AuthStatus.authenticated));
//     } catch (e) {
//       emit(state.copyWith(status: AuthStatus.unauthenticated));
//     }
//   }

//   Future<void> register({
//     required String name,
//     required String surname,
//     required String phoneNumber,
//     required String office,
//     required DateTime dateOfBirth,
//     required String department,
//     required List<String> interests,
//     required String grade,
//     required DateTime companyStartDate,
//     required String password,
//   }) async {
//     emit(state(AuthSt));
//     try {
//       await _authRepository.login();
//       emit(state.copyWith(status: AuthStatus.authenticated));
//     } catch (e) {
//       emit(state.copyWith(status: AuthStatus.unauthenticated));
//     }
//   }
// }
