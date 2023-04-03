import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';

class FormTask extends StatefulWidget {
  const FormTask({super.key});

  @override
  State<FormTask> createState() => _FormTaskState();
}

class _FormTaskState extends State<FormTask> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TasksController _tasksController;
  late final GlobalKey<FormState> _formTaskKey;
  @override
  void initState() {
    _formTaskKey = GlobalKey<FormState>();
    _tasksController = context.read<TasksController>();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  _createTask() {
    _tasksController.addTask(
        title: _titleController.text, description: _descriptionController.text);
    Navigator.pop(context);
  }

  _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formTaskKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    label: Text("title"), border: OutlineInputBorder()),
                controller: _titleController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                    label: Text("description"), border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _createTask, child: const Text("add")),
                  ElevatedButton(
                      onPressed: _cancel, child: const Text("cancel")),
                ],
              )
            ],
          )),
    );
  }
}
