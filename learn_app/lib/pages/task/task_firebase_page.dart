import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/model/task_firebase_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class TaskFirebasePage extends StatefulWidget {
  const TaskFirebasePage({super.key});

  @override
  State<TaskFirebasePage> createState() => _TaskFirebasePageState();
}

class _TaskFirebasePageState extends State<TaskFirebasePage> {
  final db = FirebaseFirestore.instance;
  String userId = "";

  TextEditingController taskNameController = TextEditingController();
  bool _showOnlyPending = false;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  void loadUserId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String? value = sharedPrefs.getString("userId");
    if (value == null) {
      value = const Uuid().v4();
      sharedPrefs.setString("userId", value);
    }
    setState(() {
      userId = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    void closeModal() {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
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
                        onPressed: () async {
                          var task = TaskFirebaseModel(
                              description: taskNameController.text,
                              completed: false,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                              userId: userId);
                          var doc =
                              await db.collection("tasks").add(task.toJson());
                          debugPrint("Task added with id: ${doc.id}");
                          closeModal();
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
                    value: _showOnlyPending,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _showOnlyPending = value;
                      });
                    }),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _showOnlyPending
                    ? db
                        .collection("tasks")
                        .where("completed", isEqualTo: false)
                        .where("userId", isEqualTo: userId)
                        .snapshots()
                    : db
                        .collection("tasks")
                        .where("userId", isEqualTo: userId)
                        .snapshots(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? ListView(
                          children: [
                            ...snapshot.data!.docs.map((e) {
                              var task = TaskFirebaseModel.fromJson(
                                  e.data() as Map<String, dynamic>);
                              return Dismissible(
                                key: Key(e.id),
                                onDismissed: (direction) async {
                                  await db
                                      .collection("tasks")
                                      .doc(e.id)
                                      .delete();
                                },
                                child: ListTile(
                                  title: Text(task.description),
                                  trailing: Checkbox(
                                    activeColor: Colors.black,
                                    checkColor: Colors.white,
                                    value: task.completed,
                                    onChanged: (value) async {
                                      task.completed = value!;
                                      task.updatedAt = DateTime.now();
                                      await db
                                          .collection("tasks")
                                          .doc(e.id)
                                          .update(task.toJson());
                                    },
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        )
                      : const Center(child: CircularProgressIndicator());
                }),
          )
        ],
      ),
    );
  }
}
