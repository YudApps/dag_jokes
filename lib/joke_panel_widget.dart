import 'package:elephant_jokes/joke_widget.dart';
import 'package:flutter/material.dart';

class JokePanelWidget extends StatelessWidget {
  final String text;
  final Icon icon;
  final String imagePath;
  final JokePanelStyle style;

  const JokePanelWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.imagePath,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Define the sizes based on available space
      // double textHeight =
      //     constraints.maxHeight * 0.2; // 20% of the height for text
      double imageHeight =
          constraints.maxHeight * 0.8; // 80% of the height for image

      return Container(
        decoration: BoxDecoration(color: style.backgroundColor),
        constraints: const BoxConstraints(maxWidth: 1024),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24.0, color: style.textColor),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(width: 20),
                    icon,
                  ]
                ),
                const SizedBox(height: 20), // Add spacing between the text and the image
                SizedBox(height: imageHeight, child: Image.asset(imagePath)),
              ],
            ),
          ],
        )
      );
    });
  }
}
