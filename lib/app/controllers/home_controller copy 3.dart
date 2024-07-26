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
    print('+++++++++++++ integhra_webview - Estoy en onInit Home Controller');
    
    platform.setMethodCallHandler(_receiveFromHost);  

    super.onInit();
  }


  @override
  void onReady() {
    print('+++++++++++++ integhra_webview - onReady - Home Controller');
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
        var varEnvironment = dataresp['environment'];

        var varOrigin = 'mobile';

        //reemplazar print x debugPrint
        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.distributortaxtype: ${globals.distributortaxtype} ");
        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.distributortaxid  : ${globals.distributortaxid} ");
        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.authtoken         : ${globals.authtoken} ");
        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.sessiontoken      : ${globals.sessiontoken} ");
        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.user              : ${globals.user} ");
        print("+++++++++++++ integhra_webview - _receiveFromHost - varEnvironment            : $varEnvironment");

        if (varEnvironment == 'devddns') {
          globals.uri = 'http://integhra-dev.ddns.net/#?distributortaxtype=${globals.distributortaxtype}&distributortaxid=${globals.distributortaxid}&authtoken=${globals.authtoken}&sessiontoken=${globals.sessiontoken}&username=${globals.user}&origin=$varOrigin&';
        } else if (varEnvironment == 'devinteghra') {
          globals.uri = 'http://dev.integhra.com/#?distributortaxtype=${globals.distributortaxtype}&distributortaxid=${globals.distributortaxid}&authtoken=${globals.authtoken}&sessiontoken=${globals.sessiontoken}&username=${globals.user}&origin=$varOrigin&';
        } else if (varEnvironment == 'testinteghra') {
          globals.uri = 'http://test.integhra.com/#?distributortaxtype=${globals.distributortaxtype}&distributortaxid=${globals.distributortaxid}&authtoken=${globals.authtoken}&sessiontoken=${globals.sessiontoken}&username=${globals.user}&origin=$varOrigin&';
        } else if (varEnvironment == 'preprodinteghra') {
          globals.uri = 'https://preprod.integhra.com/#?distributortaxtype=${globals.distributortaxtype}&distributortaxid=${globals.distributortaxid}&authtoken=${globals.authtoken}&sessiontoken=${globals.sessiontoken}&username=${globals.user}&origin=$varOrigin&';
        } else if (varEnvironment == 'prodinteghra') {
          globals.uri = 'https://www.integhra.com/#?distributortaxtype=${globals.distributortaxtype}&distributortaxid=${globals.distributortaxid}&authtoken=${globals.authtoken}&sessiontoken=${globals.sessiontoken}&username=${globals.user}&origin=$varOrigin&';
        } else {
          throw FormatException('Wrong varEnvironment: $varEnvironment');
        }


        uri.value = globals.uri;

        print("+++++++++++++ integhra_webview - _receiveFromHost - globals.uri               : ${globals.uri} ");

      }
    } catch (e) {
      print("+++++++++++++ integhra_webview - _receiveFromHost - ERROR: $e");
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

}
