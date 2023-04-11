import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/src/widgets/tasks/components/form_update_task.dart';
import 'package:todo_list/src/widgets/tasks/controllers/tasks_controller.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key, required this.id}) : assert(id != null);
  final int? id;
  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final TasksController _tasksController;
  Future<void> _showFormTask() async {
    return await showDialog(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: Colors.red,
          title: const Text("Update task"),
          content: FormUpdateTask(
            id: widget.id!,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _tasksController = Provider.of<TasksController>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tasksController.getTask(id: widget.id!);
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tasksController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final TasksController tasksController = context.watch<TasksController>();
    // tasksController.getTask(id: widget.task!.id!);
    return Scaffold(
      appBar: AppBar(
        title: AnimatedBuilder(
          animation: _tasksController,
          builder: (context, child) =>
              Text(_tasksController.task?.title ?? "title"),
        ),
      ),
      body: SizedBox(
        child: AnimatedBuilder(
          animation: _tasksController,
          builder: (context, child) =>
              Text(_tasksController.task?.description ?? "description"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormTask,
        child: const Icon(Icons.update),
      ),
    );
  }
}
