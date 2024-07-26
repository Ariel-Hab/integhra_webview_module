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
//   late InAppWebViewController _webViewController;
//   bool _isWebViewInitialized = false;

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
//       // Ensure the WebView is properly reloaded when the app is resumed
//       if (_isWebViewInitialized) {
//         _webViewController.reload();
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Obx(() {
//           if (widget.homeController.isLoading.value) {
//             debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! body IS LOADING...");
//             return const Center(child: CircularProgressIndicator());
//           } else {
//             debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! body LOADED !!! - URL ${globals.uri}");
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
//               onWebViewCreated: (controller) {
//                 _webViewController = controller;
//                 _isWebViewInitialized = true;
//                 _webViewController.clearCache();
//                 _webViewController.addJavaScriptHandler(
//                   handlerName: 'messageHandler',
//                   callback: (args) {
//                     if (args.isNotEmpty) {
//                       String message = args.first.toString();
//                       debugPrint('+++++++++++++ integhra_webview - Message received from JavaScript: $message');
//                       widget.homeController.receiveDataFromWeb(message);
//                     }
//                   },
//                 );
//               },
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
// }
