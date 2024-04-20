import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import '../../utils/custom_snackbar.dart';

class AdminProductsController extends GetxController {
  TextEditingController productIdController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final ImagePicker imagePicker = ImagePicker();
  XFile? pickedFile;
  late String imageUrl;
  RxString selectedCategory = 'accessories'.obs;

  Stream<QuerySnapshot> getCategories() async* {
    yield* FirebaseFirestore.instance.collection('categories').snapshots();
  }

  Future<void> addProduct() async {
    if (checkData()) {
      try {
        imageUrl = await uploadImage(path: pickedFile!.path);
      } catch (e) {
        CustomSnackBar.showCustomSnackBar(
          title: 'حدث خطأ',
          message: 'لم يتم رفع الصورة يرجى اعادة المحاولة',
        );
        return;
      }
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productNameController.text)
          .set(
        {
          'product_id': productNameController.text,
          'product_name': productNameController.text,
          'product_description': productDescriptionController.text,
          'product_price': productPriceController.text,
          'product_image': imageUrl,
          'category_name': selectedCategory.value,
        },
      );
      clearTextFields();
      CustomSnackBar.showCustomSnackBar(
        title: 'تمت الاضافة',
        message: 'تم اضافة المنتج الخاص بك بنجاح ',
      );
    }
  }

  bool checkData() {
    if (productNameController.text.isNotEmpty &&
        productDescriptionController.text.isNotEmpty &&
        productPriceController.text.isNotEmpty &&
        pickedFile != null) {
      return true;
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
        title: "لا يمكن تركه فارغاً",
        message: 'الرجاء ادخال البيانات المطلوبة',
      );
      return false;
    }
  }

  Future<String> uploadImage({required String path}) async {
    UploadTask uploadTask = _firebaseStorage
        .ref('product_images/${DateTime.now()}_image')
        .putFile(File(path));
    await uploadTask;
    return await uploadTask.snapshot.ref.getDownloadURL();
  }

  void clearTextFields() {
    productNameController.text = '';
    productDescriptionController.text = '';
    productPriceController.text = '';
    imageController.text = '';
  }

  void selectPicture() {
    Dialogs.materialDialog(
      context: Get.context!,
      title: 'اختر صورة',
      msg: 'حدد من اين تفضل اختيار الصورة',
      titleStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      msgStyle: const TextStyle(
        fontSize: 17,
      ),
      actions: [
        IconsOutlineButton(
          onPressed: () async => await pickImageCamera(),
          text: 'الكاميرا',
          iconData: CupertinoIcons.camera_fill,
          textStyle: const TextStyle(color: Colors.white),
          // color: AppColors.customRed,
          iconColor: Colors.white,
        ),
        IconsButton(
          onPressed: () async => await pickImageGallery(),
          text: 'الاستديو',
          iconData: CupertinoIcons.photo_on_rectangle,
          // color: AppColors.customRed,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  Future<void> pickImageGallery() async {
    XFile? imageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (imageFile != null) {
      pickedFile = imageFile;
      imageController.text = pickedFile!.name;
      Get.back();
    }
  }

  Future<void> pickImageCamera() async {
    XFile? imageFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (imageFile != null) {
      pickedFile = imageFile;
      imageController.text = pickedFile!.name;
      Get.back();
    }
  }

  @override
  void onInit() {
    getCategories();
    super.onInit();
  }

  final categoryItems = [
    const DropdownMenuItem<String>(
      value: 'pants',
      child: Text('اكسسوارات'),
    ),
    const DropdownMenuItem<String>(
      value: 't_shirts',
      child: Text('خشبيات'),
    ),
    const DropdownMenuItem<String>(
      value: 'shoess',
      child: Text('المطرزات'),
    ),
    const DropdownMenuItem<String>(
      value: 'accessories',
      child: Text('الخزف'),
    ),
    const DropdownMenuItem<String>(
      value: 'wreaths',
      child: Text('الأكاليل'),
    ),
  ];
}
