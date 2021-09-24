/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _username;
  final String? _firstName;
  final String? _lastName;
  final bool? _isVerified;
  final String? _profilePicUrl;
  final String? _email;
  final TemporalDateTime? _createdOn;
  final TemporalDateTime? _updatedOn;
  final List<Post>? _posts;
  final List<ChatUser>? _chats;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get firstName {
    try {
      return _firstName!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get lastName {
    return _lastName;
  }
  
  bool? get isVerified {
    return _isVerified;
  }
  
  String? get profilePicUrl {
    return _profilePicUrl;
  }
  
  String? get email {
    return _email;
  }
  
  TemporalDateTime? get createdOn {
    return _createdOn;
  }
  
  TemporalDateTime? get updatedOn {
    return _updatedOn;
  }
  
  List<Post>? get posts {
    return _posts;
  }
  
  List<ChatUser>? get chats {
    return _chats;
  }
  
  const User._internal({required this.id, required username, required firstName, lastName, isVerified, profilePicUrl, email, createdOn, updatedOn, posts, chats}): _username = username, _firstName = firstName, _lastName = lastName, _isVerified = isVerified, _profilePicUrl = profilePicUrl, _email = email, _createdOn = createdOn, _updatedOn = updatedOn, _posts = posts, _chats = chats;
  
  factory User({String? id, required String username, required String firstName, String? lastName, bool? isVerified, String? profilePicUrl, String? email, TemporalDateTime? createdOn, TemporalDateTime? updatedOn, List<Post>? posts, List<ChatUser>? chats}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      username: username,
      firstName: firstName,
      lastName: lastName,
      isVerified: isVerified,
      profilePicUrl: profilePicUrl,
      email: email,
      createdOn: createdOn,
      updatedOn: updatedOn,
      posts: posts != null ? List<Post>.unmodifiable(posts) : posts,
      chats: chats != null ? List<ChatUser>.unmodifiable(chats) : chats);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _username == other._username &&
      _firstName == other._firstName &&
      _lastName == other._lastName &&
      _isVerified == other._isVerified &&
      _profilePicUrl == other._profilePicUrl &&
      _email == other._email &&
      _createdOn == other._createdOn &&
      _updatedOn == other._updatedOn &&
      DeepCollectionEquality().equals(_posts, other._posts) &&
      DeepCollectionEquality().equals(_chats, other._chats);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("firstName=" + "$_firstName" + ", ");
    buffer.write("lastName=" + "$_lastName" + ", ");
    buffer.write("isVerified=" + (_isVerified != null ? _isVerified!.toString() : "null") + ", ");
    buffer.write("profilePicUrl=" + "$_profilePicUrl" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? username, String? firstName, String? lastName, bool? isVerified, String? profilePicUrl, String? email, TemporalDateTime? createdOn, TemporalDateTime? updatedOn, List<Post>? posts, List<ChatUser>? chats}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isVerified: isVerified ?? this.isVerified,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      email: email ?? this.email,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      posts: posts ?? this.posts,
      chats: chats ?? this.chats);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _firstName = json['firstName'],
      _lastName = json['lastName'],
      _isVerified = json['isVerified'],
      _profilePicUrl = json['profilePicUrl'],
      _email = json['email'],
      _createdOn = json['createdOn'] != null ? TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? TemporalDateTime.fromString(json['updatedOn']) : null,
      _posts = json['posts'] is List
        ? (json['posts'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Post.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _chats = json['chats'] is List
        ? (json['chats'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ChatUser.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'firstName': _firstName, 'lastName': _lastName, 'isVerified': _isVerified, 'profilePicUrl': _profilePicUrl, 'email': _email, 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format(), 'posts': _posts?.map((Post? e) => e?.toJson()).toList(), 'chats': _chats?.map((ChatUser? e) => e?.toJson()).toList()
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField FIRSTNAME = QueryField(fieldName: "firstName");
  static final QueryField LASTNAME = QueryField(fieldName: "lastName");
  static final QueryField ISVERIFIED = QueryField(fieldName: "isVerified");
  static final QueryField PROFILEPICURL = QueryField(fieldName: "profilePicUrl");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField CREATEDON = QueryField(fieldName: "createdOn");
  static final QueryField UPDATEDON = QueryField(fieldName: "updatedOn");
  static final QueryField POSTS = QueryField(
    fieldName: "posts",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Post).toString()));
  static final QueryField CHATS = QueryField(
    fieldName: "chats",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ChatUser).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.FIRSTNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LASTNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ISVERIFIED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PROFILEPICURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CREATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.UPDATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.POSTS,
      isRequired: false,
      ofModelName: (Post).toString(),
      associatedKey: Post.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.CHATS,
      isRequired: false,
      ofModelName: (ChatUser).toString(),
      associatedKey: ChatUser.USER
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}