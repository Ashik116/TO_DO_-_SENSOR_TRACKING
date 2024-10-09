import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/modules/todo.dart';
import 'package:todo_app/provider/todo_provider.dart';




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds before navigating to the HomeScreen
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => TodoListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Background color for the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/tasks.png',  // Add your app logo here
              height: 100,        // Adjust the size of the logo
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              "Daily To-Do App",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Sigmar One",
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TodoListScreen extends StatefulWidget {
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {

  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: todoProvider.todos.length,
        itemBuilder: (context, index) {
          final todo = todoProvider.todos[index];
          return ListTile(
            title: Text(
              todo.title,
              style: TextStyle(
                  decoration:
                  todo.isCompleted ? TextDecoration.lineThrough : null),
            ),
            subtitle: Text(
                '${todo.details}\nDue: ${DateFormat.yMMMd().format(todo.dueDate)}'),
            isThreeLine: true,
            trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (value) {
                if (value == true) {
                  todoProvider.markAsCompleted(todo);
                }
              },
            ),
            onLongPress: () {
              // Delete the todo
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Delete "${todo.title}"?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        todoProvider.deleteTodo(todo.id!);
                        Navigator.pop(context);
                      },
                      child: Text('DELETE'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('CANCEL'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Set the border radius
        ),
        backgroundColor: Color(0xFF33CCCC),
        onPressed: () => _showAddTodoDialog(context),
        child: Icon(Icons.add,color:Colors.white ,),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add To-Do'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: _detailsController,
                      decoration: InputDecoration(labelText: 'Details'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(_selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Text('Choose Date'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    if (_titleController.text.isEmpty || _selectedDate == null) {
                      // Show an error message here
                      return;
                    }
                    final newTodo = Todo(
                      title: _titleController.text,
                      details: _detailsController.text,
                      dueDate: _selectedDate!,
                    );
                    Provider.of<TodoProvider>(context, listen: false).addTodo(newTodo);
                    Navigator.pop(context);
                  },
                  child: Text('ADD'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('CANCEL'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// class AddTodoPage extends StatefulWidget {
//   @override
//   _AddTodoPageState createState() => _AddTodoPageState();
// }
//
// class _AddTodoPageState extends State<AddTodoPage> {
//   final _titleController = TextEditingController();
//   final _detailsController = TextEditingController();
//   DateTime? _selectedDate;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add To-Do'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.check),
//             onPressed: () {
//               if (_titleController.text.isEmpty || _selectedDate == null) {
//                 // Show an error message here
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Title and Date are required')),
//                 );
//                 return;
//               }
//
//               // Create a new Todo item here
//               final newTodo = Todo(
//                 title: _titleController.text,
//                 details: _detailsController.text,
//                 dueDate: _selectedDate!,
//               );
//
//               // Assuming you have a TodoProvider with a method `addTodo`
//               Provider.of<TodoProvider>(context, listen: false).addTodo(newTodo);
//               Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//               ),
//               TextField(
//                 controller: _detailsController,
//                 decoration: InputDecoration(labelText: 'Details'),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 children: [
//                   Text(_selectedDate == null
//                       ? 'No Date Chosen!'
//                       : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
//                   Spacer(),
//                   TextButton(
//                     onPressed: () async {
//                       final pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime.now(),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         setState(() {
//                           _selectedDate = pickedDate;
//                         });
//                       }
//                     },
//                     child: Text('Choose Date'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
