// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelHiveAdapter extends TypeAdapter<NoteModelHive> {
  @override
  final int typeId = 0;

  @override
  NoteModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModelHive(
      name: fields[0] as String,
      content: fields[1] as String,
      dateTime: fields[2] as String,
      noteKey: fields[3] as int,
      status: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModelHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.noteKey)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
