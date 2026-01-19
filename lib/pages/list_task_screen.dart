import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../theme/colors.dart';
import '../widgets/task_item.dart';
import '../utils/dialogs.dart';
 
  /* NOTAS
 *  Panlla lista de tareas
 * contiene crud para crear eliminar y marcar como completada, asi como opcion para eliminar las completadas o seleccionadas
 * contine mensajes de confirmacion, para dar mejor Experciencia de usuario 
 * Uso de Patron Provider en 4 capas, separando la logica y responsabilidad:  
  -Capa UI : interfaz grafica 
  -Proveedor: mantiene el estado, y notifica cambios a la UI
  -Servicio: Se encarga de procesar, consultar e insertar datos en la DB 
  -Datos: herper con la conexion a base de datos   
 */

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Espera a que el widget esté montado para acceder al context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.loadTasks(); // carga inicial de la DB
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context); // escucha cambios

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tareas'),
        actions: [
          if (taskProvider.selectedCount > 0)
            IconButton(
              tooltip: "Eliminar tareas seleccionadas",
              icon: const Icon(Icons.delete_sweep),
              onPressed: () async {
                bool? confirmed = await showConfirmationDialog(
                  context,
                  '¿Estás seguro de eliminar las tareas seleccionadas (${taskProvider.selectedCount})?',
                );
                if (confirmed ?? false) {
                  {
                    taskProvider.clearCompleted();
                  }
                }
              },
            ),
        ],
      ),
      body: Column(
        children: [
          if (taskProvider.tasks.length == 0)
            Expanded(
              child: Column(
                children: [
                  Icon(
                    Icons.hourglass_empty, // ícono que quieras
                    color: AppColors.secondary,
                    size: 40,
                  ),
                  Text("Lista vacía, agrega algunos elementos"),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return TaskItem(task: task);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ingresa una tarea',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    backgroundColor: AppColors.primary,
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  icon: const Icon(Icons.send_rounded),
                  onPressed: () {
                    if (_controller.text.trim().isEmpty) return;
                    taskProvider.addTask(_controller.text.trim());
                    _controller.clear();

                    Future.delayed(Duration(milliseconds: 100), () {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
