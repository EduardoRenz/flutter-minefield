import 'dart:math';

import 'package:minefield/models/field.dart';

class Board {
  final int lines;
  final int columns;
  final int bombQuantity;

  final List<Field> _fields = [];

  List<Field> get fields => _fields;

  Board({
    required this.lines,
    required this.columns,
    required this.bombQuantity,
  }) {
    _createFields();
    _relateNeighboards();
    _sortMines();
  }

  bool get solved => _fields.every((field) => field.solved);

  void restart() {
    for (var field in _fields) {
      field.restart();
    }
    _sortMines();
  }

  void revealBombs() {
    for (var field in _fields) {
      field.revealBombs();
    }
  }

  void _createFields() {
    for (int l = 0; l < lines; l++) {
      for (int c = 0; c < columns; c++) {
        _fields.add(Field(line: l, column: c));
      }
    }
  }

  void _relateNeighboards() {
    for (var field in _fields) {
      for (var neighbor in _fields) {
        field.addNeighbor(neighbor);
      }
    }
  }

  void _sortMines() {
    int sorted = 0;

    if (bombQuantity > lines * columns) {
      return;
    }

    while (sorted < bombQuantity) {
      int i = Random().nextInt(_fields.length);
      if (!_fields[i].mined) {
        sorted++;
        _fields[i].mine();
      }
    }
  }
}
