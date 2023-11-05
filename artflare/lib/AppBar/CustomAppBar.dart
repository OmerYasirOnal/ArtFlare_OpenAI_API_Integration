import 'package:flutter/material.dart';
import 'package:image_generator/Constants/color.dart';
import 'package:image_generator/Screens/image_generator/Controllers/ImageController.dart';

class CustomMenuBar extends StatelessWidget implements PreferredSizeWidget {
  final ImageController controller;

  CustomMenuBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black, // Arka plan rengi siyah
          borderRadius:
              BorderRadius.circular(20.0), // Menü çubuğu kenarları oval yapar
          boxShadow: [
            BoxShadow(
              color: kDarkModeG2Color, // Gölge rengi
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2), // Gölge konumu
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomMenuButton(
                icon: Icons.folder,
                text: "Biz Kimiz?",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomMenuButton(
                icon: Icons.comment,
                text: "İletişim",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomMenuButton extends StatelessWidget {
  final IconData icon;
  final String text;

  CustomMenuButton({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: kDarkModeG1Color, // Buton rengi amber
            borderRadius: BorderRadius.circular(20.0), // Kenarları oval yapar
          ),
          child: IconButton(
            icon: Icon(
              icon,
              size: 25,
            ),
            onPressed: () {
              // Buton işlevini buraya ekleyin
            },
            color: Colors.black, // Buton ikon rengi siyah
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
