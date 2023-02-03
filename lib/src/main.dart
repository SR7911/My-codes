import 'dart:io';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testbot/src/color.dart';
import 'package:testbot/src/controller.dart';
import 'package:url_launcher/url_launcher.dart';

final controller = Get.put(Controller());
DragController? dragController;

final List<String> _dropdownValues = [
  'Select',
  "Attenance Issue",
  "Leave Issue",
  "Regularization",
  "OnBoard Issue",
  "PaySlip Issue",
  "Expense Issue"
];

@override
Widget supportdialogue(BuildContext context) {
  return Stack(
    children: [
      // Positioned(
      //     top: 10,
      //     child: SingleChildScrollView(
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Column(
      //           children: [
      //             Row(
      //               children: [
      //                 SizedBox(
      //                   height: 100,
      //                   width: 100,
      //                   child: Card(
      //                     elevation: 0,
      //                     color: Colors.grey.shade100,
      //                     shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(15.0),
      //                         side: BorderSide(color: Colors.grey)),
      //                     child: Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: TextFormField(
      //                         decoration: InputDecoration(
      //                           border: InputBorder.none,
      //                           hintText: "Description",
      //                         ),
      //                         style: TextStyle(fontSize: 18),
      //                         cursorHeight: 25.0,
      //                         textDirection: TextDirection.ltr,
      //                         minLines: 6,
      //                         keyboardType: TextInputType.multiline,
      //                         maxLines: null,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   width: 20,
      //                 ),
      //               ],
      //             ),
      //             SizedBox(
      //               height: 100,
      //             ),
      //             SizedBox(
      //               height: 100,
      //             ),
      //             SizedBox(
      //               height: 100,
      //             ),
      //           ],
      //         ),
      //       ),
      //     )),

      // Padding(
      //   padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      //   child: ElevatedButton(
      //     onPressed: () {
      //       showDialog(
      //         context: context,
      //         builder: (context) {
      //           return Dialog(
      //             insetPadding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
      //             backgroundColor: primaryClr,
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(10)),
      //             elevation: 16,
      //             child: ListView(
      //               shrinkWrap: true,
      //               children: [
      //                 Container(
      //                   decoration: BoxDecoration(
      //                       color: primaryClr,
      //                       borderRadius: const BorderRadius.vertical(
      //                           top: Radius.circular(15))),
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(8.0),
      //                     child: ListView(
      //                       shrinkWrap: true,
      //                       children: [
      //                         Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             const Padding(
      //                               padding: EdgeInsets.all(8.0),
      //                               child: Icon(Icons.support_agent,
      //                                   color: Colors.white, size: 30),
      //                             ),
      //                             const Padding(
      //                               padding: EdgeInsets.all(15.0),
      //                               child: Text(
      //                                 'Chat with us now',
      //                                 style: TextStyle(
      //                                     color: Colors.white,
      //                                     fontWeight: FontWeight.bold,
      //                                     fontSize: 20),
      //                                 textAlign: TextAlign.center,
      //                               ),
      //                             ),
      //                             IconButton(
      //                                 onPressed: () {
      //                                   Navigator.pop(context);
      //                                 },
      //                                 icon: const Icon(
      //                                   Icons.close_rounded,
      //                                   color: Colors.white,
      //                                 )),
      //                           ],
      //                         ),
      //                         Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.center,
      //                           children: [
      //                             const Text(
      //                               "Support person : ",
      //                               style: TextStyle(
      //                                   fontSize: 15,
      //                                   fontWeight: FontWeight.bold,
      //                                   color: Colors.white),
      //                             ),
      //                             Text(
      //                               "Ezhil Raj ",
      //                               style: TextStyle(
      //                                   fontSize: 15,
      //                                   fontWeight: FontWeight.bold,
      //                                   color: Colors.grey.shade300),
      //                             ),
      //                             Text(
      //                               "(abcd@gmail.com)",
      //                               style: TextStyle(
      //                                   fontSize: 15,
      //                                   fontWeight: FontWeight.bold,
      //                                   color: Colors.grey.shade300),
      //                             ),
      //                             const Padding(
      //                               padding: EdgeInsets.all(2.0),
      //                               child: Icon(Icons.call,
      //                                   color: Colors.white, size: 18.0),
      //                             )
      //                           ],
      //                         ),
      //                         const SizedBox(
      //                           height: 10,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 buildRow(),
      //               ],
      //             ),
      //           );
      //         },
      //       );
      //     },
      //     style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
      //     child: const Text('Submit'),
      //   ),
      // ),
      DraggableWidget(
        verticalSpace: 30,
        bottomMargin: Get.height / 6.5,
        topMargin: 30,
        horizontalSpace: 30,
        // bottomMargin: MediaQuery.of(context).size.height / 6.5,
        // topMargin: MediaQuery.of(context).size.height / 50,
        // horizontalSpace: MediaQuery.of(context).size.width / 20,
        intialVisibility: true,
        shadowBorderRadius: 50,
        initialPosition: AnchoringPosition.bottomRight,
        dragController: dragController,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryClr,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              showDialog(
                context: Get.context!,
                builder: (context) {
                  return Dialog(
                    insetPadding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
                    backgroundColor: primaryClr,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 16,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: primaryClr,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      "Ezhil Raj ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade300),
                                    ),
                                    Text(
                                      "(abcd@gmail.com)",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade300),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.call),
                                        onPressed: () async {
                                          launchUrl("tel:+916383421413");
                                        },
                                        color: Colors.white,
                                        iconSize: 18.0)
                                  ],
                                ),
                                // const SizedBox(
                                //   height: 0,
                                // ),
                              ],
                            ),
                          ),
                        ),
                        buildRow(context),
                      ],
                    ),
                  );
                },
              );
            },
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    launch(url);
  } else {
    throw "Could not launch $url";
  }
}

Widget buildRow(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.0),
    child: Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(children: [
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
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                              items: _dropdownValues
                                  .map((value) => DropdownMenuItem(
                                        child: Text(value),
                                        value: value,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                controller.issueType.value = value!;
                              },
                              isExpanded: true,
                              value: controller.issueType.value,
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
                    style: TextStyle(fontSize: 18),
                    cursorHeight: 25.0,
                    textDirection: TextDirection.ltr,
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: const Text(
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
                                    elevation: 5,
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40)),
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
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(
                                    allowMultiple: true, type: FileType.image);
                            if (result == null) {
                              print("No file selected");
                            } else {
                              result.files.forEach((element) {
                                // print('test: ${element.name}');
                                controller.fileList.add(element);
                              });
                              // setState(() {});
                            }
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                child: Card(
                                  elevation: 5,
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
                                  left: controller.fileList.length <= 99
                                      ? 25
                                      : 20,
                                  bottom: 28,
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
                                  Image.file(
                                      File(controller.fileList[index].path)),
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
                      onPressed: () {
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 6),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '"Issue reported, Your Report Id is - "9876543"'),
                          ),
                        ));
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
        ),
      ],
    ),
  );
}

Widget getrowdata(BuildContext context, String text, String value) => Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Text(
          //   text,
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          // ),
          // const Text(
          //   " : ",
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          // ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          )
        ],
      ),
    );
