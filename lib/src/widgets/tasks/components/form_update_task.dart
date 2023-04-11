import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/tasks_controller.dart';

class FormUpdateTask extends StatefulWidget {
  const FormUpdateTask({super.key, required this.id}) : assert(id != 0);
  final int id;
  @override
  State<FormUpdateTask> createState() => _FormUpdateTaskState();
}

class _FormUpdateTaskState extends State<FormUpdateTask> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TasksController _tasksController;
  late final GlobalKey<FormState> _formUpdateTaskKey;

  @override
  void initState() {
    _tasksController = context.read<TasksController>();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _formUpdateTaskKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  _updateTask() {
    if (_formUpdateTaskKey.currentState!.validate()) {
      _tasksController.updateTask(widget.id,
          title: _titleController.text,
          description: _descriptionController.text);
      Navigator.pop(context);
    }
  }

  _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          key: _formUpdateTaskKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    label: Text("title"), border: OutlineInputBorder()),
                controller: _titleController,
                validator: (title) {
                  if (title == null || title.isEmpty) {
                    return "please fill in the title field";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      label: Text("description"), border: OutlineInputBorder()),
                  validator: (description) {
                    if (description == null || description.isEmpty) {
                      return "please fill in the description field";
                    }
                    return null;
                  }),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: _updateTask, child: const Text("update")),
                  ElevatedButton(
                      onPressed: _cancel, child: const Text("cancel")),
                ],
              )
            ],
          )),
    );
  }
}
