import 'package:flutter/material.dart';
import 'package:latihan_todoapp/models/todo.dart';
import 'package:latihan_todoapp/screens/add_todo.dart';
import 'package:latihan_todoapp/screens/todo_item.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Todo> _todos = [];

  void _addTodo(String title) {
    final newTodo = Todo(
      id: const Uuid().v4(),
      title: title,
      isDone: false,
    );
    setState(() {
      _todos.add(newTodo);
    });
  }

  void _toggleTodoCompletion(String id) {
    setState(() {
      final todo = _todos.firstWhere((todo) => todo.id == id);
      todo.isDone = !todo.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddTodoScreen(),
              ));
              if (result != null && result is String) {
                _addTodo(result);
              }
            },
          ),
        ],
      ),
      body: _todos.isEmpty
          ? const Center(
              child: Text(
                'No tasks yet. Add some!',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: _toggleTodoCompletion,
                );
              },
            ),
    );
  }
}
