import 'package:flutter/material.dart';
import '../Controllers/ImageController.dart';

class PromptList extends StatelessWidget {
  final TextEditingController textController;
  final ImageController controller;

  const PromptList(this.textController, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.builder(
            itemCount: prompts.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.amber,
                child: ListTile(
                  title: Text(prompts[index]),
                  onTap: () {
                    textController.text = prompts[index];
                    controller.setSelectedPrompt(prompts[index]);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

List<String> prompts = [
  "A sunset over the mountains",
  "A futuristic city skyline",
  "An old man sitting on a park bench",
];
