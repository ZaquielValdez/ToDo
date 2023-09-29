// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_bloc/utils/key.dart';

part 'hive_note.g.dart';

@HiveType(typeId: 0)
class NoteModelHive extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String content;

  @HiveField(2)
  String dateTime;

  @HiveField(3)
  int noteKey;

  @HiveField(4)
  String status;

  NoteModelHive({
    this.name = '',
    this.content = '',
    this.dateTime = '',
    this.noteKey = 0,
    this.status = StatusNote.pending,
  });

  NoteModelHive copyWith({
    String? name,
    String? content,
    String? dateTime,
    int? noteKey,
    String? status,
  }) {
    return NoteModelHive(
      name: name ?? this.name,
      content: content ?? this.content,
      dateTime: dateTime ?? this.dateTime,
      noteKey: noteKey ?? this.noteKey,
      status: status ?? this.status,
    );
  }
}
