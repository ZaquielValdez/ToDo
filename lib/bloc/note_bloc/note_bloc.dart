import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc/data/models/hive_note.dart';
import 'package:to_do_bloc/data/hive_repository/hive_repository.dart';
part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _repository = NoteRepository();
  NoteBloc() : super(NoteInitialState([])) {
    on<NoteEvent>((event, emit) async {
      if (event is InicialNotesEvent) {
        final initData = await _repository.loadNotes();

        emit(NoteInitialState(initData));
      }
      if (event is AddNewNoteEvent) {
        await _repository.addNoteHive(event.note);
      } else if (event is UpDateNoteEvent) {
        final updateNote = NoteModelHive().copyWith(
          name: event.note.name,
          content: event.note.content,
          noteKey: event.note.noteKey,
          dateTime: event.note.dateTime,
          status: event.note.status,
        );
        await _repository.updateNoteHive(updateNote);
      } else if (event is DeleteNoteEvent) {
        await _repository.deleteNoteHive(event.note);
      }
      final note = await _repository.loadNotes();
      emit(NoteInitialState(note));
    });
  }
}
