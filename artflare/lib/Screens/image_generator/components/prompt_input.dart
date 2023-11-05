import 'package:flutter/material.dart';
import 'package:image_generator/Constants/color.dart';
import '../Controllers/AdmobController.dart';
import '../Controllers/ImageController.dart';

class PromptInput extends StatelessWidget {
  final ImageController controller;
  final TextEditingController textController;
  final AdmobController admobController;

  const PromptInput(this.controller, this.textController,
      {super.key, required this.admobController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kDarkModeG1Color,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: "Enter Text to Generate AI Image",
                filled: true,
                fillColor: kDarkModeG2Color,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: kDarkModebtnColor,
            onPressed: () {
              //admobController.onInit();
              admobController.showInterstitialAd();
              controller.fetchImage(textController.text);
            },
          ),
        ],
      ),
    );
  }
}
