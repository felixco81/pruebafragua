import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/unsplass_foto.dart';
import '../providers/task_provider.dart';
import '../theme/colors.dart';
import '../utils/dialogs.dart';
import '../pages/image_screen.dart';

class UnSplashItem extends StatefulWidget {
  final UnsplashPhoto item;
  const UnSplashItem({super.key, required this.item});

  @override
  State<UnSplashItem> createState() => _UnSplashItemState();
}

class _UnSplashItemState extends State<UnSplashItem> {
  bool _animate = false;

  void _handleTap() async {
    setState(() => _animate = true); 
    await Future.delayed(const Duration(milliseconds: 90)); 
    setState(() => _animate = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageScreen(imageUrl: widget.item.imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _animate ? 0.94 : 1.0,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _animate ? 0.85 : 1,
        duration: const Duration(milliseconds: 120),
        child: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
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
          child: ElevatedButton(
            onPressed: _handleTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ClipRRect aplica el borderRadius a la imagen
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    widget.item.thumbnailUrl,
                    height: 270,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.item.description,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 12),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "Ver",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
