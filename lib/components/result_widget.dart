import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? won;
  final Function onRestart;

  const ResultWidget({
    super.key,
    this.won,
    required this.onRestart,
  });

  Color _getColor() {
    if (won == null) return Colors.yellow;
    if (won == true) return Colors.green.shade300;
    return Colors.red.shade300;
  }

  IconData _getICon() {
    if (won == null) return Icons.sentiment_satisfied;
    if (won == true) return Icons.sentiment_very_satisfied;
    return Icons.sentiment_dissatisfied;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getColor(),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: () => onRestart.call(),
              icon: Icon(
                _getICon(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(120);
}
