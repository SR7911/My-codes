// To parse this JSON data, do
//
//     final uploadSupportModel = uploadSupportModelFromJson(jsonString);

import 'dart:convert';

import 'package:testbot/src/model/upload_support_model.dart';

UploadChatModel uploadchatModelFromJson(String str) =>
    UploadChatModel.fromJson(json.decode(str));

String uploadChatModelToJson(UploadChatModel data) =>
    json.encode(data.toJson());

class UploadChatModel {
  UploadChatModel({
    this.applicationName,
    this.client,
    this.employeeId,
    this.employeeName,
    this.mobileNo,
    this.emailid,
    this.issueContent,
    this.description,
    this.reportingPersonName,
    this.reportingpersonemailid,
    this.supportingPersonName,
    this.supportingPersonMobileNo,
    this.supportingpersonemailid,
    this.fileName,
    this.createdBy,
    this.status,
  });

  String? applicationName;
  String? client;
  String? employeeId;
  String? employeeName;
  String? mobileNo;
  String? emailid;
  String? issueContent;
  String? description;
  String? reportingPersonName;
  String? reportingpersonemailid;
  String? supportingPersonName;
  String? supportingPersonMobileNo;
  String? supportingpersonemailid;
  List<FileNameFile>? fileName;
  String? createdBy;
  String? status;

  factory UploadChatModel.fromJson(Map<String, dynamic> json) =>
      UploadChatModel(
        applicationName: json["ApplicationName"],
        client: json["Client"],
        employeeId: json["EmployeeId"],
        employeeName: json["EmployeeName"],
        mobileNo: json["MobileNo"],
        emailid: json["Emailid"],
        issueContent: json["IssueContent"],
        description: json["Description"],
        reportingPersonName: json["ReportingPersonName"],
        reportingpersonemailid: json["reportingpersonemailid"],
        supportingPersonName: json["SupportingPersonName"],
        supportingPersonMobileNo: json["SupportingPersonMobileNo"],
        supportingpersonemailid: json["supportingpersonemailid"],
        fileName: json["FileNameFile"],
        createdBy: json["CreatedBy"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "ApplicationName": applicationName,
        "Client": client,
        "EmployeeId": employeeId,
        "EmployeeName": employeeName,
        "MobileNo": mobileNo,
        "emailid": emailid,
        "IssueContent": issueContent,
        "Description": description,
        "ReportingPersonName": reportingPersonName,
        "reportingpersonemailid": reportingpersonemailid,
        "SupportingPersonName": supportingPersonName,
        "SupportingPersonMobileNo": supportingPersonMobileNo,
        "supportingpersonemailid": supportingpersonemailid,
        "FileNameFile": fileName,
        "CreatedBy": createdBy,
        "Status": status,
      };
}

// class FileNameFile {
//   FileNameFile({
//     this.fileImage,
//   });

//   String? fileImage;

//   factory FileNameFile.fromJson(Map<String, dynamic> json) => FileNameFile(
//         fileImage: json["FileImage"],
//       );

//   Map<String, dynamic> toJson() => {
//         "FileImage": fileImage,
//       };
// }
