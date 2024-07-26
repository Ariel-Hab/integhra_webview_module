// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// import '../../../../controllers/home_controller.dart';

// class Body extends StatelessWidget {
//   Body({Key? key}) : super(key: key);

//   final HomeController _homeController = Get.put(HomeController());

//   //JH En lugar de crear una instancia directamente con InAppWebViewController(), debemos utilizar el controlador proporcionado por el InAppWebView. 
//   //JH se eliminó la inicialización final InAppWebViewController controller = InAppWebViewController(); ya que el controlador se obtiene automáticamente a través del callback onWebViewCreated.

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Obx(() {
//         if (_homeController.isLoading.value) {
//           print("+++++++++++++ integhra_webview !!!!!!!!!! body IS LOADING...");
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           print("+++++++++++++ integhra_webview !!!!!!!!!!  body LOADED !!! - URL ${globals.uri}");
//           return InAppWebView(
//             initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
//             initialOptions: InAppWebViewGroupOptions(
//               crossPlatform: InAppWebViewOptions(
//                 useShouldOverrideUrlLoading: true,
//                 javaScriptEnabled: true,
//                 transparentBackground: true,
//               ),
//             ),
//             shouldOverrideUrlLoading: (controller, navigationAction) async {
//               //var uri = navigationAction.request.url;
//               // if (uri.toString().startsWith('https://www.youtube.com/')) {
//               //   return NavigationActionPolicy.CANCEL;
//               // }
//               return NavigationActionPolicy.ALLOW;
//             },
//             onLoadStart: (controller, url) {},
//             onLoadStop: (controller, url) {},
//             onProgressChanged: (controller, progress) {
//               // Actualizar la barra de carga.
//             },
//             onWebViewCreated: (controller) {
//               controller.clearCache();
//               controller.addJavaScriptHandler(
//                 handlerName: 'messageHandler',
//                 callback: (args) {
//                   //final message = args.first as String;
//                   //print('!!!!!!!!!!!!!!! Message received from JavaScript - args     : $args');
//                   if (args.isNotEmpty) {
//                     String message = args.first.toString();
//                     print('+++++++++++++ integhra_webview - Message received from JavaScript: $message');
//                     // Llama a la función de devolución de llamada en el HomeController
//                     _homeController.receiveDataFromWeb(message);  
//                   }                  

//                   //JH en la app web pasar los datos con javascript: 
//                   // Espera a que la página se haya cargado completamente
//                   // window.addEventListener('load', (event) => {
//                   //   // Llama al handler de JavaScript en la aplicación Flutter
//                   //   window.flutter_inappwebview.callHandler('messageHandler', 'Datos de ejemplo');
//                   // });

//                   // print("********** JH Mensaje enviado DESDE la WEB a la APP Webview al mover el Switch = \"$message\"");
//                   // final script = "document.getElementById('valor').innerText=\"$message\"";
//                   // controller.evaluateJavascript(source: script);

//                   //JH Script a incluir en index.html (header o body), lo copié en el html generado con callHandler = messageHandler y funcionó
//                   // <script>
//                   //   // JavaScript code here
//                   //   window.addEventListener("flutterInAppWebViewPlatformReady", function(event) {
//                   //     window.flutter_inappwebview.callHandler('handlerFoo')
//                   //       .then(function(result) {
//                   //         console.log(result);
//                   //         window.flutter_inappwebview.callHandler('handlerFooWithArgs', 1, true, ['bar', 5], { foo: 'baz' }, result);
//                   //       });
//                   //   });

//                   //   function myFunction(data) {
//                   //     // Perform actions with the received data
//                   //     console.log('Received data:', data);

//                   //     // Call the Flutter handler function
//                   //     window.flutter_inappwebview.callHandler('handlerBar', { 'param': 'value' })
//                   //       .then(function(result) {
//                   //         console.log('Response from Flutter:', result);
//                   //       });
//                   //   }
//                   // </script>
//                 },
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }


// //JH Integración con la app web a traves de eventos segun chatgpt DESPUES DIJO QUE NO SIRVE EVENTS PARA COMM CON APP WEB
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// // import '../../../../controllers/home_controller.dart';
// // import 'package:event/event.dart';


// // class StringEventArgs implements EventArgs {
// //   final String value;

// //   StringEventArgs(this.value);
// // }

// // class WebViewEvent {
// //   final Event<StringEventArgs> returnParamEvent = Event<StringEventArgs>();
// // }

// // class Body extends StatelessWidget {
// //   Body({Key? key}) : super(key: key);

// //   final HomeController _homeController = Get.put(HomeController());

// //   final WebViewEvent webViewEvent = WebViewEvent();

// //   //JH En lugar de crear una instancia directamente con InAppWebViewController(), debemos utilizar el controlador proporcionado por el InAppWebView. 
// //   //JH se eliminó la inicialización final InAppWebViewController controller = InAppWebViewController(); ya que el controlador se obtiene automáticamente a través del callback onWebViewCreated.

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Obx(() {
// //         if (_homeController.isLoading.value) {
// //           print("----------------------------------------------!!!!!!!!!! body IS LOADING...");
// //           return const Center(child: CircularProgressIndicator());
// //         } else {
// //           print("----------------------------------------------!!!!!!!!!! body LOADED !!! - URL ${globals.uri}");
// //           return InAppWebView(
// //             initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
// //             initialOptions: InAppWebViewGroupOptions(
// //               crossPlatform: InAppWebViewOptions(
// //                 useShouldOverrideUrlLoading: true,
// //                 javaScriptEnabled: true,
// //                 transparentBackground: true,
// //               ),
// //             ),
// //             shouldOverrideUrlLoading: (controller, navigationAction) async {
// //               var uri = navigationAction.request.url;
// //               // if (uri.toString().startsWith('https://www.youtube.com/')) {
// //               //   return NavigationActionPolicy.CANCEL;
// //               // }
// //               return NavigationActionPolicy.ALLOW;
// //             },
// //             onLoadStart: (controller, url) {},
// //             onLoadStop: (controller, url) {},
// //             onProgressChanged: (controller, progress) {
// //               // Actualizar la barra de carga.
// //             },
// //             onWebViewCreated: (controller) {
// //               controller.addJavaScriptHandler(
// //                 handlerName: 'messageHandler',
// //                 callback: (args) {
// //                   final message = args.first as String;
// //                   print("********** JH Mensaje enviado DESDE la WEB a la APP Webview al mover el Switch = \"$message\"");
                  
// //                   // Emitir el evento de retorno con el parámetro deseado
// //                   webViewEvent.returnParamEvent.broadcast(StringEventArgs('Value of return'));
                  
// //                   final script = "document.getElementById('valor').innerText=\"$message\"";
// //                   controller.evaluateJavascript(source: script);
// //                 },
// //               );
// //             },
// //           );
// //         }
// //       }),
// //     );
// //   }
// // }


// //JH OK flutter_inappwebview mejorado por chatgpt
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// // import '../../../../controllers/home_controller.dart';

// // class Body extends StatelessWidget {
// //   Body({Key? key}) : super(key: key);

// //   final HomeController _homeController = Get.put(HomeController());

// //   //JH En lugar de crear una instancia directamente con InAppWebViewController(), debemos utilizar el controlador proporcionado por el InAppWebView. 
// //   //JH se eliminó la inicialización final InAppWebViewController controller = InAppWebViewController(); ya que el controlador se obtiene automáticamente a través del callback onWebViewCreated.

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Obx(() {
// //         if (_homeController.isLoading.value) {
// //           print("----------------------------------------------!!!!!!!!!! body IS LOADING...");
// //           return const Center(child: CircularProgressIndicator());
// //         } else {
// //           print("----------------------------------------------!!!!!!!!!! body LOADED !!! - URL ${globals.uri}");
// //           return InAppWebView(
// //             initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
// //             initialOptions: InAppWebViewGroupOptions(
// //               crossPlatform: InAppWebViewOptions(
// //                 useShouldOverrideUrlLoading: true,
// //                 javaScriptEnabled: true,
// //                 transparentBackground: true,
// //               ),
// //             ),
// //             shouldOverrideUrlLoading: (controller, navigationAction) async {
// //               var uri = navigationAction.request.url;
// //               // if (uri.toString().startsWith('https://www.youtube.com/')) {
// //               //   return NavigationActionPolicy.CANCEL;
// //               // }
// //               return NavigationActionPolicy.ALLOW;
// //             },
// //             onLoadStart: (controller, url) {},
// //             onLoadStop: (controller, url) {},
// //             onProgressChanged: (controller, progress) {
// //               // Actualizar la barra de carga.
// //             },
// //             onWebViewCreated: (controller) {
// //               controller.addJavaScriptHandler(
// //                 handlerName: 'messageHandler',
// //                 callback: (args) {
// //                   final message = args.first as String;
// //                   print("********** JH Mensaje enviado DESDE la WEB a la APP Webview al mover el Switch = \"$message\"");
// //                   final script = "document.getElementById('valor').innerText=\"$message\"";
// //                   controller.evaluateJavascript(source: script);
// //                 },
// //               );
// //             },
// //           );
// //         }
// //       }),
// //     );
// //   }
// // }



// //JH OK con flutter_inappwebview de chatgpt
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// // import '../../../../controllers/home_controller.dart';

// // class Body extends StatelessWidget {
// //   Body({Key? key}) : super(key: key);

// //   //final InAppWebViewController controller = InAppWebViewController();
// //   InAppWebViewController? controller;
// //   final HomeController _homeController = Get.put(HomeController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Obx(() {
// //         if (_homeController.isLoading.value) {
// //           print("////////////////////////////////////////////////// body isLoading TRUE");
// //           return const Center(child: CircularProgressIndicator());
// //         } else {
// //           print("////////////////////////////////////////////////// body isLoading FALSE - URL ${globals.uri}");
// //           return InAppWebView(
// //             initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
// //             initialOptions: InAppWebViewGroupOptions(
// //               crossPlatform: InAppWebViewOptions(
// //                 useShouldOverrideUrlLoading: true,
// //                 javaScriptEnabled: true,
// //                 transparentBackground: true,
// //               ),
// //             ),
// //             shouldOverrideUrlLoading: (controller, navigationAction) async {
// //               var uri = navigationAction.request.url;
// //               if (uri.toString().startsWith('https://www.youtube.com/')) {
// //                 return NavigationActionPolicy.CANCEL;
// //               }
// //               return NavigationActionPolicy.ALLOW;
// //             },
// //             onLoadStart: (controller, url) {},
// //             onLoadStop: (controller, url) {},
// //             onProgressChanged: (controller, progress) {
// //               // Actualizar la barra de carga.
// //             },
// //             onWebViewCreated: (controller) {
// //               controller.addJavaScriptHandler(
// //                 handlerName: 'messageHandler',
// //                 callback: (args) {
// //                   final message = args.first as String;
// //                   print("********** JH Mensaje enviado DESDE la WEB a la APP Webview al mover el Switch = \"$message\"");
// //                   final script = "document.getElementById('valor').innerText=\"$message\"";
// //                   controller.evaluateJavascript(source: script);
// //                 },
// //               );
// //             },
// //           );
// //         }
// //       }),
// //     );
// //   }
// // }



// //JH OK reescrito por chatgpt
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
// // import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// // import '../../../../controllers/home_controller.dart';

// // class Body extends StatelessWidget {
// //   Body({Key? key}) : super(key: key);

// //   final WebViewController controller = WebViewController();
// //   final HomeController _homeController = Get.put(HomeController());

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Obx(() {
// //         if (_homeController.isLoading.value) {
// //           print("------------------------------------------------ body isLoading TRUE");
// //           return const Center(child: CircularProgressIndicator());
// //         } else {
// //           print("------------------------------------------------ body isLoading FALSE - URL ${globals.uri}");
// //           controller.clearCache();
// //           controller.setJavaScriptMode(JavaScriptMode.unrestricted);
// //           controller.setBackgroundColor(const Color(0x00000000));
// //           controller.addJavaScriptChannel(
// //             'messageHandler',
// //             onMessageReceived: (JavaScriptMessage message) {
// //               print("********** JH Mensaje enviado DESDE la WEB a la APP Webview al mover el Switch = \"${message.message}\"");
// //               final script = "document.getElementById('valor').innerText=\"${message.message}\"";
// //               controller.runJavaScript(script); // Usar el controlador actual en lugar de crear uno nuevo
// //             },
// //           );
// //           controller.setNavigationDelegate(
// //             NavigationDelegate(
// //               onProgress: (int progress) {
// //                 // Actualizar la barra de carga.
// //               },
// //               onPageStarted: (String url) {
// //                 // url = 'about:blank'; // Comentado ya que no se utiliza
// //               },
// //               onPageFinished: (String url) {},
// //               onWebResourceError: (WebResourceError error) {},
// //               onNavigationRequest: (NavigationRequest request) {
// //                 if (request.url.startsWith('https://www.youtube.com/')) {
// //                   return NavigationDecision.prevent;
// //                 }
// //                 return NavigationDecision.navigate;
// //               },
// //             ),
// //           );
// //           controller.loadRequest(Uri.parse(globals.uri));
// //           print("--------------------------------------- ANTES QUE WebViewWidget ---------------------------");
// //           return WebViewWidget(controller: controller);
// //         }
// //       }),
// //     );
// //   }
// // }



// //JH OK sin controller pasado por home_page
// //
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
// // import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// // import '../../../../controllers/home_controller.dart';


// // class Body extends StatelessWidget {
// //   Body({
// //     super.key,
// //     //controller,
// //   });

// //   final WebViewController controller = WebViewController();
// //   final HomeController _homeController = Get.put(HomeController()); 

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(child: Obx(() {

// //       if (_homeController.isLoading.value) {
// //         print("------------------------------------------------ body isLoading TRUE");
// //         return const Center(child: CircularProgressIndicator());
      
// //       } else {
// //         print("------------------------------------------------ body isLoading FALSE - URL ${globals.uri}");
// //         controller.clearCache();
// //         controller.setJavaScriptMode(JavaScriptMode.unrestricted);
// //         controller.setBackgroundColor(const Color(0x00000000));
// //         controller.addJavaScriptChannel(
// //           'messageHandler', 
// //           onMessageReceived: (JavaScriptMessage message) {
// //             print("********** JH Mensaje enviado DESDE la WEB a la APP Webview al mover el Switch = \"${message.message}\"");
// //             final script = "document.getElementById('valor').innerText=\"${message.message}\"";
// //             WebViewController().runJavaScript(script);
// //           },
// //         );
// //         controller.setNavigationDelegate(
// //           NavigationDelegate(
// //             onProgress: (int progress) {
// //               // Update loading bar.
// //             },
// //             onPageStarted: (String url) {
// //               url = 'about:blank';
// //             },
// //             onPageFinished: (String url) {},
// //             onWebResourceError: (WebResourceError error) {},
// //             onNavigationRequest: (NavigationRequest request) {
// //               if (request.url.startsWith('https://www.youtube.com/')) {
// //                 return NavigationDecision.prevent;
// //               }
// //               return NavigationDecision.navigate;
// //             },
// //           ),
// //         );
// //         controller.loadRequest(Uri.parse(globals.uri));
// //         print("--------------------------------------- ANTES QUE WebViewWidget ---------------------------");
// //         return WebViewWidget(controller: controller);
// //       }
// //     }));
// //   }

// // }



// //JH OK original
// //
// // class Body extends StatelessWidget {
// //   Body({
// //     super.key,
// //     controller,
// //   });

//   // final WebViewController controller = WebViewController();
//   // final HomeController _homeController = Get.put(HomeController()); 

//   // @override
//   // Widget build(BuildContext context) {
//   //   return SafeArea(child: Obx(() {

//   //     if (_homeController.isLoading.value) {
//   //       print("================================ body isLoading TRUE");
//   //       return const Center(child: CircularProgressIndicator());
      
//   //     } else {
//   //       print("================================ body isLoading FALSE - URL ${globals.uri}");
//   //       controller.clearCache();
//   //       controller.setJavaScriptMode(JavaScriptMode.unrestricted);
//   //       controller.setBackgroundColor(const Color(0x00000000));
//   //       controller.addJavaScriptChannel(
//   //         'messageHandler', 
//   //         onMessageReceived: (JavaScriptMessage message) {
//   //           print("********** JH Mensaje enviado DESDE la WEB a la APP Webview al mover el Switch = \"${message.message}\"");
//   //           final script = "document.getElementById('valor').innerText=\"${message.message}\"";
//   //           WebViewController().runJavaScript(script);
//   //         },
//   //       );
//   //       controller.setNavigationDelegate(
//   //         NavigationDelegate(
//   //           onProgress: (int progress) {
//   //             // Update loading bar.
//   //           },
//   //           onPageStarted: (String url) {
//   //             url = 'about:blank';
//   //           },
//   //           onPageFinished: (String url) {},
//   //           onWebResourceError: (WebResourceError error) {},
//   //           onNavigationRequest: (NavigationRequest request) {
//   //             // if (request.url.startsWith('https://www.youtube.com/')) {
//   //             //   return NavigationDecision.prevent;
//   //             // }
//   //             return NavigationDecision.navigate;
//   //           },
//   //         ),
//   //       );
//   //       controller.loadRequest(Uri.parse(globals.uri));
//   //       print("+++++++++++++++++++++++++++++++++++++++++++++ ANTES QUE WebViewWidget +++++++++++++++++++");
//   //       return WebViewWidget(controller: controller);
//   //     }
//   //   }));
//   // }

// // }
