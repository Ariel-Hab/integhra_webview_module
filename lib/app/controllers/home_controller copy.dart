import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// import 'package:flutter/material.dart';
// import 'dart:io';
//import 'package:localstorage/localstorage.dart';


class HomeController extends GetxController {
  static const platform = MethodChannel("com.example.integhra_webview_module/channel");

  static const platform2 = MethodChannel("com.example.integhra_webview_module/channel2");

  var distributortaxtype = "".obs;
  var distributortaxid = "".obs;
  var authtoken = "".obs;
  var sessiontoken = "".obs;
  var user = "".obs;
  var uri = "".obs;

  var isLoading = true.obs;

  final receivedMessage = ''.obs;

  //LocalStorage storage = LocalStorage('acknowledge');


  @override
  void onInit() {
    print('+++++++++++++ integhra_webview - Estoy en onInit Home Controller');

    platform.setMethodCallHandler(_receiveFromHost);   

    //JH Prueba de recibir desde Flutter I
    // _getWebviewParam();
    //JH Prueba de recibir desde Flutter F

    //iniReceiveFromHost();

    super.onInit();
  }


  @override
  void onReady() {
    print('+++++++++++++ integhra_webview - onReady - Home Controller');

    //JH Prueba de recibir desde Flutter I
    // _getWebviewParam();
    //JH Prueba de recibir desde Flutter F

    super.onReady();
  }


  @override
  void onClose() {
    print('+++++++++++++ integhra_webview - onClose - Home Controller');
    super.onClose();
  }


  Future<void> _receiveFromHost(MethodCall call) async {
    try {

      isLoading(true);
      
      print("+++++++++++++ integhra_webview - _receiveFromHost - isLoading TRUE");
      
      if (call.method == "getCalculatedResult") {
        print("+++++++++++++ integhra_webview - _receiveFromHost - getCalculatedResult");
        final String data = call.arguments;
        var dataresp = json.decode(data);
        globals.distributortaxtype = dataresp['distributortaxtype'];
        globals.distributortaxid = dataresp['distributortaxid'];
        globals.authtoken = dataresp['authtoken'];
        globals.authtoken = globals.authtoken.replaceRange(0, 6, ''); //JH truncates token prefix
        globals.sessiontoken = dataresp['sessiontoken'];
        globals.user = dataresp['user'];

        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.distributortaxtype: ${globals.distributortaxtype} ");
        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.distributortaxid  : ${globals.distributortaxid} ");
        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.authtoken         : ${globals.authtoken} ");
        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.sessiontoken      : ${globals.sessiontoken} ");
        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.user              : ${globals.user} ");

        globals.uri = 'http://integhra-dev.ddns.net/#?distributortaxtype=${globals.distributortaxtype}&distributortaxid=${globals.distributortaxid}&authtoken=${globals.authtoken}&sessiontoken=${globals.sessiontoken}&username=${globals.user}&';

        uri.value = globals.uri;

        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.uri                 : ${globals.uri} ");

      }
      // } on PlatformException catch (error) {
      //   print(error);
      // }
    } finally {
      isLoading(false);
      print("+++++++++++++ integhra_webview - _receiveFromHost - isLoading FALSE");
    }
   
  }

  
  Future<void> _sendParamToDistributor(data) async {
    try {            
      print("+++++++++++++ integhra_webview - _sendParamToDistributor - DATA:  $data ");
      globals.user = await platform2.invokeMethod("getWebviewParam", data);      
    } on PlatformException catch (e) {
      print("+++++++++++++ integhra_webview - _sendParamToDistributor - ERROR: $e");
      globals.user = '';
    }
  }


  void receiveDataFromWeb(String data) {
    print('+++++++++++++ integhra_webview - receiveDataFromWeb: $data');
    _sendParamToDistributor(data);
  }
  

  // void iniReceiveFromHost() async {
  //   try {
  //     isLoading(true);
  //     print("---------------------------------------- iniReceiveFromHost isLoading TRUE");
  //     platform.setMethodCallHandler(_receiveFromHost);
  //   } finally {
  //     isLoading(false);
  //     print("---------------------------------------- iniReceiveFromHost isLoading FALSE");
  //   }
  // }

  // Future<void> _getWebviewParam() async {
  //   try {
  //     print("+++++++++++++ integhra_webview - _getWebviewParam INICIO");
  //     // final arguments = {
  //     //   'key1': 'value1',
  //     //   'key2': 2,
  //     //   'key3': true,
  //     // };
  //     final arguments = {
  //       'name': 'John Doe',
  //       'age': 30,
  //       'address': {
  //         'street': '123 Main St',
  //         'city': 'Example City',
  //       },
  //       'hobbies': ['reading', 'traveling', 'photography'],
  //     };
  //     globals.user = await platform2.invokeMethod("getWebviewParam", arguments);
  //     //print(globals.webviewUserName.runtimeType);print(
  //     print("+++++++++++++ integhra_webview - _getWebviewParam - globals.webviewUserName:  ${globals.user} ");
  //   } on PlatformException catch (e) {
  //     print("+++++++++++++ integhra_webview - _getWebviewParam - globals.webviewUserName - ERROR: $e");
  //     globals.user = '';
  //   }
  // }

  // void setMessage(String message) {
  //   receivedMessage.value = message;
  // }

}
