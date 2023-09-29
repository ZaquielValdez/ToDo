import 'package:to_do_bloc/data/models/hive_note.dart';
import 'package:to_do_bloc/utils/box.dart';
import 'package:to_do_bloc/utils/diccionary.dart';

class NoteRepository {
  Future<List<NoteModelHive>> loadNotes() async {
    return noteBox.values.toList().cast<NoteModelHive>();
  }

  Future<void> addNoteHive(NoteModelHive note) async {
    note.noteKey = globalNoteKey;
    await noteBox.add(note);
    globalNoteKey++;
  }

  Future<void> updateNoteHive(NoteModelHive note) async {
    await noteBox.put(note.noteKey, note);

    await saveNotesToHive();
  }

  Future<void> deleteNoteHive(NoteModelHive note) async {
    await noteBox.delete(note.noteKey);
  }

  Future<void> saveNotesToHive() async {
    final notes = noteBox.values.toList().cast<NoteModelHive>();
    await noteBox.clear();

    final sortedNotes = notes
        .map((note) => note.copyWith(noteKey: notes.indexOf(note)))
        .toList();

    for (final note in sortedNotes) {
      await noteBox.add(note);
    }
  }
}
