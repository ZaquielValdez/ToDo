import 'dart:developer' as dev;

import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do/bloc/note_bloc/note_bloc.dart';
import 'package:to_do/cubit_actual_note/actual_note_cubit.dart';
import 'package:to_do/widget/alerts/alert_dialog.dart';
import 'package:to_do/widget/note_body.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String filterNote = "";
  AdmobBannerSize? bannerSize;
  AdmobInterstitial? interstitialAd;

  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(InicialNotesEvent());

    bannerSize = AdmobBannerSize.BANNER;
    interstitialAd = AdmobInterstitial(
      adUnitId: 'ca-app-pub-7756393639674422/6005283955',
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd!.load();
      },
    );

    interstitialAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 30, 22),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 30, 22),
        centerTitle: true,
        title: const Text(
          'ToDo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Column(
              children: [
                const SizedBox(height: 20),
                searchTextField(size),
                const SizedBox(height: 10),
                BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    if (state is NoteInitialState) {
                      final noteFilter = state.note.where((note) {
                        final name = note.name.toString().toLowerCase();
                        final content = note.content.toString().toLowerCase();
                        final status = note.status.toString().toLowerCase();
                        final date = note.dateTime.toString().toLowerCase();
                        return name.contains(filterNote.toLowerCase()) ||
                            content.contains(filterNote.toLowerCase()) ||
                            status.contains(filterNote.toLowerCase()) ||
                            date.contains(filterNote.toLowerCase());
                      }).toList();
                      return Expanded(
                        child: ListView.builder(
                          itemCount: noteFilter.length,
                          itemBuilder: (context, index) {
                            final note = noteFilter[index];
                            return GestureDetector(
                              onTap: () {
                                context.pushNamed('/note-details');
                                context.read<ActualNoteCubit>().setNote(note);
                              },
                              child: NoteBody(
                                size: size,
                                delete: () {
                                  context
                                      .read<NoteBloc>()
                                      .add(DeleteNoteEvent(note));
                                },
                                note: noteFilter[index],
                                content: note.content,
                                name: note.name,
                                date: note.dateTime,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                const SizedBox(height: 150),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AdmobBanner(
            adUnitId: 'ca-app-pub-7756393639674422/9481215295',
            adSize: bannerSize ?? AdmobBannerSize.BANNER,
            listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
              if (event == AdmobAdEvent.loaded) {
                dev.log("Admob banner loaded!");
              }
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 40, 47, 34),
              shape: const CircleBorder(),
              onPressed: () async {
                if (await interstitialAd!.isLoaded == true) {
                  interstitialAd!.show();
                }
                // ignore: use_build_context_synchronously
                createNoteAlert(
                  context,
                  size,
                );
              },
              child: const Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 35),
        ],
      ),
    );
  }

  Container searchTextField(Size size) {
    return Container(
      width: size.width,
      height: 50,
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white24,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        autofocus: false,
        style: const TextStyle(
          fontSize: 19,
          color: Colors.white54,
        ),
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onChanged: (value) {
          setState(() {});
          filterNote = value;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 25,
              color: Colors.white54,
            ),
          ),
          hintText: 'Search Note',
          hintStyle: const TextStyle(
            fontSize: 18,
            color: Colors.white54,
          ),
        ),
      ),
    );
  }
}
