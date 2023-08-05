import 'package:flutter/material.dart';

class ItemActionBtn extends StatefulWidget {
  final String tooltip;
  final VoidCallback onPressed;
  final IconData icon;
  final bool selected;

  const ItemActionBtn({
    super.key,
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    required this.selected,
  });

  @override
  State<ItemActionBtn> createState() => _ItemActionBtnState();
}

class _ItemActionBtnState extends State<ItemActionBtn> {
  Color? iconColor;
  void setHoverColor(bool isHover) {
    if (widget.selected) return;
    if (isHover) {
      setState(() {
        iconColor = Theme.of(context).colorScheme.error;
      });
    } else {
      setState(() {
        iconColor = Theme.of(context).iconTheme.color!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 18,
        width: 18,
        child: MouseRegion(
          onEnter: (event) => setHoverColor(true),
          onExit: (event) => setHoverColor(false),
          child: IconButton(
            iconSize: 18,
            padding: EdgeInsets.zero,
            tooltip: widget.tooltip,
            onPressed: widget.onPressed,
            icon: Icon(
              widget.icon,
              color: widget.selected
                  ? Theme.of(context).colorScheme.error
                  : iconColor ?? Theme.of(context).iconTheme.color!,
            ),
          ),
        ));
  }
}
