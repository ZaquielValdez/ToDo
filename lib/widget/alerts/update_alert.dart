import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:to_do/bloc/note_bloc/note_bloc.dart';
import 'package:to_do/data/models/hive_note.dart';

Future<dynamic> updateAlert(
    BuildContext context, Size size, NoteModelHive note) {
  final nameControl = TextEditingController(text: note.name);
  final contentControl = TextEditingController(text: note.content);
  final dateControl = TextEditingController(text: note.dateTime);

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 24, 37, 17),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Center(
          child: Row(
            children: [
              const Text(
                'Update Note',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white54,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  size: 30,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: nameControl,
                style: const TextStyle(fontSize: 19, color: Colors.white54),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.white54,
                  ),
                  hintText: 'Name',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: contentControl,
                maxLines: 5,
                style: const TextStyle(fontSize: 19, color: Colors.white54),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.edit_document,
                    size: 20,
                    color: Colors.white54,
                  ),
                  hintText: 'Content',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: size.width,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: dateControl,
                style: const TextStyle(fontSize: 19, color: Colors.white54),
                onTap: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));

                  if (date != null) {
                    dateControl.text = DateFormat("yyyy/MM/dd").format(date);
                  }
                },
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.date_range,
                    size: 20,
                    color: Colors.white54,
                  ),
                  hintText: 'Select Date',
                  hintStyle: TextStyle(
                    fontSize: 17,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 103, 173, 104),
                  ),
                  onPressed: () {
                    final name = nameControl.text.trim();
                    final content = contentControl.text.trim();
                    final date = dateControl.text.trim();

                    if (name.isEmpty || content.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color.fromARGB(255, 48, 48, 48),
                          content: Text(
                            'Todos los campos son requeridos',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    } else if (name.length <= 4 || content.length <= 5) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color.fromARGB(255, 48, 48, 48),
                          content: Text(
                            'Recuerda que el nombre debe contar con 4 caracteres y el contenido con 10 o mas',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    } else {
                      note.name = name;
                      note.content = content;
                      note.dateTime = date;

                      context.read<NoteBloc>().add(UpDateNoteEvent(note));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text(
                    'Guardar',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 161, 93, 93),
                  ),
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
