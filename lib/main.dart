import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_tracker_provider/view/provider/routine_provider.dart';
import 'package:routine_tracker_provider/view/routine_screen/routine_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final routineProvider = RoutineProvider();
  await routineProvider.loadRoutines();

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => routineProvider)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: RoutineScreen(),
      ),
    ),
  );
}
