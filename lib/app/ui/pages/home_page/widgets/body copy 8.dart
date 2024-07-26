// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// import '../../../../controllers/home_controller.dart';


// class Body extends StatelessWidget {
//   const Body({Key? key, required this.homeController}) : super(key: key);

//   final HomeController homeController;

//   //reemplazar print x debugPrint

//   // void _showBackDialog(BuildContext context) {
//   //   showDialog<void>(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text(
//   //           'CONFIRMAR!',
//   //           style: TextStyle(
//   //             fontSize: 16,
//   //             color: Colors.red,
//   //             fontWeight: FontWeight.bold,
//   //           ),
//   //         ),
//   //         content: const Text(
//   //           'Seguro que quiere salir de Integhra?',
//   //           style: TextStyle(
//   //             fontSize: 16,
//   //             color: Colors.black87,
//   //             fontWeight: FontWeight.bold,
//   //           ),
//   //         ),
//   //         actions: <Widget>[
//   //           TextButton(
//   //             style: TextButton.styleFrom(
//   //               textStyle: Theme.of(context).textTheme.labelLarge,
//   //             ),
//   //             child: const Text(
//   //               'NO',
//   //               style: TextStyle(
//   //                 fontSize: 16,
//   //                 color: Colors.green,
//   //                 fontWeight: FontWeight.bold,
//   //               ),
//   //             ),
//   //             onPressed: () {
//   //               Navigator.pop(context);
//   //             },
//   //           ),
//   //           TextButton(
//   //             style: TextButton.styleFrom(
//   //               textStyle: Theme.of(context).textTheme.labelLarge,
//   //             ),
//   //             child: const Text(
//   //               'Si',
//   //               style: TextStyle(
//   //                 fontSize: 16,
//   //                 color: Colors.red,
//   //                 fontWeight: FontWeight.bold,
//   //               ),
//   //             ),
//   //             onPressed: () {                
//   //               Navigator.pop(context);
//   //               Navigator.pop(context);
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
  
//   // @override
//   // Widget build(BuildContext context) {
//   //   return PopScope(
//   //     canPop: false,
//   //     onPopInvoked: (bool didPop) {
//   //       if (didPop) {
//   //         return;
//   //       }
//   //       _showBackDialog(context);
//   //     },
//   //     // canPop: false, // Permitir la navegación hacia atrás
//   //     // onPopInvoked: (bool didPop) {
//   //     //   if (!didPop) {
//   //     //     _showBackDialog(context); // Mostrar el diálogo al intentar salir
//   //     //   }
//   //     // },
//   //     // onPopInvoked: (bool didPop) {        
//   //     //   _showBackDialog(context);        
//   //     // },
//   //     // onPopInvoked: (bool didPop) {
//   //     //   if (didPop) {
//   //     //     _showBackDialog(context); // Mostrar el diálogo al intentar salir
//   //     //   }
//   //     // },
//   //     // canPop: false,
//   //     // onPopInvoked: (bool didPop) {
//   //     //   if (didPop) {
//   //     //     return;
//   //     //   }
//   //     //   _showBackDialog(context);
//   //     // },
      
//   //     child: SafeArea(
//   //       child: Obx(() {
//   //         if (homeController.isLoading.value) {
//   //           print("+++++++++++++ integhra_webview !!!!!!!!!! body IS LOADING...");
//   //           return const Center(child: CircularProgressIndicator());
//   //         } else {
//   //           print("+++++++++++++ integhra_webview !!!!!!!!!!  body LOADED !!! - URL ${globals.uri}");
//   //           // return InAppWebView(
//   //           //   initialUrlRequest: URLRequest(url: WebUri(globals.uri)),
//   //           //   initialSettings: InAppWebViewSettings(
//   //           //     useShouldOverrideUrlLoading: true,
//   //           //     javaScriptEnabled: true,
//   //           //     transparentBackground: true,
//   //           //     clearCache: true,
//   //           //   ),            
//   //           //   shouldOverrideUrlLoading: shouldOverrideUrlLoading,
//   //           //   onLoadStart: (controller, url) {},
//   //           //   onLoadStop: (controller, url) {},
//   //           //   onProgressChanged: (controller, progress) {
//   //           //     // Actualizar la barra de carga.
//   //           //   },
//   //           //   onWebViewCreated: handleWebViewCreated,
//   //           // );
//   //           return InAppWebView(
//   //             initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
//   //             initialOptions: InAppWebViewGroupOptions(
//   //               crossPlatform: InAppWebViewOptions(
//   //                 useShouldOverrideUrlLoading: true,
//   //                 javaScriptEnabled: true,
//   //                 transparentBackground: true,
//   //               ),
//   //             ),
//   //             shouldOverrideUrlLoading: shouldOverrideUrlLoading,
//   //             onLoadStart: (controller, url) {},
//   //             onLoadStop: (controller, url) {},
//   //             onProgressChanged: (controller, progress) {
//   //               // Actualizar la barra de carga.
//   //             },
//   //             onWebViewCreated: handleWebViewCreated,
//   //           );
//   //         }
//   //       }),
//   //     ),
//   //   );
//   // }

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

//   // Future<NavigationActionPolicy> shouldOverrideUrlLoading(
//   //   InAppWebViewController controller,
//   //   NavigationAction navigationAction,
//   // ) async {
//   //   return NavigationActionPolicy.ALLOW;
//   // }

//   Future<NavigationActionPolicy> shouldOverrideUrlLoading(
//     InAppWebViewController controller,
//     NavigationAction navigationAction,
//   ) async {    
//     print("************* integhra_webview !!!!!!!!!! shouldOverrideUrlLoading");
//     var uri = navigationAction.request.url!;
//     print("************* integhra_webview !!!!!!!!!! shouldOverrideUrlLoading URI... ${uri.toString()}");
//     if (uri.toString() == "back_pressed") {
//       // Aquí notificas a la aplicación Flutter que se ha presionado el botón de retroceso
//       // Puedes hacerlo enviando un mensaje JavaScript o utilizando la interfaz de comunicación entre Flutter y WebView
//       return NavigationActionPolicy.CANCEL; // Cancela la navegación para evitar cargar la URL "back_pressed"
//     }
//     return NavigationActionPolicy.ALLOW; // Permite la navegación normalmente
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

