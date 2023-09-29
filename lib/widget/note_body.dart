// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_bloc/bloc/note_bloc/note_bloc.dart';
import 'package:to_do_bloc/data/models/hive_note.dart';
import 'package:to_do_bloc/utils/key.dart';
import 'package:to_do_bloc/widget/alerts/update_alert.dart';

class NoteBody extends StatefulWidget {
  const NoteBody({
    Key? key,
    required this.size,
    required this.delete,
    required this.name,
    required this.content,
    required this.date,
    required this.note,
  }) : super(key: key);

  final Size size;
  final VoidCallback delete;
  final String name;
  final String content;
  final String date;
  final NoteModelHive note;

  @override
  State<NoteBody> createState() => _NoteBodyState();
}

class _NoteBodyState extends State<NoteBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.17,
      width: widget.size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 44, 53, 39),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.note.status = StatusNote.pending;
                            setState(() {});
                            context.read<NoteBloc>().add(UpDateNoteEvent(widget
                                .note
                                .copyWith(status: widget.note.status)));
                          },
                          iconSize: 28,
                          icon: Icon(
                            Icons.circle,
                            color: widget.note.status == StatusNote.pending
                                ? Colors.yellow
                                : Colors.grey.withOpacity(0.3),
                            size: 10,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            widget.note.status = StatusNote.inProgress;
                            setState(() {});
                            context.read<NoteBloc>().add(UpDateNoteEvent(widget
                                .note
                                .copyWith(status: widget.note.status)));
                          },
                          iconSize: 28,
                          icon: Icon(
                            Icons.circle,
                            color: widget.note.status == StatusNote.inProgress
                                ? Colors.blue
                                : Colors.grey.withOpacity(0.3),
                            size: 10,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            widget.note.status = StatusNote.done;
                            setState(() {});
                            context.read<NoteBloc>().add(UpDateNoteEvent(widget
                                .note
                                .copyWith(status: widget.note.status)));
                          },
                          iconSize: 28,
                          icon: Icon(
                            Icons.circle,
                            color: widget.note.status == StatusNote.done
                                ? Colors.green
                                : Colors.grey.withOpacity(0.3),
                            size: 10,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.note.status,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                onPressed: widget.delete,
                icon: const Icon(
                  Icons.delete,
                  size: 25,
                  color: Colors.white54,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateAlert(
                    context,
                    widget.size,
                    widget.note,
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.white54,
                ),
              ),
              const Spacer(),
              Text(
                widget.date,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}
