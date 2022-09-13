import 'package:flutter/material.dart';
import 'package:minefield/components/board_widget.dart';
import 'package:minefield/components/result_widget.dart';
import 'package:minefield/models/board.dart';
import 'package:minefield/models/explosion_exception.dart';
import 'package:minefield/models/field.dart';

class MinedFieldApp extends StatefulWidget {
  const MinedFieldApp({super.key});

  @override
  State<MinedFieldApp> createState() => _MinedFieldAppState();
}

class _MinedFieldAppState extends State<MinedFieldApp> {
  bool? _won;
  final Board _board = Board(lines: 15, columns: 15, bombQuantity: 3);

  void _restart() {
    setState(() {
      _won = null;
      _board.restart();
    });
  }

  void _open(Field field) {
    if (_won != null) return;
    setState(() {
      try {
        field.open();
        if (_board.solved) {
          setState(() => _won = true);
        }
      } on ExplosionException {
        setState(() {
          _won = false;
          _board.revealBombs();
        });
      }
    });
  }

  void _switchMark(Field field) {
    if (_won != null) return;

    setState(() => field.switchMarked());

    if (_board.solved) {
      setState(() => _won = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultWidget(
          won: _won,
          onRestart: _restart,
        ),
        body: Container(
          child: BoardWidget(
            board: _board,
            onOpen: _open,
            onSwitchMark: _switchMark,
          ),
        ),
      ),
    );
  }
}
