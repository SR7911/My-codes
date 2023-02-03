import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:testbot/src/apiservice.dart';
import 'package:testbot/src/common_name.dart';
import 'package:testbot/src/model/chat_data_model.dart';
import 'package:testbot/src/model/issue_type_models.dart';
import 'package:testbot/src/model/support_details_model.dart';
import 'package:testbot/src/sqflite/database.dart';

class Controller extends GetxController {
  RxList fileList = [].obs;
  RxString issueType = "Select".obs;
  RxString issueContent = "".obs;
  TextEditingController description = TextEditingController();

  RxList<String> issueTypeList = [CommonName.select].obs;
  var supportDetailsModel = SupportDetailsModel().obs;

  getsupportdata(String empid, String clientid) async {
    var data = await APICalls.apicall(
        requests: "POST",
        param: {"EmployeeId": empid, "Client": clientid},
        uri: "http://devsupport.ppms.co.in/api/ChatBot/GetEmployeeDetailsById",
        label: "GetSupportInfoApi");
    supportDetailsModel.value = SupportDetailsModel();
    if (data[0]) {
      supportDetailsModel.value = supportDetailsModelFromJson(data[1]);
    }
    // print("supportList => ${data[1]}");
    // print("supportListsize => ${data.length}");
  }

  getissuetypedata() async {
    var dropdowndata = await APICalls.apicall(
        requests: "GET",
        label: "GetIssueTypes",
        uri: "http://devsupport.ppms.co.in/api/ChatBot/GetIssueTyeMaster");
    List<IssueTypeModel> c = [];
    if (dropdowndata[0]) {
      c = issueTypeModelFromJson(dropdowndata[1]);
    }
    issueTypeList.value = [CommonName.select];
    for (int i = 0; i < c.length; i++) {
      issueTypeList.add(c[i].issueTypeName!);
      print("${issueTypeList.toString()}");
    }
  }

  getChatData() async {
    var dropdowndata = await APICalls.apicall(
        param: {"ApplicationName": "Bandhu", "ClientId": "3008"},
        requests: "POST",
        label: "GetChatData",
        uri:
            "http://devsupport.ppms.co.in/api/ChatBot/GetPreDefineQuestionMaster");

    if (dropdowndata[0]) {
      List<ChatDataModel> chatDataModel = (jsonDecode(dropdowndata[1]) as List)
          .map((e) => ChatDataModel.fromJson(e))
          .toList();

      Database db = await DatabaseHelper.instance.database;
      chatDataModel.map((e) async {
        List<Map<String, dynamic>> data =
            await db.query(DatabaseHelper.tableName);

        if (data.isNotEmpty) {
          await db.execute('DELETE FROM ${DatabaseHelper.tableName}');
          List<Map<String, dynamic>> data =
              await db.query(DatabaseHelper.tableName);
        } else {
          print("Data is Already Present in DB");
        }
        int a = await db.insert(DatabaseHelper.tableName, e.toJson());
        print(a);

        return 0;
      }).toList();
    }
  }

  //------------------------------------------------------------------------------------

  List startchat = ["Yes", "No"];
  RxString selectedstartchat = "".obs;
  RxList question1 = [].obs;
  RxString selectedquestion1 = "".obs;
  RxList question2 = [].obs;
  RxString selectedquestion2 = "".obs;
  RxList question3 = [].obs;
  RxString selectedquestion3 = "".obs;
  RxList question4 = [].obs;
  RxString selectedquestion4 = "".obs;
  RxList question5 = [].obs;
  RxString selectedquestion5 = "".obs;
  RxString selectedno = "".obs;
  RxString selectedendquestion = "".obs;

  level1data(String ans) async {
    Database db = await DatabaseHelper.instance.database;
    List<ChatDataModel> favouriteSqfliteModelList = [];
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(
      DatabaseHelper.tableName,
      distinct: true,
    );
    if (maps.length > 0) {
      maps.forEach((f) {
        favouriteSqfliteModelList.add(ChatDataModel.fromJson(f));
      });
    }
    question1.value = [];
    for (int i = 0; i < favouriteSqfliteModelList.length; i++) {
      var a = favouriteSqfliteModelList[i].question1;
      question1.add(a);
    }
    question1.value = question1.toSet().toList();
    question1.contains("") ? question1 = [].obs : "";
    if (ans == "No") {
      question1.value = [];
    }
    if (ans == "Yes" && question1.isEmpty) {
      selectedendquestion.value =
          "Our Support team will respond you shortly, please describe your queries here.";
    }
    return question1;
  }

  level2data(String ans) async {
    Database db = await DatabaseHelper.instance.database;
    List<ChatDataModel> favouriteSqfliteModelList = [];
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(
        DatabaseHelper.tableName,
        distinct: true,
        where: "Level1 = ?",
        whereArgs: [ans]);
    if (maps.length > 0) {
      maps.forEach((f) {
        favouriteSqfliteModelList.add(ChatDataModel.fromJson(f));
      });
    }
    question2.value = [];
    for (int i = 0; i < favouriteSqfliteModelList.length; i++) {
      var a = favouriteSqfliteModelList[i].question2;
      question2.add(a);
    }
    question2.value = question2.toSet().toList();
    question2.contains("") ? question2 = [].obs : "";
    if (question2.isEmpty) {
      selectedendquestion.value =
          "Our Support team will respond you shortly, please describe your queries here.";
    }
    return question2;
  }

  level3data(String ans) async {
    Database db = await DatabaseHelper.instance.database;
    List<ChatDataModel> favouriteSqfliteModelList = [];
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(
        DatabaseHelper.tableName,
        distinct: true,
        where: "Level2 = ?",
        whereArgs: [ans]);
    if (maps.length > 0) {
      maps.forEach((f) {
        favouriteSqfliteModelList.add(ChatDataModel.fromJson(f));
      });
    }
    question3.value = [];
    for (int i = 0; i < favouriteSqfliteModelList.length; i++) {
      var a = favouriteSqfliteModelList[i].question3;
      question3.add(a);
    }
    question3.value = question3.toSet().toList();
    question3.contains("") ? question3 = [].obs : "";
    if (question3.isEmpty) {
      selectedendquestion.value =
          "Our Support team will respond you shortly, please describe your queries here.";
    }
    return question3;
  }

  level4data(String ans) async {
    Database db = await DatabaseHelper.instance.database;
    List<ChatDataModel> favouriteSqfliteModelList = [];
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(
        DatabaseHelper.tableName,
        distinct: true,
        where: "Level3 = ?",
        whereArgs: [ans]);
    if (maps.length > 0) {
      maps.forEach((f) {
        favouriteSqfliteModelList.add(ChatDataModel.fromJson(f));
      });
    }
    question4.value = [];
    for (int i = 0; i < favouriteSqfliteModelList.length; i++) {
      var a = favouriteSqfliteModelList[i].question4;
      question4.add(a);
    }
    question4.value = question4.toSet().toList();
    question4.contains("") ? question4 = [].obs : "";
    if (question4.isEmpty) {
      selectedendquestion.value =
          "Our Support team will respond you shortly, please describe your queries here.";
    }
    return question4;
  }

  level5data(String ans) async {
    Database db = await DatabaseHelper.instance.database;
    List<ChatDataModel> favouriteSqfliteModelList = [];
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query(
        DatabaseHelper.tableName,
        distinct: true,
        where: "Level4 = ?",
        whereArgs: [ans]);
    if (maps.length > 0) {
      maps.forEach((f) {
        favouriteSqfliteModelList.add(ChatDataModel.fromJson(f));
      });
    }
    question5.value = [];
    for (int i = 0; i < favouriteSqfliteModelList.length; i++) {
      var a = favouriteSqfliteModelList[i].question5;
      question5.add(a);
    }
    question5.value = question5.toSet().toList();
    question5.contains("") ? question5 = [].obs : "";
    selectedendquestion.value =
        "Our Support team will respond you shortly, please describe your queries here.";
    return question5;
  }

  //----------------------------------------------------------------------------
  //Default chat data

  List column2(String ans) {
    question2.value = [];
    switch (ans) {
      case "Yes":
        question2.value = ["Attendance", "Onboarding", "Expense"];
        break;
      case "No":
        question2.value = ["Want to chat with us?", "Others"];
        break;
      case "Others":
        question2.value = ["Server issue", "Network issue", "Slow response"];
        break;
    }
    return question2;
  }

  List column3(String ans) {
    question3.value = [];
    if (selectedquestion1.contains("Yes")) {
      switch (ans) {
        case "Attendance":
          question3.value = [
            "Unable to punch attendance?",
            "Loading issue?",
            "Regularisation not showing?"
          ];
          break;
        case "Onboarding":
          question3.value = [
            "Image Upload failed?",
            "Server error?",
            "Data mismatch?",
            "Onboarding not showing?"
          ];
          break;
        case "Expense":
          question3.value = [
            "Server issue?",
            "Unable to add expense?",
            "Added expense not showing?",
            "Button not working?"
          ];
          break;
      }
      return question3;
    } else if (selectedquestion1.contains("No")) {
      switch (ans) {
        case "Want to know something?":
          question3.value = [
            "Contact support from support bot",
            "Read FAQ's from profile page",
            "Try using app tour"
          ];
          break;
        case "Others":
          question3.value = [
            "Camera issue?",
            "Server error?",
            "Payslip not showing",
            "Image capture failed?"
          ];
          break;
      }
      return question3;
    } else {
      switch (ans) {
        case "Attendance":
          question3.value = [
            "Unable to punch attendance",
            "Loading issue?",
            "Regularisation not showing"
          ];
          break;
        case "Onboarding":
          question3.value = [
            "Image Upload failed?",
            "Server error?",
            "Data mismatch?",
            "Onboarding not showing?"
          ];
          break;
        case "Expense":
          question3.value = [
            "Server issue?",
            "Unable to add expense?",
            "Added expense not showing?",
            "Button not working?"
          ];
          break;
      }
      return question3;
    }
  }

  List column4(String ans) {
    question4.value = [];
    switch (ans) {
      case "Yes":
        question4.value = ["Attendance", "Onboarding", "Expense"];
        break;
      case "No":
        question4.value = ["Payslip", "Leave", "Offboarding"];
        break;
      case "Others":
        question4.value = ["Server issue", "Network issue", "Slow response"];
        break;
    }
    return question4;
  }

  List column5(String ans) {
    question5.value = [];
    switch (ans) {
      case "Yes":
        question5.value = ["Attendance", "Onboarding", "Expense"];
        break;
      case "No":
        question5.value = ["Payslip", "Leave", "Offboarding"];
        break;
      case "Others":
        question5.value = ["Server issue", "Network issue", "Slow response"];
        break;
    }
    return question5;
  }
}
