import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:testbot/testbot.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  //final _testbotPlugin = Testbot();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      // platformVersion = await _testbotPlugin.getPlatformVersion() ??
      'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  int change = 1;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
        actions: [
          IconButton(
              onPressed: () {
                change = change == 1 ? 2 : 1;
                setState(() {});
              },
              icon: Icon(Icons.change_circle))
        ],
      ),
      body: Stack(children: [
        Positioned(
            top: 10,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Card(
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
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            )),
        supportdialogue(
            bottommargin: Get.height / 6.5,
            topmargin: Get.height / 50,
            context: context,
            empid: '58402',
            clientId: '1000',
            appName: 'Bandhu',
            getEmpDetailsApi:
                'http://qa-chatbot.ppms.co.in/api/ChatBot/GetEmployeeDetailsById',
            getIssueTypeApi:
                'http://qa-chatbot.ppms.co.in/api/ChatBot/GetIssueTyeMaster',
            getPreDefineQueApi:
                'http://qa-chatbot.ppms.co.in/api/ChatBot/GetPreDefineQuestionMaster',
            insertSupportQueApi:
                'http://qa-chatbot.ppms.co.in/api/ChatBot/InsertSupportQuery',
            insertSupportQueTypeApi:
                'http://qa-chatbot.ppms.co.in/api/ChatBot/InsertSupportQueryType2',
            initialvisibility: true,
            module: change)
      ]),
    ));
  }
}
