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


/** This is an auto generated class representing the Chat type in your schema. */
@immutable
class Chat extends Model {
  static const classType = const _ChatModelType();
  final String id;
  final String? _receiverId;
  final String? _senderId;
  final TemporalDateTime? _createdOn;
  final TemporalDateTime? _updatedOn;
  final List<ChatItem>? _chatItems;
  final List<ChatUser>? _chatUsers;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get receiverId {
    try {
      return _receiverId!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String get senderId {
    try {
      return _senderId!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  TemporalDateTime? get createdOn {
    return _createdOn;
  }
  
  TemporalDateTime? get updatedOn {
    return _updatedOn;
  }
  
  List<ChatItem>? get chatItems {
    return _chatItems;
  }
  
  List<ChatUser>? get chatUsers {
    return _chatUsers;
  }
  
  const Chat._internal({required this.id, required receiverId, required senderId, createdOn, updatedOn, chatItems, chatUsers}): _receiverId = receiverId, _senderId = senderId, _createdOn = createdOn, _updatedOn = updatedOn, _chatItems = chatItems, _chatUsers = chatUsers;
  
  factory Chat({String? id, required String receiverId, required String senderId, TemporalDateTime? createdOn, TemporalDateTime? updatedOn, List<ChatItem>? chatItems, List<ChatUser>? chatUsers}) {
    return Chat._internal(
      id: id == null ? UUID.getUUID() : id,
      receiverId: receiverId,
      senderId: senderId,
      createdOn: createdOn,
      updatedOn: updatedOn,
      chatItems: chatItems != null ? List<ChatItem>.unmodifiable(chatItems) : chatItems,
      chatUsers: chatUsers != null ? List<ChatUser>.unmodifiable(chatUsers) : chatUsers);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Chat &&
      id == other.id &&
      _receiverId == other._receiverId &&
      _senderId == other._senderId &&
      _createdOn == other._createdOn &&
      _updatedOn == other._updatedOn &&
      DeepCollectionEquality().equals(_chatItems, other._chatItems) &&
      DeepCollectionEquality().equals(_chatUsers, other._chatUsers);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Chat {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("receiverId=" + "$_receiverId" + ", ");
    buffer.write("senderId=" + "$_senderId" + ", ");
    buffer.write("createdOn=" + (_createdOn != null ? _createdOn!.format() : "null") + ", ");
    buffer.write("updatedOn=" + (_updatedOn != null ? _updatedOn!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Chat copyWith({String? id, String? receiverId, String? senderId, TemporalDateTime? createdOn, TemporalDateTime? updatedOn, List<ChatItem>? chatItems, List<ChatUser>? chatUsers}) {
    return Chat(
      id: id ?? this.id,
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      chatItems: chatItems ?? this.chatItems,
      chatUsers: chatUsers ?? this.chatUsers);
  }
  
  Chat.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _receiverId = json['receiverId'],
      _senderId = json['senderId'],
      _createdOn = json['createdOn'] != null ? TemporalDateTime.fromString(json['createdOn']) : null,
      _updatedOn = json['updatedOn'] != null ? TemporalDateTime.fromString(json['updatedOn']) : null,
      _chatItems = json['chatItems'] is List
        ? (json['chatItems'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ChatItem.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _chatUsers = json['chatUsers'] is List
        ? (json['chatUsers'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ChatUser.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'receiverId': _receiverId, 'senderId': _senderId, 'createdOn': _createdOn?.format(), 'updatedOn': _updatedOn?.format(), 'chatItems': _chatItems?.map((ChatItem? e) => e?.toJson()).toList(), 'chatUsers': _chatUsers?.map((ChatUser? e) => e?.toJson()).toList()
  };

  static final QueryField ID = QueryField(fieldName: "chat.id");
  static final QueryField RECEIVERID = QueryField(fieldName: "receiverId");
  static final QueryField SENDERID = QueryField(fieldName: "senderId");
  static final QueryField CREATEDON = QueryField(fieldName: "createdOn");
  static final QueryField UPDATEDON = QueryField(fieldName: "updatedOn");
  static final QueryField CHATITEMS = QueryField(
    fieldName: "chatItems",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ChatItem).toString()));
  static final QueryField CHATUSERS = QueryField(
    fieldName: "chatUsers",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ChatUser).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Chat";
    modelSchemaDefinition.pluralName = "Chats";
    
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
      key: Chat.RECEIVERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Chat.SENDERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Chat.CREATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Chat.UPDATEDON,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Chat.CHATITEMS,
      isRequired: false,
      ofModelName: (ChatItem).toString(),
      associatedKey: ChatItem.CHATID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Chat.CHATUSERS,
      isRequired: false,
      ofModelName: (ChatUser).toString(),
      associatedKey: ChatUser.CHAT
    ));
  });
}

class _ChatModelType extends ModelType<Chat> {
  const _ChatModelType();
  
  @override
  Chat fromJson(Map<String, dynamic> jsonData) {
    return Chat.fromJson(jsonData);
  }
}