// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserRegister _$UserRegisterFromJson(Map<String, dynamic> json) =>
    _UserRegister(
      name: json['name'] as String,
      surname: json['surname'] as String,
      phoneNumber: json['phone_number'] as String,
      office: json['office'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      department: json['department'] as String,
      interests: (json['interests'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      grade: json['grade'] as String,
      companyStartDate: json['company_start_date'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserRegisterToJson(_UserRegister instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'phone_number': instance.phoneNumber,
      'office': instance.office,
      'date_of_birth': instance.dateOfBirth,
      'department': instance.department,
      'interests': instance.interests,
      'grade': instance.grade,
      'company_start_date': instance.companyStartDate,
      'password': instance.password,
    };
