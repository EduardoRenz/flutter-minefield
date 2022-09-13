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
  Board? _board;

  Board _getBoard(double width, double height) {
    if (_board != null) return _board!;
    int colQuantity = 15;
    double fieldSize = width / colQuantity;
    int lineQuantity = (height / fieldSize).floor();

    _board = Board(
      lines: lineQuantity,
      columns: colQuantity,
      bombQuantity: 50,
    );
    return _board!;
  }

  void _restart() {
    setState(() {
      _won = null;
      _board?.restart();
    });
  }

  void _open(Field field) {
    if (_won != null) return;
    setState(() {
      try {
        field.open();
        if (_board!.solved) {
          setState(() => _won = true);
        }
      } on ExplosionException {
        setState(() {
          _won = false;
          _board?.revealBombs();
        });
      }
    });
  }

  void _switchMark(Field field) {
    if (_won != null) return;

    setState(() => field.switchMarked());

    if (_board!.solved) {
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
        body: LayoutBuilder(
          builder: (ctx, constraints) => BoardWidget(
            board: _getBoard(constraints.maxWidth, constraints.maxHeight),
            onOpen: _open,
            onSwitchMark: _switchMark,
          ),
        ),
      ),
    );
  }
}
