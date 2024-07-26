import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;
import '../../../../controllers/home_controller.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.homeController});

  final HomeController homeController;

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> with WidgetsBindingObserver {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _isVisible = false;
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          _isVisible = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // JH con false inhibe el back del celular para toda la app Integhra (por DFV)
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
      },
      child: SafeArea(
        child: Obx(() {
          if (widget.homeController.isLoading.value) {
            debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! body IS LOADING...");
            return const Center(child: CircularProgressIndicator());
          } else {
            debugPrint("+++++++++++++ integhra_webview !!!!!!!!!!  body LOADED !!! - URL ${globals.uri}");
            return AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    javaScriptEnabled: true,
                    transparentBackground: true,
                    //cacheEnabled: false, // Desactivar cache
                  ),
                ),
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  return await handleShouldOverrideUrlLoading(controller, navigationAction);
                },
                onLoadStart: (controller, url) {},
                onLoadStop: (controller, url) {},
                onProgressChanged: (controller, progress) {
                  // Actualizar la barra de carga.
                },
                onWebViewCreated: handleWebViewCreated,
              ),
            );
          }
        }),
      ),
    );
  }

Future<NavigationActionPolicy> handleShouldOverrideUrlLoading(
  InAppWebViewController controller,
  NavigationAction navigationAction,
) async {
  var url = navigationAction.request.url;


  if (url != null && url.scheme.startsWith('http')) {
    if (await canLaunchUrl(url) ) {
      if (await supportsLaunchMode(LaunchMode.externalApplication)){
        await launchUrl(url, mode: LaunchMode.externalApplication);
      
      }else{
        _openBrowser(url.toString());
      }
      return NavigationActionPolicy.CANCEL; // Prevent navigation within webview
    } else {
      return NavigationActionPolicy.ALLOW; // Allow navigation if URL cannot be launched
    }
  }
  return NavigationActionPolicy.ALLOW; // Allow navigation for other URLs
}


  static const platform = MethodChannel('com.integhra.integhra_plus_app/browser');

  Future<void> _openBrowser(String url) async {
    try {
      await platform.invokeMethod('openBrowser', {'url': url});
    } on PlatformException catch (e) {
      print("Failed to open browser: '${e.message}'.");
    }
  }

  void handleWebViewCreated(InAppWebViewController controller) {
    // Limpiar la cache del WebView
    //controller.clearCache();

    controller.addJavaScriptHandler(
      handlerName: 'messageHandler',
      callback: (args) {
        if (args.isNotEmpty) {
          String message = args.first.toString();
          debugPrint('+++++++++++++ integhra_webview - Message received from JavaScript: $message');
          widget.homeController.receiveDataFromWeb(message);
        } else {
          debugPrint('+++++++++++++ integhra_webview - messageHandler - No arguments received !!!!!!!!!!');
        }
      },
    );
  }
}



