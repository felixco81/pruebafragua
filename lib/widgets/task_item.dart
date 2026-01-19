import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../theme/colors.dart';
import '../utils/dialogs.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _animate = false;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Container(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.fromLTRB(5, 2, 5, 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),

      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
            leading: Checkbox(
              activeColor: AppColors.orange,
              value: widget.task.completed,
              onChanged: (_) => taskProvider.toggleTask(widget.task.id ?? 0),
            ),
            title: Text(
              widget.task.title,
              style: TextStyle(
                decoration: widget.task.completed
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () async {
                bool? confirmed = await showConfirmationDialog(
                  context,
                  '¿Estas seguro de eliminar la tarea?',
                );
                if (confirmed ?? false) {
                  {
                    taskProvider.removeTask(widget.task.id ?? 0);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
