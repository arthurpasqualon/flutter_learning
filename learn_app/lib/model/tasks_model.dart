class TasksModel {
  List<Task> results = [];

  TasksModel(this.results);

  TasksModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Task>[];
      json['results'].forEach((v) {
        results.add(Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results.map((v) => v.toJson()).toList();
    return data;
  }
}

class Task {
  String objectId = '';
  String createdAt = '';
  String updatedAt = '';
  String description = '';
  bool completed = false;

  Task(this.objectId, this.createdAt, this.updatedAt, this.description,
      this.completed);

  Task.create(this.description, this.completed) {
    objectId = '';
    createdAt = '';
    updatedAt = '';
  }

  Task.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    description = json['description'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['completed'] = completed;
    return data;
  }
}
