import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<TodoItem> _todoItems = [];
  final TextEditingController _textController = TextEditingController();

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(TodoItem(title: task, isCompleted: false));
      });
      _textController.clear();
    }
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].isCompleted = !_todoItems[index].isCompleted;
    });
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptAddTodoItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Color.fromARGB(255, 230, 230, 243), // Light yellow background
          title: Text(
            'Add a New Task',
            style: TextStyle(
              color: Color.fromARGB(255, 252, 76, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Enter task here',
              labelStyle: TextStyle(color: Color.fromARGB(239, 238, 2, 2)),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 255, 134, 68)),
              ),
            ),
            onSubmitted: (value) {
              _addTodoItem(value);
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addTodoItem(_textController.text);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent, // Button color
              ),
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  Widget _buildTodoItem(TodoItem item, int index) {
    return Container(
      color: Color.fromARGB(
          255, 157, 3, 246), // Light yellow background for list items
      child: ListTile(
        title: Text(
          item.title,
          style: TextStyle(
            decoration: item.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        leading: Checkbox(
          value: item.isCompleted,
          onChanged: (bool? value) {
            _toggleTodoItem(index);
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            _removeTodoItem(index);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        color: const Color.fromARGB(
            255, 249, 224, 2), // Light yellow background for the entire body
        child: _buildTodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddTodoItem,
        tooltip: 'Add Task',
        backgroundColor: Color.fromARGB(255, 164, 6, 231),
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItem {
  String title;
  bool isCompleted;

  TodoItem({required this.title, this.isCompleted = false});
}
