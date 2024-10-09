import 'package:flutter/material.dart';
import 'package:todo_app/modules/todo.dart';
import 'package:todo_app/service/db_helper.dart';
import 'package:todo_app/service/notification_service.dart';


class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  final DBHelper _dbHelper = DBHelper();
  final NotificationService _notificationService = NotificationService();

  List<Todo> get todos => _todos;

  TodoProvider() {
    loadTodos();
  }

  Future<void> loadTodos() async {
    _todos = await _dbHelper.getTodos();
    notifyListeners();
    scheduleDueDateNotifications();
  }

  Future<void> addTodo(Todo todo) async {
    await _dbHelper.insertTodo(todo);
    _todos = await _dbHelper.getTodos();
    notifyListeners();
    _notificationService.scheduleNotification(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _dbHelper.updateTodo(todo);
    _todos = await _dbHelper.getTodos();
    notifyListeners();
    _notificationService.cancelNotification(todo.id!);
    _notificationService.scheduleNotification(todo);
  }

  Future<void> deleteTodo(int id) async {
    await _dbHelper.deleteTodo(id);
    _todos = await _dbHelper.getTodos();
    notifyListeners();
    _notificationService.cancelNotification(id);
  }

  void markAsCompleted(Todo todo) {
    todo.isCompleted = true;
    updateTodo(todo);
  }

  Future<void> scheduleDueDateNotifications() async {
    for (var todo in _todos) {
      if (!todo.isCompleted) {
        _notificationService.scheduleNotification(todo);
      }
    }
  }
}
