import 'dart:convert';
import 'dart:io';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testbot/src/apiservice.dart';
import 'package:testbot/src/color.dart';
import 'package:testbot/src/common_name.dart';
import 'package:testbot/src/components.dart';
import 'package:testbot/src/controller.dart';
import 'package:testbot/src/model/issue_type_models.dart';
import 'package:testbot/src/model/support_details_model.dart';
import 'package:testbot/src/model/upload_chat_model.dart';
import 'package:testbot/src/model/upload_support_model.dart';
import 'package:url_launcher/url_launcher.dart';

final controller = Get.put(Controller());
DragController? dragController;
List<SupportDetailsModel?> supportDetailsList = [];
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
Widget supportdialogue(
    {required double bottommargin,
    required double topmargin,
    required BuildContext context,
    required String empid,
    required String clientId,
    required String appName,
    required String getPreDefineQueApi,
    required String getEmpDetailsApi,
    required String getIssueTypeApi,
    required String insertSupportQueTypeApi,
    required String insertSupportQueApi,
    required bool initialvisibility,
    required int module}) {
  return Stack(
    children: [
      DraggableWidget(
        verticalSpace: 30,
        bottomMargin: bottommargin,
        topMargin: topmargin,
        horizontalSpace: 30,
        // bottomMargin: MediaQuery.of(context).size.height / 6.5,
        // topMargin: MediaQuery.of(context).size.height / 50,
        // horizontalSpace: MediaQuery.of(context).size.width / 20,

        draggingShadow: const BoxShadow(
            color: Colors.black38, offset: Offset(10, 10), blurRadius: 10),
        intialVisibility: initialvisibility,
        shadowBorderRadius: 50,
        initialPosition: AnchoringPosition.bottomRight,
        dragController: dragController,
        child: Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryClr,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.support_agent,
              size: 30,
            ),
            onPressed: () async {
              //   _showPopupMenu();

              try {
                showAlertDialog(Get.context!);
                clearalldata();
                if (module == 1) {
                  await controller.getChatData(
                      appname: appName,
                      clientId: clientId,
                      url: getPreDefineQueApi);

                  await controller.getsupportdata(
                      empid: empid, clientid: clientId, url: getEmpDetailsApi);
                } else {
                  await controller.getissuetypedata(url: getIssueTypeApi);
                  await controller.getsupportdata(
                      empid: empid, clientid: clientId, url: getEmpDetailsApi);
                }
                controller.fileList.clear();
                // await controller.getsupportdata("36370", "3008");
                Get.back();
              } catch (e) {}
              module == 1
                  ? autochat(
                      insertSupportQueTypeApi: insertSupportQueTypeApi,
                      clientId: clientId)
                  : supportbot(
                      insertSupportQueAPI: insertSupportQueApi,
                      clientId: clientId);
            },
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

// void _showPopupMenu() async {
//   await showMenu(
//     context: Get.context!,
//     position: RelativeRect.fromLTRB(100, 100, 100, 100),
//     items: [
//       PopupMenuItem<String>(child: const Text('Doge'), value: 'Doge'),
//       PopupMenuItem<String>(child: const Text('Lion'), value: 'Lion'),
//     ],
//     elevation: 8.0,
//   );
// }

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    throw "Could not launch $url";
  }
}

supportbot({required String insertSupportQueAPI, required String clientId}) {
  return showDialog(
    context: Get.context!,
    builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Dialog(
          insetPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          backgroundColor: primaryClr,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: SizedBox(
            height: Get.height / 1.7,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Icon(Icons.support_agent,
                            color: Colors.white, size: 30),
                      ),
                      const Text(
                        'Get support now',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Support person : ",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "${controller.supportDetailsModel.value.supportingPersonName}",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade300),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " (${controller.supportDetailsModel.value.supportingPersonEmailId})",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade300),
                      ),
                      IconButton(
                          icon: Icon(Icons.call),
                          onPressed: () {
                            // launchUrl("tel:+916383421413");
                            launchUrl(
                                "tel:+91${controller.supportDetailsModel.value.supportingPersonMobileNo}");
                          },
                          color: Colors.white,
                          iconSize: 18.0)
                    ],
                  ),
                  Expanded(
                      child: buildRow(context,
                          insertSupportQueAPI: insertSupportQueAPI,
                          clientId: clientId))
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

sendsupportissue({required String url, required String clientId}) async {
  List<FileNameFile> listFile = [];

  for (int i = 0; i < controller.fileList.length; i++) {
    FileNameFile fileModel = FileNameFile();
    fileModel.fileImage = controller.fileList[i];
    listFile.add(fileModel);
  }

  UploadSupportModel model = UploadSupportModel();
  model.applicationName = "Support Bot";
  //model.client = controller.supportDetailsModel.value.client;
  model.client = clientId;
  model.employeeId = controller.supportDetailsModel.value.employeeId;
  model.employeeName = controller.supportDetailsModel.value.employeeName;
  model.mobileNo = controller.supportDetailsModel.value.mobileNo;
  model.emailid = controller.supportDetailsModel.value.emailId;
  model.issueType = controller.issueType.value.issueTypeId.toString();
  model.description = controller.description.text;
  model.reportingPersonName =
      controller.supportDetailsModel.value.reportingPersonName;
  model.reportingpersonemailid =
      controller.supportDetailsModel.value.reportingPersonEmailId;
  model.supportingPersonName =
      controller.supportDetailsModel.value.supportingPersonName;
  model.supportingPersonMobileNo =
      controller.supportDetailsModel.value.supportingPersonMobileNo;
  model.supportingpersonemailid =
      controller.supportDetailsModel.value.supportingPersonEmailId;
  // model.fileName = controller.fileList.isEmpty ? "" : controller.fileList[0];
  var addedfiles = jsonEncode(listFile);
  List<FileNameFile> d = List<FileNameFile>.from(
      json.decode(addedfiles).map((x) => FileNameFile.fromJson(x)));
  model.fileName = d;
  model.createdBy = "ChatBot";
  model.status = "Pending";
  print(model.toJson());

  var response = await APICalls.apicall(
      label: "UploadSupportData",
      requests: "POST",
      uri: url,
      // uri: "http://devsupport.ppms.co.in/api/ChatBot/InsertSupportQuery",
      param: model.toJson());

  return response;
}

sendchatissue({required String url, required String clientId}) async {
  controller.issueContent.value = (controller.selectedstartchat.value != ''
          ? '${controller.selectedstartchat.value}->'
          : '') +
      (controller.selectedquestion1.value != ''
          ? '${controller.selectedquestion1.value}->'
          : '') +
      (controller.selectedquestion2.value != ''
          ? '${controller.selectedquestion2.value}->'
          : '') +
      (controller.selectedquestion3.value != ''
          ? '${controller.selectedquestion3.value}->'
          : '') +
      (controller.selectedquestion4.value != ''
          ? '${controller.selectedquestion4.value}->'
          : '') +
      (controller.selectedquestion5.value != ''
          ? '${controller.selectedquestion5.value}->'
          : '') +
      (controller.selectedendquestion.value != ''
          ? '${controller.selectedendquestion.value}'
          : '');
  print(controller.issueContent);
  //  "${controller.selectedstartchat}'->'${controller.selectedquestion1}'->'${controller.selectedquestion2}'->'${controller.selectedquestion3}'->'${controller.selectedquestion4}'->'${controller.selectedquestion5}'->'${controller.selectedendquestion}";
  List<FileNameFile> listFile = [];

  for (int i = 0; i < controller.fileList.length; i++) {
    FileNameFile fileModel = FileNameFile();
    fileModel.fileImage = controller.fileList[i];
    listFile.add(fileModel);
  }

  UploadChatModel model = UploadChatModel();
  model.applicationName = "Chat Bot";
  // model.client = controller.supportDetailsModel.value.clientId;
  model.client = clientId;
  model.employeeId = controller.supportDetailsModel.value.employeeId;
  model.employeeName = controller.supportDetailsModel.value.employeeName;
  model.mobileNo = controller.supportDetailsModel.value.mobileNo;
  model.emailid = controller.supportDetailsModel.value.emailId;
  model.issueContent = controller.issueContent.value;
  model.description = controller.description.text;
  model.reportingPersonName =
      controller.supportDetailsModel.value.reportingPersonName;
  model.reportingpersonemailid =
      controller.supportDetailsModel.value.reportingPersonEmailId;
  model.supportingPersonName =
      controller.supportDetailsModel.value.supportingPersonName;
  model.supportingPersonMobileNo =
      controller.supportDetailsModel.value.supportingPersonMobileNo;
  model.supportingpersonemailid =
      controller.supportDetailsModel.value.supportingPersonEmailId;
  // model.fileName = controller.fileList.isEmpty ? "" : controller.fileList[0];
  var addedfiles = jsonEncode(listFile);
  List<FileNameFile> d = List<FileNameFile>.from(
      json.decode(addedfiles).map((x) => FileNameFile.fromJson(x)));
  model.fileName = d;
  model.createdBy = "ChatBot";
  model.status = "Pending";
  print(model.toJson());

  List response = await APICalls.apicall(
      label: "UploadChatData",
      requests: "POST",
      uri: url,
      // uri: "http://devsupport.ppms.co.in/api/ChatBot/InsertSupportQueryType2",
      param: model.toJson());

  return response;
}

Widget buildRow(BuildContext context,
    {required String insertSupportQueAPI, required String clientId}) {
  return Card(
    margin: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListView(children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const Text(
                "Issue Type",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 2,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: Obx(
                        () => DropdownButtonFormField<IssueTypeModel>(
                            validator: (value) {
                              if (value!.issueTypeName == CommonName.select) {
                                return "Select Issue type";
                              } else {
                                return null;
                              }
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                            items: controller.issueTypeList
                                .map((IssueTypeModel value) =>
                                    DropdownMenuItem<IssueTypeModel>(
                                      value: value,
                                      child: Text(
                                        value.issueTypeName!,
                                        textScaleFactor: 1.0,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              controller.issueType.value = value!;
                            },
                            isExpanded: true,
                            value: controller.issueType.value),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 0,
          color: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Description",
              ),
              validator: (value) {
                if (value!.trim() == "") {
                  return "Description is empty";
                } else {
                  return null;
                }
              },
              controller: controller.description,
              style: TextStyle(fontSize: 18),
              cursorHeight: 25.0,
              textDirection: TextDirection.ltr,
              minLines: 6,
              textInputAction: TextInputAction.done, //iOS
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text(
                "Support Attach",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              children: [
                Obx(
                  () => controller.fileList.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: GestureDetector(
                            onTap: () {
                              controller.fileList.clear();
                            },
                            child: Card(
                              elevation: 2,
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: GestureDetector(
                    onTap: () async {
                      List selectedImgList = [];
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(allowMultiple: true, type: FileType.image);
                      if (result == null) {
                        print("No file selected");
                      } else {
                        showAlertDialog(Get.context!);
                        result.files.forEach((element) {
                          // print('test: ${element.name}');
                          selectedImgList.add(element);
                        });
                      }
                      controller.fileList.value = [];
                      for (int i = 0; i < selectedImgList.length; i++) {
                        File file = File(selectedImgList[i].path);
                        var compressedImg = await compressFile(file, context);
                        var baseImg = base64String(compressedImg);
                        controller.fileList.add(baseImg);
                      }
                      Get.back();
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.attachment,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Positioned(
                            left: controller.fileList.length <= 99 ? 25 : 20,
                            bottom: 26,
                            child: Text(
                              controller.fileList.length <= 99
                                  ? "${controller.fileList.length}"
                                  : "99+",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        Obx(
          () => controller.fileList.isEmpty
              ? Container()
              : const Divider(
                  color: Colors.grey,
                ),
        ),
        Obx(
          () => controller.fileList.isEmpty
              ? Container()
              : SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.fileList.length,
                      itemBuilder: (BuildContext context, int index) {
                        // print(
                        //     'controller.fileList.length: ${controller.fileList.length}, ${controller.fileList[index]}');
                        return Row(
                          children: [
                            // Image.file(
                            //     File(controller.fileList[index].path)),
                            InteractiveViewer(
                                minScale: 1.0,
                                maxScale: 10.0,
                                child: Image.memory(
                                  base64Decode(controller.fileList[index]),
                                  fit: BoxFit.contain,
                                  gaplessPlayback: true,
                                )),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        );
                      }),
                ),
        ),

        const Divider(
          color: Colors.grey,
        ),
        // SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Card(
                      color: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(Icons.question_mark_rounded,
                            color: Colors.white, size: 20.0),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  // Card(
                  //     color: Colors.green.shade400,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(50)),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(2.0),
                  //       child: Icon(Icons.call,
                  //           color: Colors.white, size: 20.0),
                  //     )),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showAlertDialog(Get.context!);
                    await sendsupportissue(
                            url: insertSupportQueAPI, clientId: clientId)
                        .then((response) {
                      if (response[0]) {
                        Get.back();
                        Get.back();
                        snackbar('Report has been recorded successfully.');
                        clearalldata();
                      } else {
                        Get.back();
                        Get.back();
                        snackbar('Something wrong, please try later...');
                      }
                    });
                  }
                },
                child: Text('Send'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryClr,
                    shape: StadiumBorder(),
                    elevation: 10),
              ),
            ],
          ),
        )
      ]),
    ),
  );
}

final ScrollController _controller = ScrollController();

// This is what you're looking for!
void _scrollDown() {
//  _controller.jumpTo(_controller.position.maxScrollExtent);
  // _controller.animateTo(
  //   _controller.position.viewportDimension,
  //   duration: Duration(milliseconds: 300),
  //   curve: Curves.fastOutSlowIn,
  // );

  _controller.animateTo(
    _controller.position.maxScrollExtent + 300,
    duration: const Duration(
      seconds: 1,
    ),
    curve: Curves.fastOutSlowIn,
  );
}

autochat({required String insertSupportQueTypeApi, required String clientId}) {
  controller.fileList.clear();
  showDialog(
    context: Get.context!,
    builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Dialog(
          insetPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 16,
          child: SizedBox(
            height: Get.height / 1.5,
            width: double.infinity,
            child: Obx(
              () => Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: primaryClr,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Icon(Icons.contact_support,
                                  color: Colors.white, size: 30),
                            ),
                            const Text(
                              'Chat with us now!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.blue.shade50,
                        child: ListView(
                          controller: _controller,
                          children: [
                            chattextfrombot(
                                "Hi ${controller.supportDetailsModel.value.employeeName ?? ''}, May I help you?"),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 100, 5),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.startchat.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return chatbuttonstart(index);
                                  }),
                            ),
                            if (controller.selectedstartchat.value != '')
                              chattext(controller.selectedstartchat.value),
                            if (controller.selectedstartchat.value != '' &&
                                controller.selectedno.value == '')
                              chattextfrombot(
                                  'Please select the area of concern'),
                            if (controller.selectedno.value != '')
                              chattextfrombot(controller.selectedno.value),
                            //First widget

                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 100, 5),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.question1.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return chatbuttonset1(index);
                                  }),
                            ),
                            if (controller.selectedquestion1.value != '')
                              chattext(controller.selectedquestion1.value),
                            // Second widget
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 100, 5),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.question2.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return chatbuttonset2(index);
                                  }),
                            ),
                            if (controller.selectedquestion2.value != '')
                              chattext(controller.selectedquestion2.value),
                            //Third widget
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 100, 5),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.question3.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return chatbuttonset3(index);
                                  }),
                            ),
                            if (controller.selectedquestion3.value != '')
                              chattext(controller.selectedquestion3.value),
                            //Fourth widget
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 100, 5),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.question4.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return chatbuttonset4(index);
                                  }),
                            ),
                            if (controller.selectedquestion4.value != '')
                              chattext(controller.selectedquestion4.value),
                            //Fifth widget
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 100, 5),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.question5.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return chatbuttonset5(index);
                                  }),
                            ),
                            if (controller.selectedquestion5.value != '')
                              chattext(controller.selectedquestion5.value),
                            if (controller.selectedendquestion.value != '')
                              chattextendfrombot(
                                  "Our Support team will respond you shortly, please describe your queries here."),
                            if (controller.selectedendquestion.value != '')
                              chattextendfrombot(
                                  'If required further assistance, please write to support desk helpdesk@ppms.in'),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    if (controller.selectedendquestion.value != "")
                      sendmessage(context,
                          insertSupportQueTypeApi: insertSupportQueTypeApi,
                          clientId: clientId),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget chatbuttonstart(int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.zero,
                        topRight: Radius.circular(30)),
                    side: BorderSide(color: Colors.blue.shade700)))),
        child: Text(controller.startchat[index],
            style: TextStyle(color: Colors.blue.shade700)),
        onPressed: () {
          controller.question2.clear();
          controller.question3.clear();
          controller.question4.clear();
          controller.question5.clear();
          controller.selectedendquestion.value = "";
          controller.selectedquestion1.value = "";
          controller.selectedquestion2.value = "";
          controller.selectedquestion3.value = "";
          controller.selectedquestion4.value = "";
          controller.selectedquestion5.value = "";
          controller.selectedstartchat.value = controller.startchat[index];
          controller.level1data(controller.selectedstartchat.value);
          if (controller.selectedstartchat.value != "Yes") {
            controller.question1.clear();
            controller.selectedno.value = "Thanks for contacting us!";
          } else {
            controller.selectedno.value = "";
          }
          print('selectedstartchat: ${controller.selectedstartchat}');
          _scrollDown();
        },
      ),
    ],
  );
}

Widget chatbuttonset1(int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.zero,
                        topRight: Radius.circular(30)),
                    side: BorderSide(color: Colors.blue.shade700)))),
        child: Text(controller.question1[index],
            style: TextStyle(color: Colors.blue.shade700)),
        onPressed: () {
          controller.question3.clear();
          controller.question4.clear();
          controller.question5.clear();
          controller.selectedendquestion.value = "";
          controller.selectedquestion2.value = "";
          controller.selectedquestion3.value = "";
          controller.selectedquestion4.value = "";
          controller.selectedquestion5.value = "";
          controller.selectedquestion1.value = controller.question1[index];
          controller.level2data(controller.selectedquestion1.value);
          print('selectedquestion1: ${controller.selectedquestion1}');
          _scrollDown();
        },
      ),
    ],
  );
}

Widget chatbuttonset2(int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.zero,
                        topRight: Radius.circular(30)),
                    side: BorderSide(color: Colors.blue.shade700)))),
        child: Text(controller.question2[index],
            style: TextStyle(color: Colors.blue.shade700)),
        onPressed: () {
          controller.question4.clear();
          controller.question5.clear();
          controller.selectedendquestion.value = "";
          controller.selectedquestion3.value = "";
          controller.selectedquestion4.value = "";
          controller.selectedquestion5.value = "";
          controller.selectedquestion2.value = controller.question2[index];
          controller.level3data(controller.selectedquestion2.value);
          print('selectedquestion2: ${controller.selectedquestion2}');
          _scrollDown();
        },
      ),
    ],
  );
}

Widget chatbuttonset3(int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.zero,
                        topRight: Radius.circular(30)),
                    side: BorderSide(color: Colors.blue.shade700)))),
        child: Text(controller.question3[index],
            style: TextStyle(color: Colors.blue.shade700)),
        onPressed: () {
          controller.question5.clear();
          controller.selectedendquestion.value = "";
          controller.selectedquestion4.value = "";
          controller.selectedquestion5.value = "";
          controller.selectedquestion3.value = controller.question3[index];
          controller.level4data(controller.selectedquestion3.value);
          print('selectedquestion3: ${controller.selectedquestion3}');
          _scrollDown();
        },
      ),
    ],
  );
}

Widget chatbuttonset4(int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.zero,
                        topRight: Radius.circular(30)),
                    side: BorderSide(color: Colors.blue.shade700)))),
        child: Text(controller.question4[index],
            style: TextStyle(color: Colors.blue.shade700)),
        onPressed: () {
          controller.selectedendquestion.value = "";
          controller.selectedquestion5.value = "";
          controller.selectedquestion4.value = controller.question4[index];
          controller.level5data(controller.selectedquestion4.value);
          print('selectedquestion4: ${controller.selectedquestion4}');
          _scrollDown();
        },
      ),
    ],
  );
}

Widget chatbuttonset5(int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.zero,
                        topRight: Radius.circular(30)),
                    side: BorderSide(color: Colors.blue.shade700)))),
        child: Text(controller.question5[index],
            style: TextStyle(color: Colors.blue.shade700)),
        onPressed: () {
          controller.selectedquestion5.value = controller.question5[index];
          // controller.level6data(controller.selectedquestion1.value);
          print('selectedquestion5: ${controller.selectedquestion5}');
          _scrollDown();
        },
      ),
    ],
  );
}

Widget chattextfrombot(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 5, 100, 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey.shade600),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.zero,
                          topRight: Radius.circular(30)),
                      side: BorderSide(color: Colors.white)))),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(text, style: TextStyle(color: Colors.white)),
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}

Widget chattextendfrombot(String txt) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(10, 5, 100, 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.grey.shade600),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.zero,
                          topRight: Radius.circular(30)),
                      side: BorderSide(color: Colors.white)))),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(txt, style: const TextStyle(color: Colors.white)),
          ),
          onPressed: () {},
        ),
      ],
    ),
  );
}

Widget chattext(String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(100, 5, 10, 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue.shade700),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          topRight: Radius.zero),
                      side: BorderSide(color: Colors.white)))),
          child: Text(text, style: TextStyle(color: Colors.white)),
          onPressed: () {},
        ),
      ],
    ),
  );
}

sendmessage(BuildContext context,
    {required String insertSupportQueTypeApi, required String clientId}) {
  return Obx(
    () => SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  "Support Attach",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                children: [
                  if (controller.fileList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: GestureDetector(
                        onTap: () {
                          controller.fileList.clear();
                        },
                        child: Card(
                          elevation: 2,
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {
                        List selectedImgList = [];
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(
                                allowMultiple: true, type: FileType.image);
                        if (result == null) {
                          print("No file selected");
                        } else {
                          showAlertDialog(Get.context!);
                          result.files.forEach((element) {
                            // print('test: ${element.name}');
                            selectedImgList.add(element);
                          });
                        }
                        controller.fileList.value = [];
                        for (int i = 0; i < selectedImgList.length; i++) {
                          File file = File(selectedImgList[i].path);
                          var compressedImg = await compressFile(file, context);
                          var baseImg = base64String(compressedImg);
                          controller.fileList.add(baseImg);
                        }
                        Get.back();

                        print('fileList length: ${controller.fileList.length}');
                      },
                      child: Stack(
                        children: [
                          Positioned(
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.attachment,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Positioned(
                              left: controller.fileList.length <= 99 ? 25 : 20,
                              bottom: 26,
                              child: Text(
                                controller.fileList.length <= 99
                                    ? "${controller.fileList.length}"
                                    : "99+",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          if (controller.fileList.isNotEmpty)
            const Divider(
              color: Colors.grey,
            ),
          if (controller.fileList.isNotEmpty)
            SizedBox(
              height: 50,
              child: ListView.builder(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.fileList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print(
                    //     'controller.fileList.length: ${controller.fileList.length}, ${controller.fileList[index]}');
                    return Row(
                      children: [
                        // Image.file(
                        //     File(controller.fileList[index].path)),
                        InteractiveViewer(
                            minScale: 1.0,
                            maxScale: 10.0,
                            child: Image.memory(
                              base64Decode(controller.fileList[index]),
                              fit: BoxFit.contain,
                              gaplessPlayback: true,
                            )),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    );
                  }),
            ),
          const Divider(color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, top: 2, bottom: 2),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Description",
                        ),
                        validator: ((value) {
                          if (value == null || value == "") {
                            return "Description is empty";
                          } else {
                            return null;
                          }
                        }),
                        controller: controller.description,
                        style: TextStyle(fontSize: 18),
                        cursorHeight: 25.0,
                        textDirection: TextDirection.ltr,
                        minLines: 2,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Card(
                    elevation: 5,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            showAlertDialog(Get.context!);
                            await sendchatissue(
                                    url: insertSupportQueTypeApi,
                                    clientId: "3008")
                                .then((response) {
                              if (response[0]) {
                                Get.back();
                                Get.back();
                                snackbar(
                                    'Report has been recorded successfully.');
                                clearalldata();
                              } else {
                                Get.back();
                                Get.back();
                                snackbar(
                                    'Something went wrong, please try later');
                              }
                            });
                          }
                        },
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

snackbar(var msg) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
    duration: Duration(seconds: 6),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('$msg'),
    ),
  ));
}

clearalldata() {
  controller.description = TextEditingController();
  controller.fileList.clear();
  controller.issueContent.value = '';
  try {
    controller.issueType.value = controller.issueTypeList[0];
  } catch (e) {
    controller.issueType.value = IssueTypeModel(
        issueTypeId: -1,
        issueTypeName: CommonName.select,
        clientId: '',
        connectionstring: '',
        createdBy: '',
        createdDate: DateTime.now(),
        modifiedBy: '',
        modifiedDate: DateTime.now(),
        returnErrorMessage: '',
        returnStatus: false);
  }
  // controller.startchat = ["Yes", "No"];
  controller.selectedstartchat.value = "";
  controller.question1.clear();
  controller.selectedquestion1.value = "";
  controller.question2.clear();
  controller.selectedquestion2.value = "";
  controller.question3.clear();
  controller.selectedquestion3.value = "";
  controller.question4.clear();
  controller.selectedquestion4.value = "";
  controller.question5.clear();
  controller.selectedquestion5.value = "";
  controller.selectedno.value = "";
  controller.selectedendquestion.value = "";
}

modalSheet() {
  showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Send email'),
              onTap: () {
                print('Send email');
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Call phone'),
              onTap: () {
                print('Call phone');
              },
            ),
          ],
        );
      });
}
