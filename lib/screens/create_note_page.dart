import 'package:flutter/material.dart';
import 'package:notes_app/database/database_handler.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/theme/colors.dart';
import 'package:notes_app/utils/utility.dart';
import 'package:notes_app/widgets/button_widget.dart';
import 'package:notes_app/widgets/form_widget.dart';
import '../widgets/date_picker.dart';

class CreateNotePage extends StatefulWidget {
  const CreateNotePage({Key? key}) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  bool _isNoteCreating = false;
  int selectedColor = 4294967295;

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
      _isNoteCreating == true ? lightGreyColor : darkBackgroundColor,
      body: AbsorbPointer(
        absorbing: _isNoteCreating,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _isNoteCreating == true
                ? Image.asset(
              ImageConst.loadingGif,
              width: 50,
              height: 50,
            )
                : Container(),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        icon: Icons.arrow_back,
                        onTap: () => Navigator.pop(context),
                      ),
                      ButtonWidget(icon: Icons.done, onTap: _createNote),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      itemCount: predefinedColors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final singleColor = predefinedColors[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = singleColor.value;
                            });
                          },
                          child: Container(
                            width: 60,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            height: 60,
                            decoration: BoxDecoration(
                              color: singleColor,
                              border: Border.all(
                                width: 3,
                                color: selectedColor == singleColor.value
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDatePicker(
                    label: "Start Date",
                    date: _startDate,
                    onSelect: (selectedDate) {
                      setState(() {
                        _startDate = selectedDate;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildDatePicker(
                    label: "End Date",
                    date: _endDate,
                    onSelect: (selectedDate) {
                      setState(() {
                        _endDate = selectedDate;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  FormWidget(
                    fontSize: 40,
                    controller: _titleController,
                    hintText: StringConst.title,
                  ),
                  const SizedBox(height: 10),
                  FormWidget(
                    maxLines: 15,
                    fontSize: 20,
                    controller: _bodyController,
                    hintText: StringConst.typing,
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a date picker field
  Widget _buildDatePicker({
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
                  ? "${date.day}/${date.month}/${date.year}"
                  : "Select $label",
              style: const TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            const Icon(Icons.calendar_today, color: Colors.black),
          ],
        ),
      ),
    );
  }

  _createNote() async {
    if (_titleController.text.isEmpty) {
      toast(message: StringConst.enterTitle);
      return;
    }
    if (_bodyController.text.isEmpty) {
      toast(message: StringConst.typesomething);
      return;
    }
    if (_startDate == null || _endDate == null) {
      toast(message: "Please select both start and end dates.");
      return;
    }
    if (_endDate!.isBefore(_startDate!)) {
      toast(message: "End date cannot be earlier than start date.");
      return;
    }

    String formattedStartDate = formatDate(_startDate!);
    String formattedEndDate = formatDate(_endDate!);

    setState(() => _isNoteCreating = true);

    try {
      await DatabaseHandler().createNote(
        NoteModel(
          title: _titleController.text,
          body: _bodyController.text,
          color: selectedColor,
          startDate: formattedStartDate,
          endDate: formattedEndDate,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      toast(message: "Error creating note: $e");
    } finally {
      setState(() => _isNoteCreating = false);
    }
  }

}
