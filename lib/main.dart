import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do/bloc/note_bloc/note_bloc.dart';
import 'package:to_do/config/routes/app_route.dart';
import 'package:to_do/config/theme/app_theme.dart';
import 'package:to_do/cubit_actual_note/actual_note_cubit.dart';
import 'package:to_do/data/models/hive_note.dart';
import 'package:to_do/utils/box.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelHiveAdapter());
  noteBox = await Hive.openBox<NoteModelHive>("Notes");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NoteBloc(),
        ),
        BlocProvider(
          create: (context) => ActualNoteCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRoute,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
      ),
    );
  }
}
