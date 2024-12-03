import 'package:flutter/material.dart';

class SingleNoteWidget extends StatefulWidget {
  final String? title;
  final String? body;
  final int? color;
  final String? startDate;
  final String? endDate;
  final VoidCallback? onTap;
  final VoidCallback? onPress;

  const SingleNoteWidget(
      {Key? key,
      this.title,
      this.body,
      this.color,
      this.onTap,
      this.onPress,
      this.startDate,
      this.endDate})
      : super(key: key);

  @override
  State<SingleNoteWidget> createState() => _SingleNoteWidgetState();
}

class _SingleNoteWidgetState extends State<SingleNoteWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onPress,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(widget.color!),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.body!,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.startDate!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.endDate!,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                color: Colors.red,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: widget.onPress,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
