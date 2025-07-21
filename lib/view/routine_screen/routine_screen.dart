import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_tracker_provider/view/provider/routine_provider.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final routineProvider = Provider.of<RoutineProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Routine',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: routineProvider.resetRoutine,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
              ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Progress: Task Completed',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: routineProvider.completePercentage / 100,
                ),
                const SizedBox(height: 8),
                Text(
                  'Completion Percentage: ${routineProvider.completePercentage.toStringAsFixed(1)}%',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ), 
          ),
          Expanded(
            child: ListView.builder(
              itemCount: routineProvider.routine.length,
              itemBuilder: (ctx, index) {
                final routine = routineProvider.routine[index];
                return InkWell(
                  onLongPress: () {
                    routineProvider.removeRoutine(routine.id);
                  },
                  child: ListTile(
                    title: Text(routine.title),
                    trailing: Checkbox(
                      value: routine.isCompleted,
                      onChanged: (_) {
                        routineProvider.toggleRoutine(routine.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              String newRoutineTitle = '';
              return AlertDialog(
                title: const Text('Add Routine'),
                content: TextField(
                  onChanged: (value) => newRoutineTitle = value,
                  decoration:
                      const InputDecoration(hintText: "Routine Title"),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newRoutineTitle.isNotEmpty) {
                        routineProvider.addRoutine(newRoutineTitle);
                        Navigator.of(ctx).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
