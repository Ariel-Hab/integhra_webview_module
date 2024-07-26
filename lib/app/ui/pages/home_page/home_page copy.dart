import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:integhra_webview_module/app/ui/pages/home_page/widgets/body.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  // final _webviewController = WebViewController()
  //   ..clearCache()
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..setBackgroundColor(const Color(0x00000000))
  //   ..addJavaScriptChannel(
  //       'messageHandler', 
  //       onMessageReceived: (JavaScriptMessage message) {
  //         print("********** JH Mensaje enviado DESDE la WEB a la APP Webview al mover el Switch = \"${message.message}\"");
  //         final script = "document.getElementById('valor').innerText=\"${message.message}\"";
  //         WebViewController().runJavaScript(script);
  //       },
  //   )
  //   ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {
  //         // Update loading bar.
  //       },
  //       onPageStarted: (String url) {
  //         url = 'about:blank';
  //       },
  //       onPageFinished: (String url) {},
  //       onWebResourceError: (WebResourceError error) {},
  //       onNavigationRequest: (NavigationRequest request) {
  //         if (request.url.startsWith('https://www.youtube.com/')) {
  //           return NavigationDecision.prevent;
  //         }
  //         return NavigationDecision.navigate;
  //       },
  //     ),
  //   )
  //   ..loadRequest(Uri.parse('https://flutter.dev'));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //body: Body()
        //body: Body(controller: _webviewController)
        );
  }
  
}



// class HomePage extends GetView<HomeController> {
//   final _webviewController = WebViewController()
//     ..clearCache()
//     //..clearLocalStorage()
//     ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     ..setBackgroundColor(const Color(0x00000000))
//     ..addJavaScriptChannel(
//         'messageHandler', 
//         onMessageReceived: (JavaScriptMessage message) {
//           print("********** JH Mensaje enviado DESDE la WEB a la APP Webview al mover el Switch = \"${message.message}\"");
//           final script = "document.getElementById('valor').innerText=\"${message.message}\"";
//           WebViewController().runJavaScript(script);
//         },
//     )
//     ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {
//           // Update loading bar.
//         },
//         onPageStarted: (String url) {
//           url = 'about:blank';
//         },
//         onPageFinished: (String url) {},
//         onWebResourceError: (WebResourceError error) {},
//         onNavigationRequest: (NavigationRequest request) {
//           // if (request.url.startsWith('https://www.youtube.com/')) {
//           //   return NavigationDecision.prevent;
//           // }
//           return NavigationDecision.navigate;
//         },
//       ),
//     )
//     ..loadRequest(Uri.parse('https://flutter.dev'));


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(
//         //   title: Text("TITULO"),
//         //   //title: Text(_homeController.user),
//         // ),
//         //body: initBody()
//         body: Body(controller: _webviewController)
//         //body: WebViewWidget(controller: _webviewController),
//         );
//   }
  
// }
