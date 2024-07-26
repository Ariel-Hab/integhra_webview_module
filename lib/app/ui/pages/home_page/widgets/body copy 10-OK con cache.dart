// import 'dart:convert';  // Importar el paquete dart:convert
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
//       setState(() {
//         _isVisible = false;
//       });
//       Future.delayed(const Duration(milliseconds: 100), () {
//         setState(() {
//           _isVisible = true;
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,  //JH con false inhibe el back del celular para toda la app Integhra (por DFV)
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
//             debugPrint("+++++++++++++ integhra_webview !!!!!!!!!!  body LOADED !!! - URL ${globals.uri}");
//             return AnimatedOpacity(
//               opacity: _isVisible ? 1.0 : 0.0,
//               duration: const Duration(milliseconds: 200),
//               child: InAppWebView(
//                 initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
//                 initialOptions: InAppWebViewGroupOptions(
//                   crossPlatform: InAppWebViewOptions(
//                     useShouldOverrideUrlLoading: true,
//                     javaScriptEnabled: true,
//                     transparentBackground: true,
//                   ),
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
//     controller.clearCache();
//     controller.addJavaScriptHandler(
//       handlerName: 'messageHandler',
//       callback: (args) {
//         if (args.isNotEmpty) {
//           String message = args.first.toString();
//           debugPrint('+++++++++++++ integhra_webview - Message received from JavaScript: $message');

//           // Aquí puedes manejar la lógica de actualización del caché basada en la versión recibida
//           var data = jsonDecode(message);
//           if (data['type'] == 'APP_VERSION_URL') {
//             String versionName = data['data']['versionName'];
//             debugPrint('Received version name: $versionName');
            
//             // Actualizar el cache si la version ha cambiado
//             controller.clearCache();
//             controller.reload();
//           }

//           widget.homeController.receiveDataFromWeb(message);
//         }
//       },
//     );
//   }
// }
