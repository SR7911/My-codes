// To parse this JSON data, do
//
//     final issueTypeModel = issueTypeModelFromJson(jsonString);

import 'dart:convert';

List<IssueTypeModel> issueTypeModelFromJson(String str) =>
    List<IssueTypeModel>.from(
        json.decode(str).map((x) => IssueTypeModel.fromJson(x)));

String issueTypeModelToJson(List<IssueTypeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IssueTypeModel {
  IssueTypeModel({
    this.issueTypeId,
    this.issueTypeName,
    this.returnErrorMessage,
    this.returnStatus,
    this.clientId,
    this.connectionstring,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  int? issueTypeId;
  String? issueTypeName;
  dynamic returnErrorMessage;
  bool? returnStatus;
  dynamic clientId;
  dynamic connectionstring;
  dynamic createdBy;
  DateTime? createdDate;
  dynamic modifiedBy;
  DateTime? modifiedDate;

  factory IssueTypeModel.fromJson(Map<String, dynamic> json) => IssueTypeModel(
        issueTypeId: json["IssueTypeId"],
        issueTypeName: json["IssueTypeName"],
        returnErrorMessage: json["returnErrorMessage"],
        returnStatus: json["returnStatus"],
        clientId: json["ClientId"],
        connectionstring: json["Connectionstring"],
        createdBy: json["CreatedBy"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        modifiedBy: json["ModifiedBy"],
        modifiedDate: DateTime.parse(json["ModifiedDate"]),
      );

  Map<String, dynamic> toJson() => {
        "IssueTypeId": issueTypeId,
        "IssueTypeName": issueTypeName,
        "returnErrorMessage": returnErrorMessage,
        "returnStatus": returnStatus,
        "ClientId": clientId,
        "Connectionstring": connectionstring,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate!.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedDate": modifiedDate!.toIso8601String(),
      };
}
