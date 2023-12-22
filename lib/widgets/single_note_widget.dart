import 'package:flutter/material.dart';

class SingleNoteWidget extends StatelessWidget {
  final String? title;
  final String? body;
  final int? color;
  final VoidCallback? onTap;
  final VoidCallback? onPress;

  const SingleNoteWidget({Key? key, this.title, this.body, this.color, this.onTap, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onPress,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 15, top: 15,bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(color!),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                ),
                const SizedBox(height: 5,),
                Text(body!, style: const TextStyle(color: Colors.black, fontSize: 16),)
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                color: Colors.red,
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: onPress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
