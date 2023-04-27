import 'package:flutter/material.dart';
import 'package:todo_list/src/widgets/tasks/components/task_box_custom_widget.dart';

class TaskCardCustomWidget extends TaskBoxCustomWidget {
  const TaskCardCustomWidget(
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
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: selected ? Colors.greenAccent : Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: selected,
                onChanged: (value) => onChangeSelected(
                  isSelected: value,
                  id: id,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: selected ? Colors.white : Colors.black54),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(description,
                          style: TextStyle(
                              fontSize: 18,
                              color: selected ? Colors.white : Colors.black54))
                    ],
                  ),
                ),
              ),
              IconButton(
                  onPressed: () => onDelete(id: id),
                  icon: Icon(Icons.delete,
                      color: selected ? Colors.white : Colors.black54))
            ],
          ),
        ),
        onTap: () => navigateTo(id: id),
      ),
    );
  }
}
