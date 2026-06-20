import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  final DateTime selectedDate;

  ToDoListPage({Key? key, required this.selectedDate}) : super(key: key);
  //o primeiro key escrito acima é com K MAIÚSCULO. TAKE IT?
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Task> tasks = []; //lista inicialmente vazia, por isso = []; chama?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List - ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    tasks[index].name,
                    style: TextStyle(
                      decoration: tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration
                                .none, //if ternário; se V esq. se F direito;
                    ),
                  ),
                  leading: Icon(
                    tasks[index].isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color: tasks[index].isCompleted ? Colors.green : Colors.red,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          _toggleTaskCompletion(
                            index,
                          ); //toggle em inglês = trocar
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showAddTaskDialog(context);
                  },
                  child: Text('Adicionar Tarefa'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showRemoveAllTasksDialog(context);
                  },
                  child: Text('Remover Todas'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //função para mostrar um diálogo para adicionar uma tarefa, chama?
  void _showAddTaskDialog(BuildContext context) {
    String newTaskName = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar Tarefa'),
          content: TextField(
            onChanged: (value) {
              newTaskName = value;
            },
            decoration: InputDecoration(hintText: 'Nome da tarefa'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (newTaskName != '') {
                  setState(() {
                    tasks.add(Task(name: newTaskName));
                  });
                }

                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  //função para mostrar um diálogo  para remover todas as tarefas
  void _showRemoveAllTasksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remover Todas as Tarefas'),
          content: Text('Tem certeza de que deseja remover todas as tarefas?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.clear();
                });
                Navigator.pop(context);
              },
              child: Text('Remover Todas'),
            ),
          ],
        );
      },
    );
  }

  //função para alterar o status da tarefa, concluída ou não
  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  //função para remover uma tarefa, uma task
  void _removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
