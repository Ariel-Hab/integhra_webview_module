// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
// import '../../../../controllers/home_controller.dart';

// class Body extends StatefulWidget {
//   const Body({Key? key, required this.homeController}) : super(key: key);

//   final HomeController homeController;

//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> with WidgetsBindingObserver {
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
//       // Forzar la orientación y luego restaurarla
//       ScreenUtil.init(context);
//       SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//       ]).then((_) {
//         SystemChrome.setPreferredOrientations([
//           DeviceOrientation.landscapeLeft,
//           DeviceOrientation.landscapeRight,
//         ]).then((_) {
//           SystemChrome.setPreferredOrientations([
//             DeviceOrientation.portraitUp,
//             DeviceOrientation.portraitDown,
//           ]);
//         });
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
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
//             return InAppWebView(
//               initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
//               initialOptions: InAppWebViewGroupOptions(
//                 crossPlatform: InAppWebViewOptions(
//                   useShouldOverrideUrlLoading: true,
//                   javaScriptEnabled: true,
//                   transparentBackground: true,
//                 ),
//               ),
//               shouldOverrideUrlLoading: shouldOverrideUrlLoading,
//               onLoadStart: (controller, url) {},
//               onLoadStop: (controller, url) {},
//               onProgressChanged: (controller, progress) {
//                 // Actualizar la barra de carga.
//               },
//               onWebViewCreated: handleWebViewCreated,
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
//           widget.homeController.receiveDataFromWeb(message);
//         }
//       },
//     );
//   }
// }
