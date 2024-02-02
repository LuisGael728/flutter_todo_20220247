import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class TodoTask {
  String description;
  bool isCompleted;

  TodoTask(this.description, this.isCompleted);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: Text('Mis Tareas Pendientes'),
          backgroundColor: Colors.indigo,
        ),
        body: TodoTaskList(),
      ),
    );
  }
}

class TodoTaskList extends StatefulWidget {
  @override
  _TodoTaskListState createState() => _TodoTaskListState();
}

class _TodoTaskListState extends State<TodoTaskList> {
  List<TodoTask> tasks = [];

  void addTask(String description) {
    setState(() {
      tasks.add(TodoTask(description, false));
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Card(
                color: tasks[index].isCompleted ? Colors.green : Colors.white,
                child: ListTile(
                  title: Text(
                    tasks[index].description,
                    style: TextStyle(
                      decoration: tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      color: tasks[index].isCompleted ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {
                    toggleTask(index);
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Agregar Nueva Tarea'),
                    content: TextField(
                      autofocus: true,
                      onSubmitted: (value) {
                        addTask(value);
                        Navigator.of(context).pop();
                      },
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Nueva Tarea'),
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo,
            ),
          ),
        ),
      ],
    );
  }
}

