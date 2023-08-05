import 'package:flutter/material.dart';

class InkWellListTile extends StatelessWidget {
  final Widget listTile;
  final VoidCallback? onTap;
  final double padding;

  const InkWellListTile(
      {super.key,
      required this.listTile,
      required this.onTap,
      this.padding = 0});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: padding),
        child: Material(
            color: Theme.of(context).colorScheme.primary,
            child: InkWell(
                splashColor: Theme.of(context).splashColor,
                onTap: onTap,
                child: listTile)));
  }
}
