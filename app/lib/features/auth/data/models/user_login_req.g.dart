// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserLoginReq _$UserLoginReqFromJson(Map<String, dynamic> json) =>
    _UserLoginReq(
      phoneNumber: json['phone_number'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserLoginReqToJson(_UserLoginReq instance) =>
    <String, dynamic>{
      'phone_number': instance.phoneNumber,
      'password': instance.password,
    };
