import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:integhra_webview_module/app/ui/pages/home_page/widgets/body.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      body: Body(homeController: homeController),
    );
  }
}


