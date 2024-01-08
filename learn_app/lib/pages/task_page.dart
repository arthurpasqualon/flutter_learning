import 'package:flutter/material.dart';
import 'package:learn_app/model/task.dart';
import 'package:learn_app/repositories/task_repository.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TaskRepository taskRepository = TaskRepository();
  TextEditingController taskNameController = TextEditingController();
  List<Task> _tasks = <Task>[];
  bool _showPendingTasks = false;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    if (_showPendingTasks) {
      _tasks = await taskRepository.fetchPendingTasks();
    } else {
      _tasks = await taskRepository.fetchTasks();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          taskNameController.clear();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Add Task"),
                    content: TextField(
                      controller: taskNameController,
                      decoration: const InputDecoration(
                        labelText: "Task Name",
                        hintText: "Enter Task Name",
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async => {
                          Navigator.pop(context),
                          await taskRepository
                              .addTask(Task(taskNameController.text, false)),
                          setState(() {}),
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ));
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("See only Pending Tasks"),
                Switch(
                    value: _showPendingTasks,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.black,
                    onChanged: (value) {
                      _showPendingTasks = value;
                      loadTasks();

                      setState(() {});
                    }),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(_tasks[index].id.toString()),
                    onDismissed: (direction) async {
                      await taskRepository.removeTask(_tasks[index]);
                      loadTasks();
                    },
                    child: ListTile(
                      title: Text(_tasks[index].description),
                      trailing: Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: _tasks[index].isDone,
                        onChanged: (value) async {
                          await taskRepository.toggleTask(_tasks[index]);
                          loadTasks();
                        },
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
