import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_app/controllers/tasks_getx_controller.dart';
import 'package:learn_app/model/tasks_model.dart';

// ignore: must_be_immutable
class TaskGetXPage extends StatelessWidget {
  TaskGetXController taskGetXController = Get.put(TaskGetXController());
  TextEditingController taskNameController = TextEditingController();

  TaskGetXPage({super.key});

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
                          taskGetXController.addTask((Task(
                            DateTime.now().toUtc().toString(),
                            DateTime.now().toString(),
                            DateTime.now().toString(),
                            taskNameController.text,
                            false,
                          ))),
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
                Obx(
                  () => Switch(
                      value: taskGetXController.showPendingTasks,
                      activeColor: Colors.white,
                      activeTrackColor: Colors.black,
                      onChanged: (value) {
                        taskGetXController.showPendingTasks = value;
                      }),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                itemCount: taskGetXController.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  var task = taskGetXController.tasks[index];

                  if (task == null) {
                    return null;
                  }
                  return Dismissible(
                    key: Key(task.objectId.toString()),
                    onDismissed: (direction) async {
                      taskGetXController.removeTask(task.objectId);
                    },
                    child: ListTile(
                      title: Text(task.description),
                      trailing: Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: task.completed,
                        onChanged: (value) async {
                          taskGetXController.toggleTask(task.objectId, value!);
                        },
                      ),
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }
}
