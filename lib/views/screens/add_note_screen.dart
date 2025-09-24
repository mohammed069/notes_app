import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_depi/controllers/cubit/notes_cubit.dart';
import 'package:note_app_depi/models/notes_model.dart';
import 'package:note_app_depi/views/widgets/my_text_form_field.dart';
import 'package:uuid/uuid.dart';

class AddNoteScreen extends StatefulWidget {
  final NotesModel? note;
  const AddNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final note = widget.note;
    if (note != null) {
      _titleController.text = note.title;
      _descController.text = note.description;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      if (widget.note == null) {
        final note = NotesModel(
          id: const Uuid().v4(),
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          date: DateTime.now(),
        );
        context.read<NotesCubit>().addNote(note);
      } else {
        final updated = NotesModel(
          id: widget.note!.id,
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          date: widget.note!.date,
        );
        context.read<NotesCubit>().updateNote(updated);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
        ),
        title: Text(
          widget.note == null ? 'Add Note' : 'Edit Note',
          style: const TextStyle(color: Colors.blue),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyTextFormField(
                controller: _titleController,
                labelText: 'Title',
                validator:
                    (value) =>
                        value == null || value.isEmpty ? 'Enter a title' : null,
              ),
              const SizedBox(height: 16),
              MyTextFormField(
                controller: _descController,
                labelText: 'Description',
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter a description'
                            : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveNote,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Colors.blue.shade100,
                  ),
                ),
                child: Text(
                  widget.note == null ? 'Save' : 'Update',
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
