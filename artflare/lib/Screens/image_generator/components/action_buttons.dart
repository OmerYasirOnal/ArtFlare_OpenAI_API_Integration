import 'package:flutter/material.dart';

import '../Controllers/ImageController.dart';

class ActionButtonRow extends StatelessWidget {
  final ImageController controller;
  final TextEditingController textController;

  const ActionButtonRow(this.controller, this.textController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // "Retry" ve "Save" butonlarınızın kodu burada:
        ElevatedButton.icon(
          onPressed: () {
            controller.fetchImage(textController.text); // Retry işlevi için
          },
          icon: const Icon(Icons.refresh, size: 18), // Icon boyutunu küçülttük
          label: const Text("Retry",
              style: TextStyle(fontSize: 14)), // Metin boyutunu küçülttük
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8), // padding'i düzenleyerek buton boyutunu küçülttük
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton.icon(
          onPressed: () {
            controller.saveImageToDevice();
            print("Save clicked!");
          },
          icon:
              const Icon(Icons.download_rounded, size: 18), // Icon boyutunu küçülttük
          label: const Text("Save",
              style: TextStyle(fontSize: 14)), // Metin boyutunu küçülttük
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8), // padding'i düzenleyerek buton boyutunu küçülttük
          ),
        ),
      ],
    );
  }
}
