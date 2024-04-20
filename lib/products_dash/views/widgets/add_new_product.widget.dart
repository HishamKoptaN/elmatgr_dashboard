import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/colors.dart';
import '../../controllers/admin_products.controller.dart';
import 'admin_text_field.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({
    super.key,
    required this.controller,
  });
  final AdminProductsController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Spacer(),
          AdminTextField(
            controller: controller.productIdController,
            labelText: 'معرف المنتج',
            hint: 'معرف المنتج مثال 1/2/3',
          ),
          const Spacer(),
          AdminTextField(
            controller: controller.imageController,
            onTap: () => controller.selectPicture(),
            suffixIcon: Icons.cloud_upload,
            labelText: 'اضافة صورة للمنتج',
            hint: 'ارفق صورة',
          ),
          const Spacer(),
          AdminTextField(
            controller: controller.productNameController,
            labelText: 'اسم المنتج',
            hint: 'خزف ملون',
          ),
          const Spacer(),
          AdminTextField(
            controller: controller.productDescriptionController,
            maxLines: 5,
            labelText: 'وصف المنتج',
            hint: 'مثال: منتج تمت صناعته بأفضل الخامات ...',
          ),
          const Spacer(),
          AdminTextField(
            controller: controller.productPriceController,
            labelText: 'السعر',
            hint: '120 ر.س',
          ),
          const Spacer(),
          AdminTextField(
            controller: controller.imageController,
            onTap: () => controller.selectPicture(),
            suffixIcon: Icons.cloud_upload,
            labelText: 'اضافة صورة للمنتج',
            hint: 'ارفق صورة',
          ),
          const Spacer(),
          Obx(
            () {
              return DropdownButton<String>(
                isExpanded: true,
                items: controller.categoryItems,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                value: controller.selectedCategory.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedCategory.value = value;
                  }
                },
              );
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => controller.addProduct(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.customRed,
            ),
            child: const Text('اضافة', style: TextStyle(fontSize: 35)),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
