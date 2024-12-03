
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String? title;
  final String? body;
  final String? startDate;
  final String? endDate;
  final int? color;

  NoteModel({this.id, this.title, this.body, this.color,this.startDate, this.endDate,});

  factory NoteModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return NoteModel(
      title: snapshot['title'],
      body: snapshot['body'],
      color: snapshot['color'],
      id: snapshot['id'],
      endDate: snapshot['startDate'],
      startDate: snapshot['endDate'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "title": title,
    "id": id,
    "body": body,
    "color": color,
    "startDate":startDate,
    "endDate":endDate,
  };
}