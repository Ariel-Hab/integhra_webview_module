import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
import 'package:flutter/foundation.dart';



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
    debugPrint('+++++++++++++ integhra_webview - Estoy en onInit Home Controller');
    
    platform.setMethodCallHandler(_receiveFromHost);  

    super.onInit();
  }


  @override
  void onReady() {
    debugPrint('+++++++++++++ integhra_webview - onReady - Home Controller');
    super.onReady();
  }


  @override
  void onClose() {
    debugPrint('+++++++++++++ integhra_webview - onClose - Home Controller');
    super.onClose();
  }


  Future<void> _receiveFromHost(MethodCall call) async {
    try {

      isLoading(true);
      
      debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - isLoading TRUE");
      
      if (call.method == "getCalculatedResult") {
        debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - getCalculatedResult");
        final String data = call.arguments;
        var dataresp = json.decode(data);
        globals.distributortaxtype = dataresp['distributortaxtype'];
        globals.distributortaxid = dataresp['distributortaxid'];
        globals.authtoken = dataresp['authtoken'];
        globals.authtoken = globals.authtoken.replaceRange(0, 6, ''); //JH truncates token prefix
        globals.sessiontoken = dataresp['sessiontoken'];
        globals.user = dataresp['user'];

        debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - globals.distributortaxtype: ${globals.distributortaxtype} ");
        debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - globals.distributortaxid  : ${globals.distributortaxid} ");
        debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - globals.authtoken         : ${globals.authtoken} ");
        debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - globals.sessiontoken      : ${globals.sessiontoken} ");
        debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - globals.user              : ${globals.user} ");

        globals.uri = 'http://integhra-dev.ddns.net/#?distributortaxtype=${globals.distributortaxtype}&distributortaxid=${globals.distributortaxid}&authtoken=${globals.authtoken}&sessiontoken=${globals.sessiontoken}&username=${globals.user}&';

        uri.value = globals.uri;

        debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - globals.uri               : ${globals.uri} ");

      }
    } catch (e) {
      debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - ERROR: $e");
    } finally {
      isLoading(false);
      debugPrint("+++++++++++++ integhra_webview - _receiveFromHost - isLoading FALSE");
    }
   
  }

  
  Future<void> _sendParamToDistributor(data) async {
    try {            
      debugPrint("+++++++++++++ integhra_webview - _sendParamToDistributor - DATA:  $data ");
      globals.user = await platform2.invokeMethod("getWebviewParam", data);      
    } on PlatformException catch (e) {
      debugPrint("+++++++++++++ integhra_webview - _sendParamToDistributor - ERROR: $e");
      globals.user = '';
    }
  }


  void receiveDataFromWeb(String data) {
    debugPrint('+++++++++++++ integhra_webview - receiveDataFromWeb: $data');
    _sendParamToDistributor(data);
  }

}
