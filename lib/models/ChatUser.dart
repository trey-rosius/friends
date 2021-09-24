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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ChatUser type in your schema. */
@immutable
class ChatUser extends Model {
  static const classType = const _ChatUserModelType();
  final String id;
  final Chat? _chat;
  final User? _user;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Chat get chat {
    try {
      return _chat!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  User get user {
    try {
      return _user!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const ChatUser._internal({required this.id, required chat, required user}): _chat = chat, _user = user;
  
  factory ChatUser({String? id, required Chat chat, required User user}) {
    return ChatUser._internal(
      id: id == null ? UUID.getUUID() : id,
      chat: chat,
      user: user);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatUser &&
      id == other.id &&
      _chat == other._chat &&
      _user == other._user;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ChatUser {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("chat=" + (_chat != null ? _chat!.toString() : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ChatUser copyWith({String? id, Chat? chat, User? user}) {
    return ChatUser(
      id: id ?? this.id,
      chat: chat ?? this.chat,
      user: user ?? this.user);
  }
  
  ChatUser.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _chat = json['chat']?['serializedData'] != null
        ? Chat.fromJson(new Map<String, dynamic>.from(json['chat']['serializedData']))
        : null,
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'chat': _chat?.toJson(), 'user': _user?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "chatUser.id");
  static final QueryField CHAT = QueryField(
    fieldName: "chat",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Chat).toString()));
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ChatUser";
    modelSchemaDefinition.pluralName = "ChatUsers";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ]),
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ChatUser.CHAT,
      isRequired: true,
      targetName: "chatID",
      ofModelName: (Chat).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ChatUser.USER,
      isRequired: true,
      targetName: "userID",
      ofModelName: (User).toString()
    ));
  });
}

class _ChatUserModelType extends ModelType<ChatUser> {
  const _ChatUserModelType();
  
  @override
  ChatUser fromJson(Map<String, dynamic> jsonData) {
    return ChatUser.fromJson(jsonData);
  }
}