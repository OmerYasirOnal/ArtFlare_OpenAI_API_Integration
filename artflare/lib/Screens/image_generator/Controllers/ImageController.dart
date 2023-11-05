import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_generator/openAI_API/ImageAPI.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ImageController extends GetxController {
  final ImageAPI api = ImageAPI();
  var image = ''.obs;
  var isLoading = false.obs;
  var selectedPrompt = ''.obs;
  var historyList = <Map<String, String>>[].obs;
  var isMenuOpen = false.obs;

  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
  }

  Future<void> fetchImage(String prompt) async {
    isLoading.value = true;
    String? newImage = await api.generateAIImage(prompt);
    await Future.delayed(Duration(seconds: 2));

    if (newImage != null) {
      image.value = newImage;
      historyList.add({'image': newImage, 'prompt': prompt});
    } else {
      Get.snackbar("Error", "Image generation failed!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
    isLoading.value = false;
  }

  void setSelectedPrompt(String value) {
    selectedPrompt.value = value;
  }

  Future<void> saveImageToDevice() async {
    final response = await http.get(Uri.parse(image.value));
    final uint8ListImage = response.bodyBytes;

    final result = await ImageGallerySaver.saveImage(uint8ListImage,
        quality: 90, name: "ai_generated_image");
    if (result['isSuccess']) {
      Get.snackbar("Success", "Image saved successfully!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } else {
      Get.snackbar("Error", "Image saving failed!",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void shareImg(String imagePath) async {
    final url = Uri.parse(imagePath);
    final response = await http.get(url);
    final bytes = response.bodyBytes;

    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);

    await Share.shareFiles([path]);
  }

  void shareImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      final List<int> bytes = response.bodyBytes;
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/shared_image.png');
      await file.writeAsBytes(bytes);

      await Share.shareFiles([file.path],
          text: 'Check out this AI-generated image!');
    } catch (e) {
      print('Error sharing image: $e');
      // Hata mesajı gösterme veya başka bir işlem yapma
    }
  }
}
