import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do/data/models/hive_note.dart';
import 'package:to_do/data/hive_repository/hive_repository.dart';
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
        await _repository.updateNoteHive(event.note);
      } else if (event is DeleteNoteEvent) {
        await _repository.deleteNoteHive(event.note);
      }

      final data = await _repository.loadNotes();
      emit(NoteInitialState(data));
    });
  }
}
