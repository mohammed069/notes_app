import 'package:bloc/bloc.dart';
import 'package:note_app_depi/models/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  final List<NotesModel> notes = [];

  void addNote(NotesModel note) {
    emit(NotesInitial());
    notes.add(note);
    emit(NotesLoaded(notes));
  }

  void deleteNote(NotesModel note) {
    emit(NotesInitial());
    notes.remove(note);
    emit(NotesLoaded(notes));
  }
}
