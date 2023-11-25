// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/cubit_actual_note/actual_note_cubit.dart';

class NoteDetails extends StatelessWidget {
  const NoteDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActualNoteCubit>().state;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 30, 22),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 50),
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.grey.withOpacity(0.4),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.grey,
              size: 50,
            ),
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 80, vertical: 30),
            title: Text(
              "Name:  ${cubit.note.name}",
              style: const TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 30),
                Text(
                  "Status:  ${cubit.note.status}",
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "Content:  ${cubit.note.content}",
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  "DateTime:  ${cubit.note.dateTime}",
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.withOpacity(0.4),
            ),
            onPressed: () {
              context.pop();
            },
            child: const Text(
              "Back",
              style: TextStyle(
                fontSize: 19,
                color: Colors.white60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
