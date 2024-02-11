import 'package:flutter/material.dart';
import 'package:learn_app/model/tasks_model.dart';
import 'package:learn_app/repositories/tasks_repository.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  TasksRepository tasksRepository = TasksRepository();
  TextEditingController taskNameController = TextEditingController();
  TasksModel? _tasks;
  bool _showPendingTasks = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  double getCompletedTasksPercentage() {
    if (_tasks == null) {
      return 0;
    }
    var completedTasks = _tasks?.results.where((element) => element.completed);
    return ((completedTasks?.length ?? 0.0) * 100.0 / _tasks!.results.length) /
        100.0;
  }

  void loadTasks() async {
    setState(() {
      _isLoading = true;
    });
    _tasks = await tasksRepository.get(_showPendingTasks);
    setState(() {
      _isLoading = false;
    });
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
                          await tasksRepository.create((Task.create(
                            taskNameController.text,
                            false,
                          ))),
                          loadTasks(),
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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(8),
            child: LinearPercentIndicator(
              lineHeight: 14.0,
              percent: getCompletedTasksPercentage(),
              backgroundColor: Colors.grey,
              progressColor: Colors.black,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.black,
                  ))
                : ListView.builder(
                    itemCount: _tasks?.results.length,
                    itemBuilder: (BuildContext context, int index) {
                      var task = _tasks?.results[index];

                      if (task == null) {
                        return null;
                      }
                      return Dismissible(
                        key: Key(task.objectId.toString()),
                        onDismissed: (direction) async {
                          await tasksRepository.delete(task);
                          loadTasks();
                        },
                        child: ListTile(
                          title: Text(task.description),
                          trailing: Checkbox(
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            value: task.completed,
                            onChanged: (value) async {
                              task.completed = value ?? false;
                              await tasksRepository.update(task);
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
