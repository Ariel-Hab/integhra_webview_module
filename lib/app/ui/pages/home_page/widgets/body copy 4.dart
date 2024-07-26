// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// import '../../../../controllers/home_controller.dart';


// class Body extends StatelessWidget {
//   const Body({Key? key, required this.homeController}) : super(key: key);

//   final HomeController homeController;

//   //reemplazar print x debugPrint
  
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Obx(() {
//         if (homeController.isLoading.value) {
//           print("+++++++++++++ integhra_webview !!!!!!!!!! body IS LOADING...");
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           print("+++++++++++++ integhra_webview !!!!!!!!!!  body LOADED !!! - URL ${globals.uri}");
//           // return InAppWebView(
//           //   initialUrlRequest: URLRequest(url: WebUri(globals.uri)),
//           //   initialSettings: InAppWebViewSettings(
//           //     useShouldOverrideUrlLoading: true,
//           //     javaScriptEnabled: true,
//           //     transparentBackground: true,
//           //     clearCache: true,
//           //   ),            
//           //   shouldOverrideUrlLoading: shouldOverrideUrlLoading,
//           //   onLoadStart: (controller, url) {},
//           //   onLoadStop: (controller, url) {},
//           //   onProgressChanged: (controller, progress) {
//           //     // Actualizar la barra de carga.
//           //   },
//           //   onWebViewCreated: handleWebViewCreated,
//           // );
//           return InAppWebView(
//             initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
//             initialOptions: InAppWebViewGroupOptions(
//               crossPlatform: InAppWebViewOptions(
//                 useShouldOverrideUrlLoading: true,
//                 javaScriptEnabled: true,
//                 transparentBackground: true,
//               ),
//             ),
//             shouldOverrideUrlLoading: shouldOverrideUrlLoading,
//             onLoadStart: (controller, url) {},
//             onLoadStop: (controller, url) {},
//             onProgressChanged: (controller, progress) {
//               // Actualizar la barra de carga.
//             },
//             onWebViewCreated: handleWebViewCreated,
//           );
//         }
//       }),
//     );
//   }

//   Future<NavigationActionPolicy> shouldOverrideUrlLoading(
//     InAppWebViewController controller,
//     NavigationAction navigationAction,
//   ) async {
//     return NavigationActionPolicy.ALLOW;
//   }

//   void handleWebViewCreated(InAppWebViewController controller) {
//     //InAppWebViewController.clearAllCache(includeDiskFiles: true);
//     controller.clearCache();
//     controller.addJavaScriptHandler(
//       handlerName: 'messageHandler',
//       callback: (args) {
//         if (args.isNotEmpty) {
//           String message = args.first.toString();
//           print('+++++++++++++ integhra_webview - Message received from JavaScript: $message');
//           homeController.receiveDataFromWeb(message);
//         }
//       },
//     );
//   }
// }

