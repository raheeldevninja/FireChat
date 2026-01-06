import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat/shared/domain/entities/user_entity.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {

  const UserDto._();

  factory UserDto({
    required String id,
    required String email,
    required String name,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  factory UserDto.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    return UserDto(
        id: doc.id,
        email: data['email'] as String,
        name: data['name'] as String,
    );

  }

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
      'nane': name,
    };
  }

}

extension UserDtoMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
        id: id,
        email: email,
        name: name,
    );
  }
}
