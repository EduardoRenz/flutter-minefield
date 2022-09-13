import 'package:flutter_test/flutter_test.dart';
import 'package:minefield/models/board.dart';

main() {
  test('Win Game', () {
    Board board = Board(lines: 2, columns: 2, bombQuantity: 0);

    board.fields[0].mine();
    board.fields[3].mine();

    board.fields[0].switchMarked();
    board.fields[1].open();
    board.fields[2].open();
    board.fields[3].switchMarked();

    expect(board.solved, isTrue);
  });
}
