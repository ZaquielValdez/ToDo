import 'package:go_router/go_router.dart';
import 'package:to_do_bloc/pages/home.dart';
import 'package:to_do_bloc/pages/note_details_screen.dart';
import 'package:to_do_bloc/pages/splash_screen.dart';

final appRoute = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: '/',
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: '/home',
    name: '/home',
    builder: (context, state) => const Home(),
  ),
  GoRoute(
    path: '/note-details',
    name: '/note-details',
    builder: (context, state) => const NoteDetails(),
  ),
]);
