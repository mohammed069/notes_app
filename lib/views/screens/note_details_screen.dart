import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app_depi/models/notes_model.dart';
import 'add_note_screen.dart';

class NoteDetailsScreen extends StatelessWidget {
  final NotesModel note;
  const NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final created = DateFormat('MM/dd/yyyy HH:mm').format(note.date);
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade50,
        title: const Text('Note Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => AddNoteScreen(note: note)),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              note.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            Text(
              'Created At: $created',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
