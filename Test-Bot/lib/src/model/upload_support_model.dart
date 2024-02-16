// To parse this JSON data, do
//
//     final uploadSupportModel = uploadSupportModelFromJson(jsonString);

import 'dart:convert';

UploadSupportModel uploadSupportModelFromJson(String str) =>
    UploadSupportModel.fromJson(json.decode(str));

String uploadSupportModelToJson(UploadSupportModel data) =>
    json.encode(data.toJson());

class UploadSupportModel {
  UploadSupportModel({
    this.applicationName,
    this.client,
    this.employeeId,
    this.employeeName,
    this.mobileNo,
    this.emailid,
    this.issueType,
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
  String? issueType;
  String? description;
  String? reportingPersonName;
  String? reportingpersonemailid;
  String? supportingPersonName;
  String? supportingPersonMobileNo;
  String? supportingpersonemailid;
  List<FileNameFile>? fileName;
  String? createdBy;
  String? status;

  factory UploadSupportModel.fromJson(Map<String, dynamic> json) =>
      UploadSupportModel(
        applicationName: json["ApplicationName"],
        client: json["Client"],
        employeeId: json["EmployeeId"],
        employeeName: json["EmployeeName"],
        mobileNo: json["MobileNo"],
        emailid: json["Emailid"],
        issueType: json["IssueType"],
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
        "IssueType": issueType,
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

class FileNameFile {
  FileNameFile({
    this.fileImage,
  });

  String? fileImage;

  factory FileNameFile.fromJson(Map<String, dynamic> json) => FileNameFile(
        fileImage: json["FileImage"],
      );

  Map<String, dynamic> toJson() => {
        "FileImage": fileImage,
      };
}
