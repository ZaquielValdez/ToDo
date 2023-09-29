part of 'note_bloc.dart';

sealed class NoteEvent {}

final class InicialNotesEvent extends NoteEvent {}

final class AddNewNoteEvent extends NoteEvent {
  final NoteModelHive note;

  AddNewNoteEvent(this.note);
}

final class DeleteNoteEvent extends NoteEvent {
  final NoteModelHive note;

  DeleteNoteEvent(this.note);
}

class NoteLoadedEvent extends NoteEvent {
  final List<NoteModelHive> notes;

  NoteLoadedEvent(this.notes);
}

class UpDateNoteEvent extends NoteEvent {
  final NoteModelHive note;

  UpDateNoteEvent(this.note);
}
