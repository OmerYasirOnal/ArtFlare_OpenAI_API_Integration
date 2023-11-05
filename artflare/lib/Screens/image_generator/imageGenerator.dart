import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_generator/Animation/FadeAnimation.dart';
import 'package:image_generator/AppBar/CustomAppBar.dart';
import 'package:image_generator/Constants/color.dart';
import 'package:image_generator/Screens/image_generator/Controllers/AdmobController.dart';
import 'package:image_generator/Screens/image_generator/components/prompt_input.dart';

import 'Controllers/ImageController.dart';

class ImageGenerator extends StatelessWidget {
  final controller = Get.put(ImageController());
  final admobController = Get.put(AdmobController());

  final TextEditingController textController = TextEditingController();

  ImageGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ArtFlare",
            style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            controller.toggleMenu();
          },
        ),
        backgroundColor: kDarkModeG1Color,
      ),
      body: Column(
        children: [
          Obx(() {
            return controller.isMenuOpen.value
                ? FadeAnimation(
                    0.0,
                    CustomMenuBar(
                      controller: controller,
                    ),
                  ) // Açık menü simgesi
                : const SizedBox();
          }),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.historyList.length,
                itemBuilder: (context, index) {
                  final entry = controller.historyList[index];
                  bool isLoading =
                      controller.isLoading.value; // Yükleme durumunu alın

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: const Color.fromARGB(80, 14, 1, 1),
                      child: Column(
                        children: [
                          entry['image'] == null || entry['image']!.isEmpty
                              ? Container(
                                  width: 256,
                                  height: 256,
                                  color: const Color.fromARGB(255, 86, 5, 5),
                                  child: const Center(
                                      child: Icon(Icons.image_not_supported)),
                                )
                              : Image.network(
                                  entry['image']!,
                                  width: 256,
                                  height: 256,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                (loadingProgress
                                                        .expectedTotalBytes ??
                                                    1)
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                        child: Text('Error loading image'));
                                  },
                                ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                            ),
                            child: Container(
                              color: const Color.fromARGB(214, 40, 40, 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Prompt:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          entry['prompt'] ?? 'No prompt',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: kDarkModebtnColor,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(18),
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.save,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            controller.saveImageToDevice();
                                          },
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: kDarkModebtnColor,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(18),
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.share,
                                            size: 30,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            if (entry['image'] != null &&
                                                entry['image']!.isNotEmpty) {
                                              controller
                                                  .shareImg(entry['image']!);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (isLoading) // Yükleme dairesini burada gösterin
                                    Container(
                                      color:
                                          const Color.fromARGB(255, 236, 21, 21)
                                              .withOpacity(0.6),
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Obx(() {
            return controller.isLoading.value
                ? const LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        kDarkModebtnColor), // İstediğiniz rengi ayarlayabilirsiniz
                  )
                : const SizedBox();
          }),
          Container(
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 40.0, right: 15, left: 15, top: 15),
                child: PromptInput(controller, textController,
                    admobController: admobController),
              )),
        ],
      ),
    );
  }
}
