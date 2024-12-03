
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:notes_app/database/database_handler.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/create_note_page.dart';
import 'package:notes_app/screens/edit_note_page.dart';
import 'package:notes_app/theme/colors.dart';
import 'package:notes_app/utils/utility.dart';
import 'package:notes_app/widgets/dialog_box_widget.dart';
import 'package:notes_app/widgets/single_note_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  void initState() {
    super.initState();
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
        if (_connectivityResult == ConnectivityResult.none) {
          _showNoInternetSnackBar();
        }
      });
    });
  }

  Future<void> _checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
  }

  void _showNoInternetSnackBar() {
    toast(message: StringConst.noConnection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkBackgroundColor,
        centerTitle: true,
        title: const Text(
         StringConst.taskManagement,
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(onPressed: () =>   DatabaseHandler().signOut(), icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 160,
        height: 60,
        margin: const EdgeInsets.all(20),
        child: FloatingActionButton(
          backgroundColor: Colors.black54,
          onPressed:  () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateNotePage()),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.note_alt,
                size: 30,
                color: Colors.white,
              ),
              SizedBox(width: 6,),
              Text(
                StringConst.addTask,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<List<NoteModel>>(
        stream: DatabaseHandler().getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset(
                ImageConst.loadingGif,
                width: 50,
                height: 50,
              ),
            );
          }

          if (snapshot.hasData == false) {
            return _noNotesWidget();
          }

          if (snapshot.data!.isEmpty) {
            return _noNotesWidget();
          }

          final notes = snapshot.data;

          return ListView.builder(
            itemCount: notes!.length,
            itemBuilder: (context, index) {
              return SingleNoteWidget(
                title: notes[index].title,
                body: notes[index].body,
                color: notes[index].color,
                startDate: notes[index].startDate,
                endDate: notes[index].endDate,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditNotePage(noteModel: notes[index]),
                    ),
                  );
                },
                onPress: () {
                  showDialogBoxWidget(
                    context,
                    height: 250,
                    title: StringConst.areYouSureDelete,
                    onTapYes: () {
                      DatabaseHandler().deleteNote(notes[index].id!);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _noNotesWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(ImageConst.logo),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
           StringConst.createColourNotes,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
