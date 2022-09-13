import 'explosion_exception.dart';

class Field {
  final int line;
  final int column;
  final List<Field> neighbors = [];

  bool _isOpen = false;
  bool _marked = false;
  bool _mined = false;
  bool _exploded = false;

  bool get mined => _mined;
  bool get exploded => _exploded;
  bool get isOpen => _isOpen;
  bool get marked => _marked;

  bool get safeNeighborhood => neighbors.every((v) => !v.mined);

  bool get solved {
    bool minedAndMarked = _mined && marked;
    bool safeAndOpened = !_mined && isOpen;
    return minedAndMarked || safeAndOpened;
  }

  int get minedNeighborhoodQuantity {
    return neighbors.where((v) => v.mined).length;
  }

  Field({
    required this.line,
    required this.column,
  });

  void addNeighbor(Field neighbor) {
    final deltaLine = (line - neighbor.line).abs();
    final deltaColumn = (column - neighbor.column).abs();

    if (deltaLine == 0 && deltaColumn == 0) return;

    if (deltaLine <= 1 && deltaColumn <= 1) {
      neighbors.add(neighbor);
    }
  }

  void open() {
    if (_isOpen) {
      return;
    }
    if (_mined) {
      _exploded = true;
      throw ExplosionException();
    }

    _isOpen = true;

    if (safeNeighborhood) {
      for (var n in neighbors) {
        n.open();
      }
    }
  }

  void revealBombs() {
    if (_mined) {
      _isOpen = true;
    }
  }

  void mine() {
    _mined = true;
  }

  void switchMarked() {
    _marked = !_marked;
  }

  void restart() {
    _isOpen = false;
    _marked = false;
    _mined = false;
    _exploded = false;
  }
}
