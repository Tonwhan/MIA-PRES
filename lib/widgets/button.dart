import 'package:flutter/material.dart';

enum IconPosition { left, right }

class CustomGradientButton extends StatefulWidget {
  final String label;
  final IconData? icon;
  final Widget pageRoute;
  final bool fullWidth;
  final IconPosition iconPosition;

  const CustomGradientButton({
    super.key,
    required this.label,
    this.icon,
    required this.pageRoute,
    this.fullWidth = false,
    this.iconPosition = IconPosition.left,
  });

  @override
  State<CustomGradientButton> createState() => _CustomGradientButtonState();
}

class _CustomGradientButtonState extends State<CustomGradientButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => widget.pageRoute),
        );
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          width: widget.fullWidth ? double.infinity : null,
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0XFF232120), Color(0XFF232120)],
            ),
          ),
          child: Center(
            child: Row(
              mainAxisSize: widget.fullWidth
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.icon != null &&
                    widget.iconPosition == IconPosition.left) ...[
                  Icon(widget.icon, color: Colors.white, size: 22),
                  const SizedBox(width: 8),
                ],

                Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                if (widget.icon != null &&
                    widget.iconPosition == IconPosition.right) ...[
                  const SizedBox(width: 8),
                  Icon(widget.icon, color: Colors.white, size: 22),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
