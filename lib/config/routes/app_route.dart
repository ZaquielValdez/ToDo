import 'package:go_router/go_router.dart';
import 'package:to_do/pages/home.dart';
import 'package:to_do/pages/note_details_screen.dart';
import 'package:to_do/pages/splash_screen.dart';

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
