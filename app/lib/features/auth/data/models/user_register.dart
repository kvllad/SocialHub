import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_register.freezed.dart';
part 'user_register.g.dart';

@freezed
abstract class UserRegister with _$UserRegister {
  factory UserRegister({
    required String name,
    required String surname,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required String office,
    @JsonKey(name: 'date_of_birth') required String dateOfBirth,
    required String department,
    required List<String> interests,
    required String grade,
    @JsonKey(name: 'company_start_date') required String companyStartDate,
    required String password,
  }) = _UserRegister;

  factory UserRegister.fromJson(Map<String, dynamic> json) => _$UserRegisterFromJson(json);
}
