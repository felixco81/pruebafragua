import 'dart:ui';

import 'package:flutter/material.dart';
class GlassButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const GlassButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _animate = false;

  void _handleTap() async {
    setState(() => _animate = true);

    await Future.delayed(const Duration(milliseconds: 90));

    setState(() => _animate = false);
    widget.onTap();
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
