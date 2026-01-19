import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../view_models/search_view_model.dart';
import '../theme/colors.dart';
import '../utils/dialogs.dart';
import '../widgets/unsplash_item.dart';

/* NOTAS
 *   Pantalla busqueda y consulo de api 
 *   Patron MVVM 
 *   Lista de imagenes con descripcio, al tocar la card, abre una page, donde se puede ver  la imagen, asi como soporta gestos para zoom 
 *   Muestra loading mientras carga, emptyView cuando no hay resultados 
 *   UX: al perder el foco del buscador, se dispara la busqueda, focus automatico al entrar a la page 
 *   
 */

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  late final SearchViewModel viewModel;

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    viewModel = SearchViewModel();
    // Escuchar cambios del ViewModel
    viewModel.addListener(() {
      setState(() {}); // Actualiza UI cuando cambian las imágenes
    });
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _search();
      }
    });
  }

  void _search() {
    if (_controller.text.trim().isEmpty) return;
    viewModel.Search(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0, // quita el espacio por defecto antes del title
        title: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) => _search(),
                  autofocus: true,
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              IconButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  backgroundColor: AppColors.primary,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                ),
                icon: const Icon(Icons.search),
                onPressed: () {
                  _search();
                },
              ),
            ],
          ), 
        ),
      ),
      body: Column(
        children: [
          if (viewModel.images.length == 0 && !viewModel.loading)
            Expanded(
              child: Column(
                children: [
                  Icon(
                    Icons.search, // ícono que quieras
                    color: AppColors.secondary,
                    size: 40,
                  ),
                  Text("Escribe un criterio de busqueda"),
                ],
              ),
            ),

          if (viewModel.loading)
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CircularProgressIndicator(),
                  SizedBox(height: 5),
                  Text("Crgando...."),
                ],
              ),
            ),

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: viewModel.images.length,
              itemBuilder: (context, index) {
                final item = viewModel.images[index];
                return UnSplashItem(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
