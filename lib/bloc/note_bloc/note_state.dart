part of 'note_bloc.dart';

sealed class NoteState {}

final class NoteInitialState extends NoteState {
  final List<NoteModelHive> note;

  NoteInitialState(this.note);
}
