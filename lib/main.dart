// import 'package:flutter/material.dart';
// import 'package:note_app_depi/views/screens/notes_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(

//       home: const NotesScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_depi/controllers/cubit/notes_cubit.dart';
import 'package:note_app_depi/views/screens/notes_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const NotesScreen(),
      ),
    );
  }
}
