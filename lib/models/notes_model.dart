import 'package:cloud_firestore/cloud_firestore.dart';

class NotesModel {
  String id;
  String title;
  String description;
  DateTime date;

  NotesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'description': description, 'date': date};
  }

  factory NotesModel.fromMap(String id, Map<String, dynamic> data) {
    final dynamic rawDate = data['date'];
    DateTime parsedDate;
    if (rawDate is Timestamp) {
      parsedDate = rawDate.toDate();
    } else if (rawDate is DateTime) {
      parsedDate = rawDate;
    } else if (rawDate is String) {
      parsedDate = DateTime.tryParse(rawDate) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return NotesModel(
      id: id,
      title: (data['title'] ?? '').toString(),
      description: (data['description'] ?? '').toString(),
      date: parsedDate,
    );
  }
}
