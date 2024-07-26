import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importa GetX
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
  String _currentVersionName = '';
  int _currentVersionCode = 0;
  bool _clearCacheOnNextLoad = false; // Inicializar con valor por defecto

  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _initializeState() async {
    await _loadCurrentVersion();
    await _loadClearCacheStatus();
    if (_clearCacheOnNextLoad) {
      await _clearCache();
    }
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
      canPop: true,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
      },
      child: SafeArea(
        child: Obx(() { // Usa Obx aquí para observar el valor isLoading de homeController
          if (widget.homeController.isLoading.value) {
            debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! body IS LOADING...");
            return const Center(child: CircularProgressIndicator());
          } else {
            debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! body LOADED !!! - URL ${globals.uri}");
            // Limpieza de caché si es necesario antes de mostrar InAppWebView
            _clearCacheIfNeeded();

            return AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 100), // Duración reducida a 100ms
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(globals.uri)),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                    javaScriptEnabled: true,
                    transparentBackground: true,
                    cacheEnabled: true, // Habilitar el uso de cache
                  ),
                ),
                shouldOverrideUrlLoading: shouldOverrideUrlLoading,
                onLoadStart: (controller, url) {},
                onLoadStop: (controller, url) {},
                onProgressChanged: (controller, progress) {
                  // Actualizar la barra de carga.
                },
                onWebViewCreated: (controller) {
                  _webViewController = controller;
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
      _currentVersionName = prefs.getString('flutterVersionName') ?? '';
      _currentVersionCode = prefs.getInt('flutterVersionCode') ?? 0;
    });
  }

  Future<void> _saveCurrentVersion(String versionName, int versionCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('flutterVersionName', versionName);
    await prefs.setInt('flutterVersionCode', versionCode);
    setState(() {
      _currentVersionName = versionName;
      _currentVersionCode = versionCode;
    });
  }

  Future<void> _loadClearCacheStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _clearCacheOnNextLoad = prefs.getBool('clearCacheOnNextLoad') ?? false;
    });
  }

  Future<void> _setClearCacheStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('clearCacheOnNextLoad', status);
    setState(() {
      _clearCacheOnNextLoad = status;
    });
  }

  Future<void> _clearCacheIfNeeded() async {
    if (_clearCacheOnNextLoad && _webViewController != null) {
      await _clearCache();
      await _setClearCacheStatus(false);
      debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! Clearing CACHE !!!");
    } else {
      debugPrint("+++++++++++++ integhra_webview !!!!!!!!!! NO NEED to Clear CACHE !!!");
    }
  }

  Future<void> _clearCache() async {
    if (_webViewController != null) {
      await _webViewController!.clearCache();
    }
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
        } else {
          debugPrint('+++++++++++++ integhra_webview - messageHandler - No arguments received !!!!!!!!!!');
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
            int versionCode = data['data']['versionCode'];

            debugPrint('Received version name: $versionName and version code: $versionCode');

            if (versionName != _currentVersionName || versionCode != _currentVersionCode) {
              debugPrint('+++++++++++++ integhra_webview - Version has changed or is initial. Setting clearCache flag.');
              _saveCurrentVersion(versionName, versionCode);
              _setClearCacheStatus(true);
              _webViewController!.reload();
            } else {
              debugPrint('+++++++++++++ integhra_webview - Version is the same. Not clearing cache.');
            }
          }
        } else {
          debugPrint('+++++++++++++ integhra_webview - versionHandler - No arguments received.');
        }
      },
    );
  }
}
