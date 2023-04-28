// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';
import 'package:todo_list/src/widgets/tasks/pages/tasks_dashboard_page.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, this.id, this.addTask, this.updateTask});
  final String? id;
  final void Function(String id,
      {required String title, required String description})? updateTask;
  final void Function({required String title, required String description})?
      addTask;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final TasksController _tasksController;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  void _backToTaskDashboardPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const TasksDashboardPage(),
    ));
  }

  SnackBar _showSnackBar({required String message, Color? backgroundColor}) {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white70),
      ),
      backgroundColor: backgroundColor,
    );
  }

  void _handlerChangeTask() {
    SnackBar snackBar;
    if (widget.addTask != null) {
      if (_titleController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty) {
        widget.addTask!(
            title: _titleController.text,
            description: _descriptionController.text);
        snackBar = _showSnackBar(
            message: "task added", backgroundColor: Colors.greenAccent);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _backToTaskDashboardPage();
        return;
      }
      snackBar = _showSnackBar(
          message: "task cannot be added", backgroundColor: Colors.redAccent);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (widget.updateTask != null && widget.id != null) {
      if (_titleController.text.isNotEmpty &&
          _descriptionController.text.isNotEmpty) {
        widget.updateTask!(widget.id!,
            title: _titleController.text,
            description: _descriptionController.text);
        snackBar = _showSnackBar(
            message: "task updated", backgroundColor: Colors.greenAccent);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _backToTaskDashboardPage();
        return;
      }
      snackBar = _showSnackBar(
          message: "task cannot be updated", backgroundColor: Colors.redAccent);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    _titleController.clear();
    _descriptionController.clear();
  }

  _checkingIfTaskExist() {
    if (widget.id != null) {
      _tasksController.getTask(id: widget.id!);
      _titleController.text = _tasksController.task!.title;
      _descriptionController.text = _tasksController.task!.description;
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _tasksController = Provider.of<TasksController>(context, listen: false);
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("init state");
      _checkingIfTaskExist();
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxLine = MediaQuery.of(context).size.height.toInt();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: _backToTaskDashboardPage,
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 26,
                        )),
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "title",
                        ),
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: SizedBox(
                  child: AnimatedBuilder(
                    animation: _tasksController,
                    builder: (context, child) => TextField(
                      controller: _descriptionController,
                      style: const TextStyle(fontSize: 26),
                      decoration: const InputDecoration(
                          hintText: "description", border: InputBorder.none),
                      maxLines: maxLine,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handlerChangeTask,
        child: Icon(widget.addTask != null ? Icons.add : Icons.update),
      ),
    );
  }
}
