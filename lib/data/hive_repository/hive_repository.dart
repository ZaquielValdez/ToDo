import 'package:to_do/data/models/hive_note.dart';
import 'package:to_do/utils/box.dart';
import 'package:to_do/utils/diccionary.dart';

class NoteRepository {
  Future<List<NoteModelHive>> loadNotes() async {
    var notesWithKeys = <NoteModelHive>[];

    noteBox.toMap().forEach((key, note) {
      if (note is NoteModelHive) {
        note.noteKey = key;
        notesWithKeys.add(note);
      }
    });

    return notesWithKeys;
  }

  Future<void> addNoteHive(NoteModelHive note) async {
    note.noteKey = globalNoteKey;
    await noteBox.add(note);
    globalNoteKey++;
  }

  Future<void> updateNoteHive(NoteModelHive note) async {
    await noteBox.put(note.noteKey, note);
  }

  Future<void> deleteNoteHive(NoteModelHive note) async {
    await noteBox.delete(note.noteKey);
  }
}
