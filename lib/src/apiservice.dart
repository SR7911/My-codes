import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class APICalls {
  getsupportcredentialsapi() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://devsupport.ppms.co.in/api/ChatBot/GetEmployeeDetailsById'));
    request.body = json.encode({"EmployeeId": "36370", "Client": "3008"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  sendissuedetailsapi() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://devsupport.ppms.co.in/api/ChatBot/InsertSupportQuery'));
    request.body = json.encode({
      "ApplicationName": "Fieldlytics",
      "Client": "3008",
      "EmployeeId": "36370",
      "EmployeeName": "Prasanth",
      "MobileNo": "9095735575",
      "mailto:emailid": "krprasanth@gmail.com",
      "IssueType": "Testing",
      "Description": "Checking",
      "ReportingPersonName": "ABC",
      "mailto:reportingpersonemailid": "abc@gmail.com",
      "SupportingPersonName": "Karthik",
      "SupportingPersonMobileNo": "6987688574",
      "mailto:supportingpersonemailid": "karthik@gmail.com",
      "FileName": "",
      "CreatedBy": "DevTeam",
      "Status": "Pending"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  getissuetype() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://devsupport.ppms.co.in/api/ChatBot/GetIssueTyeMaster'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
