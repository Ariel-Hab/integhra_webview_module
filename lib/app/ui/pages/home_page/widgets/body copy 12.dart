import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:integhra_webview_module/app/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:integhra_webview_module/app/data/provider/globals.dart' as globals;

class Body extends StatefulWidget {
  const Body({super.key, required this.homeController});

  final HomeController homeController;

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> with WidgetsBindingObserver {

  bool _isVisible = true;
  late String _currentVersion;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadCurrentVersion();
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
      canPop: true,   // JH con false inhibe el back del celular para toda la app Integhra (por DFV)
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
            debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! body LOADED !!! - URL ${globals.uri}");
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
                  ),
                ),
                shouldOverrideUrlLoading: shouldOverrideUrlLoading,
                onLoadStart: (controller, url) {},
                onLoadStop: (controller, url) {},
                onProgressChanged: (controller, progress) {
                  // Actualizar la barra de carga.
                },
                onWebViewCreated: (controller) {
                  handleWebViewCreated(controller);
                },
              ),
            );
          }
        }),
      ),
    );
  }

  Future<void> _loadCurrentVersion() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentVersion = prefs.getString('flutterVersionName') ?? '';
    });
  }

  Future<void> _saveCurrentVersion(String version) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('flutterVersionName', version);
    setState(() {
      _currentVersion = version;
    });
  }

  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    return NavigationActionPolicy.ALLOW;
  }

  void handleWebViewCreated(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
      handlerName: 'messageHandler',
      callback: (args) {
        if (args.isNotEmpty) {
          String message = args.first.toString();
          debugPrint('+++++++++++++ integhra_webview - Message received from JavaScript: $message');
          widget.homeController.receiveDataFromWeb(message);
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'versionHandler',
      callback: (args) {
        if (args.isNotEmpty) {
          String message = args.first.toString();
          debugPrint('+++++++++++++ integhra_webview - Version message received from JavaScript: $message');

          var data = jsonDecode(message);
          if (data['type'] == 'APP_VERSION_URL') {
            String versionName = data['data']['versionName'];
            debugPrint('+++++++++++++ integhra_webview - Received version name: $versionName');

            if (versionName != _currentVersion) {
              debugPrint('+++++++++++++ integhra_webview - Version has changed or is initial. Clearing cache and reloading.');
              _saveCurrentVersion(versionName);
              controller.clearCache();
              controller.reload();
            } else {
              debugPrint('+++++++++++++ integhra_webview - Version is the same. Not clearing cache.');
            }
          }
        }
      },
    );
  }
}
