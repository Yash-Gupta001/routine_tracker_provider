import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:routine_tracker_provider/model/routine_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoutineProvider with ChangeNotifier {
  final List<Routine> _routine = [];

  List<Routine> get routine => _routine;
  int get totalRoutine => _routine.length;

  int get completedRoutines =>
      _routine.where((routine) => routine.isCompleted).length;

  double get completePercentage {
    if (totalRoutine == 0) return 0;
    return (completedRoutines / totalRoutine) * 100;
  }

  // Save routines to shared preferences
  Future<void> saveRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    final routineJson = jsonEncode(_routine.map((r) => r.toJson()).toList());
    await prefs.setString('routines', routineJson);
  }

  // Load routines from shared preferences
  Future<void> loadRoutines() async {
    final prefs = await SharedPreferences.getInstance();
    final routineJson = prefs.getString('routines');
    if (routineJson != null) {
      final decoded = jsonDecode(routineJson) as List;
      _routine.clear();
      _routine.addAll(decoded.map((r) => Routine.fromJson(r)));
      notifyListeners();
    }
  }

  void addRoutine(String title) {
    final newRoutine = Routine(id: DateTime.now().toString(), title: title);
    _routine.add(newRoutine);
    saveRoutines();
    notifyListeners();
  }

  void toggleRoutine(String id) {
    final index = _routine.indexWhere((routine) => routine.id == id);
    if (index != -1) {
      _routine[index].isCompleted = !_routine[index].isCompleted;
      saveRoutines();
      notifyListeners();
    }
  }

  void resetRoutine() {
    for (var routine in _routine) {
      routine.isCompleted = false;
    }
    saveRoutines();
    notifyListeners();
  }

  void removeRoutine(String id) {
    _routine.removeWhere((routine) => routine.id == id);
    saveRoutines();
    notifyListeners();
  }
}
