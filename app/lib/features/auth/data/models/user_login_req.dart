import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_login_req.freezed.dart';
part 'user_login_req.g.dart';

@freezed
abstract class UserLoginReq with _$UserLoginReq {
  const factory UserLoginReq({
    @JsonKey(name: 'phone_number')
    required String phoneNumber,
    required String password,
  }) = _UserLoginReq;

  factory UserLoginReq.fromJson(Map<String, dynamic> json) => _$UserLoginReqFromJson(json);
}
