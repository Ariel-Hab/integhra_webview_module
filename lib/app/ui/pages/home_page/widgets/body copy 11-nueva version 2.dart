// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// import '../../../../controllers/home_controller.dart';

// class Body extends StatefulWidget {
//   const Body({super.key, required this.homeController});

//   final HomeController homeController;

//   @override
//   BodyState createState() => BodyState();
// }

// class BodyState extends State<Body> with WidgetsBindingObserver {
//   bool _isVisible = true;
//   String currentVersionName = "";

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _toggleVisibility();
//     }
//   }

//   void _toggleVisibility() {
//     setState(() {
//       _isVisible = false;
//     });
//     Future.microtask(() {
//       setState(() {
//         _isVisible = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,  // JH con false inhibe el back del celular para toda la app Integhra (por DFV)
//       onPopInvoked: (bool didPop) {
//         if (didPop) {
//           return;
//         }
//       },
//       child: SafeArea(
//         child: Obx(() {
//           if (widget.homeController.isLoading.value) {
//             debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! body IS LOADING...");
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! body LOADED !!! - URL ${globals.uri}");
//             return AnimatedOpacity(
//               opacity: _isVisible ? 1.0 : 0.0,
//               duration: const Duration(milliseconds: 200),
//               child: InAppWebView(
//                 initialUrlRequest: URLRequest(url: WebUri(globals.uri)),
//                 initialSettings: InAppWebViewSettings(
//                   useShouldOverrideUrlLoading: true,
//                   javaScriptEnabled: true,
//                   transparentBackground: true,
//                 ),
//                 shouldOverrideUrlLoading: shouldOverrideUrlLoading,
//                 onLoadStart: (controller, url) {},
//                 onLoadStop: (controller, url) {},
//                 onProgressChanged: (controller, progress) {
//                   // Actualizar la barra de carga.
//                 },
//                 onWebViewCreated: handleWebViewCreated,
//               ),
//             );
//           }
//         }),
//       ),
//     );
//   }

//   Future<NavigationActionPolicy> shouldOverrideUrlLoading(
//     InAppWebViewController controller,
//     NavigationAction navigationAction,
//   ) async {
//     return NavigationActionPolicy.ALLOW;
//   }

//   void handleWebViewCreated(InAppWebViewController controller) {
//     controller.addJavaScriptHandler(
//       handlerName: 'messageHandler',
//       callback: (args) {
//         if (args.isNotEmpty) {
//           String message = args.first.toString();
//           print('+++++++++++++ integhra_webview - Message received from JavaScript: $message');
//           widget.homeController.receiveDataFromWeb(message);
//         }
//       },
//     );

//     controller.addJavaScriptHandler(
//       handlerName: 'versionHandler',
//       callback: (args) {
//         if (args.isNotEmpty) {
//           String message = args.first.toString();
//           debugPrint('+++++++++++++ integhra_webview - Version message received from JavaScript: $message');

//           var data = jsonDecode(message);
//           if (data['type'] == 'APP_VERSION_URL') {
//             String versionName = data['data']['versionName'];
//             debugPrint('Received version name: $versionName');

//             // Solo limpiar y recargar si la versión ha cambiado
//             if (versionName != currentVersionName) {
//               currentVersionName = versionName;
//               InAppWebViewController.clearAllCache();
//               controller.reload();
//             }
//           }
//         }
//       },
//     );
//   }
// }
