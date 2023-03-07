# dart-fractional-indexing
Implemention of fractional indexing in dart

90%: https://observablehq.com/@dgreensp/implementing-fractional-indexing

9%:  GitHub Copilot

1%:  Me

# Usage
All functions are exposed through `FractionalIndexer`. You're most likely interested in:

`static String? generateKeyBetween(String? a, String? b)`

Usage Examples (from test cases):
```expect(FractionalIndexer.generateKeyBetween(null, null), "a0");
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
```

Read the article linked above for more information. Feel free to report any issues.

This is used within Chronos for reorderable lists.
