import 'package:flutter/cupertino.dart';

abstract class TaskBoxCustomWidget extends StatelessWidget {
  const TaskBoxCustomWidget(
      {super.key,
      required this.id,
      required this.title,
      required this.description,
      required this.selected,
      required this.onChangeSelected,
      required this.onDelete,
      required this.navigateTo});
  final int id;
  final String title;
  final String description;
  final bool selected;
  final void Function({required bool? isSelected, required int id})
      onChangeSelected;
  final void Function({required int id}) onDelete;
  final void Function({required int id}) navigateTo;
}
