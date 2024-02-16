// To parse this JSON data, do
//
//     final supportDetailsModel = supportDetailsModelFromJson(jsonString);

import 'dart:convert';

SupportDetailsModel supportDetailsModelFromJson(String str) =>
    SupportDetailsModel.fromJson(json.decode(str));

String supportDetailsModelToJson(SupportDetailsModel data) =>
    json.encode(data.toJson());

class SupportDetailsModel {
  SupportDetailsModel({
    this.serialKey,
    this.applicationName,
    this.client,
    this.employeeId,
    this.employeeName,
    this.mobileNo,
    this.emailId,
    this.issueType,
    this.issueTypeName,
    this.description,
    this.reportingPersonName,
    this.reportingPersonEmailId,
    this.supportingPersonName,
    this.supportingPersonMobileNo,
    this.supportingPersonEmailId,
    this.fileName,
    this.status,
    this.approvedBy,
    this.approvedDate,
    this.returnErrorMessage,
    this.returnStatus,
    this.clientId,
    this.connectionstring,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  int? serialKey;
  dynamic applicationName;
  dynamic client;
  String? employeeId;
  String? employeeName;
  String? mobileNo;
  String? emailId;
  int? issueType;
  dynamic issueTypeName;
  dynamic description;
  String? reportingPersonName;
  String? reportingPersonEmailId;
  String? supportingPersonName;
  String? supportingPersonMobileNo;
  String? supportingPersonEmailId;
  dynamic fileName;
  dynamic status;
  dynamic approvedBy;
  DateTime? approvedDate;
  dynamic returnErrorMessage;
  bool? returnStatus;
  dynamic clientId;
  dynamic connectionstring;
  dynamic createdBy;
  DateTime? createdDate;
  dynamic modifiedBy;
  DateTime? modifiedDate;

  factory SupportDetailsModel.fromJson(Map<String, dynamic> json) =>
      SupportDetailsModel(
        serialKey: json["SerialKey"],
        applicationName: json["ApplicationName"],
        client: json["Client"],
        employeeId: json["EmployeeId"],
        employeeName: json["EmployeeName"],
        mobileNo: json["MobileNo"],
        emailId: json["EmailId"],
        issueType: json["IssueType"],
        issueTypeName: json["IssueTypeName"],
        description: json["Description"],
        reportingPersonName: json["ReportingPersonName"],
        reportingPersonEmailId: json["ReportingPersonEmailId"],
        supportingPersonName: json["SupportingPersonName"],
        supportingPersonMobileNo: json["SupportingPersonMobileNo"],
        supportingPersonEmailId: json["SupportingPersonEmailId"],
        fileName: json["FileName"],
        status: json["Status"],
        approvedBy: json["ApprovedBy"],
        approvedDate: DateTime.parse(json["ApprovedDate"]),
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
        "SerialKey": serialKey,
        "ApplicationName": applicationName,
        "Client": client,
        "EmployeeId": employeeId,
        "EmployeeName": employeeName,
        "MobileNo": mobileNo,
        "EmailId": emailId,
        "IssueType": issueType,
        "IssueTypeName": issueTypeName,
        "Description": description,
        "ReportingPersonName": reportingPersonName,
        "ReportingPersonEmailId": reportingPersonEmailId,
        "SupportingPersonName": supportingPersonName,
        "SupportingPersonMobileNo": supportingPersonMobileNo,
        "SupportingPersonEmailId": supportingPersonEmailId,
        "FileName": fileName,
        "Status": status,
        "ApprovedBy": approvedBy,
        "ApprovedDate": approvedDate!.toIso8601String(),
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
