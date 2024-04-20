import 'package:get/get.dart';

import '../controllers/admin_products.controller.dart';

class AdminProductsBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AdminProductsController>(
      AdminProductsController(),
      permanent: true,
    );
  }
}
