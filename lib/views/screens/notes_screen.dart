import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_depi/controllers/cubit/notes_cubit.dart';
import 'package:note_app_depi/models/notes_model.dart';
import 'add_note_screen.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoaded) {
            if (state.notes.isEmpty) {
              return const Center(child: Text('No notes yet. add a note'));
            }
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final NotesModel note = state.notes[index];
                return Card(
                  color: Colors.blue.shade100,
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<NotesCubit>().deleteNote(note);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('NO notes yet. add a note'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade100,
        foregroundColor: Colors.black,

        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddNoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
