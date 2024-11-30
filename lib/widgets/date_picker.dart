import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

String formatDate(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date); // Format to dd/MM/yyyy
}

Widget _buildDatePicker({
  required BuildContext context,
  required String label,
  required DateTime? date,
  required Function(DateTime) onSelect,
}) {
  return GestureDetector(
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: date ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (pickedDate != null) {
        onSelect(pickedDate);
      }
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date != null
                ? formatDate(date) // Display the formatted date
                : "Select $label",
            style: const TextStyle(fontSize: 18.0, color: Colors.black),
          ),
          const Icon(Icons.calendar_today, color: Colors.black),
        ],
      ),
    ),
  );
}
