import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc/data/models/hive_note.dart';

part 'actual_note_state.dart';

class ActualNoteCubit extends Cubit<ActualNoteInitialState> {
  ActualNoteCubit() : super(ActualNoteInitialState(NoteModelHive()));

  setNote(NoteModelHive note) {
    emit(ActualNoteInitialState(note));
  }
}
