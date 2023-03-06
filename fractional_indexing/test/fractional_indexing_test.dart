import 'package:fractional_indexing/fractional_indexing.dart';
import 'package:test/test.dart';

void main() {
  group('Fractional Indexer Tests', () {
    test('Midpoint', () {
      expect(FractionalIndexer.midpoint("", null), "V");
      expect(FractionalIndexer.midpoint("V", null), "l");
      expect(FractionalIndexer.midpoint("l", null), "t");
      expect(FractionalIndexer.midpoint("t", null), "x");
      expect(FractionalIndexer.midpoint("x", null), "z");
      expect(FractionalIndexer.midpoint("z", null), "zV");
      expect(FractionalIndexer.midpoint("zV", null), "zl");
      expect(FractionalIndexer.midpoint("zl", null), "zt");
      expect(FractionalIndexer.midpoint("zt", null), "zx");
      expect(FractionalIndexer.midpoint("zx", null), "zz");
      expect(FractionalIndexer.midpoint("zz", null), "zzV");
      expect(FractionalIndexer.midpoint("1", "2"), "1V");
      // expect(FractionalIndexer.midpoint("2", "1"), throwsException);
      // expect(FractionalIndexer.midpoint("", ""), throwsException);
      // expect(FractionalIndexer.midpoint("0", "1"), throwsException);
      // expect(FractionalIndexer.midpoint("1", "10"), throwsException);
      // expect(FractionalIndexer.midpoint("11", "1"), throwsException);
      expect(FractionalIndexer.midpoint("001", "001002"), "001001");
      expect(FractionalIndexer.midpoint("001", "001001"), "001000V");
      expect(FractionalIndexer.midpoint("", "V"), "G");
      expect(FractionalIndexer.midpoint("", "G"), "8");
      expect(FractionalIndexer.midpoint("", "8"), "4");
      expect(FractionalIndexer.midpoint("", "4"), "2");
      expect(FractionalIndexer.midpoint("", "2"), "1");
      expect(FractionalIndexer.midpoint("", "1"), "0V");
      expect(FractionalIndexer.midpoint("0V", "1"), "0l");
      expect(FractionalIndexer.midpoint("", "0G"), "08");
      expect(FractionalIndexer.midpoint("", "08"), "04");
      expect(FractionalIndexer.midpoint("", "02"), "01");
      expect(FractionalIndexer.midpoint("", "01"), "00V");
      expect(FractionalIndexer.midpoint("4zz", "5"), "4zzV");
    });

    test('Generate Key Between', () {
      expect(FractionalIndexer.generateKeyBetween(null, null), "a0");
      expect(FractionalIndexer.generateKeyBetween(null, "a0"), "Zz");
      expect(FractionalIndexer.generateKeyBetween("a0", null), "a1");
      expect(FractionalIndexer.generateKeyBetween("a0", "a1"), "a0V");
      expect(FractionalIndexer.generateKeyBetween("a0V", "a1"), "a0l");
      expect(FractionalIndexer.generateKeyBetween("Zz", "a0"), "ZzV");
      expect(FractionalIndexer.generateKeyBetween("Zz", "a1"), "a0");
      expect(FractionalIndexer.generateKeyBetween(null, "Y00"), "Xzzz");
      expect(FractionalIndexer.generateKeyBetween("bzz", null), "c000");
      expect(FractionalIndexer.generateKeyBetween("a0", "a0V"), "a0G");
      expect(FractionalIndexer.generateKeyBetween("a0", "a0G"), "a08");
      expect(FractionalIndexer.generateKeyBetween("b125", "b129"), "b127");
      expect(FractionalIndexer.generateKeyBetween("a0", "a1V"), "a1");
      expect(FractionalIndexer.generateKeyBetween("Zz", "a01"), "a0");
      expect(FractionalIndexer.generateKeyBetween(null, "a0V"), "a0");
      expect(FractionalIndexer.generateKeyBetween(null, "b999"), "b99");
      // expect(FractionalIndexer.generateKeyBetween(null, "A00000000000000000000000000"), throwsException);
      expect(
          FractionalIndexer.generateKeyBetween(
              null, "A000000000000000000000000001"),
          "A000000000000000000000000000V");
      expect(
          FractionalIndexer.generateKeyBetween(
              'zzzzzzzzzzzzzzzzzzzzzzzzzzy', null),
          'zzzzzzzzzzzzzzzzzzzzzzzzzzz');
      expect(
          FractionalIndexer.generateKeyBetween(
              'zzzzzzzzzzzzzzzzzzzzzzzzzzz', null),
          'zzzzzzzzzzzzzzzzzzzzzzzzzzzV');
    });
  });
}
