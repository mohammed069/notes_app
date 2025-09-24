import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app_depi/models/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial()) {
    _subscribeToNotes();
  }

  static const String _collection = 'notes';
  final _firestore = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _sub;

  Future<void> addNote(NotesModel note) async {
    try {
      await _firestore.collection(_collection).doc(note.id).set(note.toMap());
    } catch (e) {
      emit(NotesError('Failed to add note: $e'));
    }
  }

  Future<void> updateNote(NotesModel note) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(note.id)
          .update(note.toMap());
    } catch (e) {
      emit(NotesError('Failed to update note: $e'));
    }
  }

  Future<void> deleteNote(NotesModel note) async {
    try {
      await _firestore.collection(_collection).doc(note.id).delete();
    } catch (e) {
      emit(NotesError('Failed to delete note: $e'));
    }
  }

  void _subscribeToNotes() {
    emit(NotesLoading());
    _sub?.cancel();
    _sub = _firestore
        .collection(_collection)
        .orderBy('date', descending: true)
        .snapshots()
        .listen(
          (snapshot) {
            final notes =
                snapshot.docs
                    .map((d) => NotesModel.fromMap(d.id, d.data()))
                    .toList();
            emit(NotesLoaded(notes));
          },
          onError: (e) {
            emit(NotesError('Failed to load notes: $e'));
          },
        );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
