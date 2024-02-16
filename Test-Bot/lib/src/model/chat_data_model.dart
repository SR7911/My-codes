class ChatDataModel {
  String? appName;
  String? clientId;
  String? question1;
  String? question2;
  String? question3;
  String? question4;
  String? question5;
  bool? status;

  ChatDataModel(
      {this.appName,
      this.clientId,
      this.question1,
      this.question2,
      this.question3,
      this.question4,
      this.question5,
      this.status});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApplicationName'] = this.appName;
    data['ClientId'] = this.clientId;
    data['Level1'] = this.question1;
    data['Level2'] = this.question2;
    data['Level3'] = this.question3;
    data['Level4'] = this.question4;
    data['Level5'] = this.question5;
    data['Status'] = this.status;
    return data;
  }

  ChatDataModel.fromJson(Map<String, dynamic> json) {
    appName = json['ApplicationName'] ?? '';
    clientId = json['ClientId'] ?? '';
    question1 = json['Level1'] ?? '';
    question2 = json['Level2'] ?? '';
    question3 = json['Level3'] ?? '';
    question4 = json['Level4'] ?? '';
    question5 = json['Level5'] ?? '';
    status = (json['Status'] != null &&
            json['Status'].toString().toLowerCase() == "true")
        ? true
        : false;
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'ChatDataModel{name: $question1, age: $question2, age: $question3, age: $question4, age: $question5}';
  }
}
