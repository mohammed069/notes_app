part of 'notes_cubit.dart';

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<NotesModel> notes;

  NotesLoaded(this.notes);
}

class NotesError extends NotesState {
  final String error;

  NotesError(this.error);
}
