import 'package:flutter/material.dart';
import 'package:todo_list/src/widgets/tasks/components/task_box_custom_widget.dart';

class TaskListTileCustomWidget extends TaskBoxCustomWidget {
  const TaskListTileCustomWidget(
      {super.key,
      required super.id,
      required super.title,
      required super.description,
      required super.selected,
      required super.onChangeSelected,
      required super.onDelete,
      required super.navigateTo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 6.0, top: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white24,
        leading: Checkbox(
            value: selected,
            onChanged: (isSelected) =>
                onChangeSelected(isSelected: isSelected, id: id)),
        title: Text(title),
        subtitle: Text(description),
        onTap: () => navigateTo(id: id),
        onLongPress: () => onDelete(id: id),
      ),
    );
  }
}
