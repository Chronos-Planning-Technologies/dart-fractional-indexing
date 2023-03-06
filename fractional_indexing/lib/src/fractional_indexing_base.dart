import 'dart:core';

class FractionalIndexer {
  static const String digits =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';

  static const String integerZero = 'a0';
  static const String smallestInteger = "A00000000000000000000000000";

  // Note:
  // String compareTo returns
  /* negative value if first string is less than the second string.
     zero if first string equals second string.
     positive value if first string is greater than the second string. 
  */

  static int getIntegerLength(String head) {
    if (head.compareTo('a') >= 0 && head.compareTo('z') <= 0) {
      return head.codeUnitAt(0) - 'a'.codeUnitAt(0) + 2;
    } else if (head.compareTo('A') >= 0 && head.compareTo('Z') <= 0) {
      return 'Z'.codeUnitAt(0) - head.codeUnitAt(0) + 2;
    } else {
      throw Exception('Invalid order key head: $head');
    }
  }

  static bool validateInteger(String integer) {
    if (integer.length != getIntegerLength(integer[0])) {
      throw Exception('Invalid integer part of order key: $integer');
    }
    return true;
  }

  static String? incrementInteger(String x) {
    validateInteger(x);
    String head = x[0];
    List<String> digs = x.substring(1).split('');

    bool carry = true;

    for (int i = digs.length - 1; carry && i >= 0; i--) {
      int d = digits.indexOf(digs[i]) + 1;
      if (d == digits.length) {
        digs[i] = '0';
      } else {
        digs[i] = digits[d];
        carry = false;
      }
    }

    if (carry) {
      if (head == 'Z') {
        return 'a0';
      }
      if (head == 'z') {
        return null;
      }
      String h = String.fromCharCode(head.codeUnitAt(0) + 1);
      if (h.compareTo('a') > 0) {
        digs.add('0'); // Equivalent to digs.push('0');
      } else {
        digs.removeLast(); // Equivalent to digs.pop();
      }
      return h + digs.join('');
    } else {
      return head + digs.join('');
    }
  }

  static String? decrementInteger(String x) {
    validateInteger(x);
    String head = x[0];
    List<String> digs = x.substring(1).split('');

    bool borrow = true;

    for (int i = digs.length - 1; borrow && i >= 0; i--) {
      int d = digits.indexOf(digs[i]) - 1;
      if (d == -1) {
        digs[i] = digits[digits.length - 1]; // Equivalent to digits.slice(-1)
      } else {
        digs[i] = digits[d];
        borrow = false;
      }
    }

    if (borrow) {
      if (head == 'a') {
        return 'Z${digits[digits.length - 1]}'; // Equivalent to 'Z' + digits.slice(-1)
      }
      if (head == 'A') {
        return null;
      }
      String h = String.fromCharCode(head.codeUnitAt(0) - 1);
      if (h.compareTo('Z') < 0) {
        digs.add(digits[
            digits.length - 1]); // Equivalent to digs.push(digits.slice(-1))
      } else {
        digs.removeLast(); // Equivalent to digs.pop();
      }
      return h + digs.join('');
    } else {
      return head + digs.join('');
    }
  }

  static String midpoint(String a, String? b) {
    if (b != null && a.compareTo(b) >= 0) {
      throw Exception(
          "Second order key must be greater than the first: $a, $b");
    }

    if (a.isNotEmpty && a[a.length - 1] == '0' ||
        (b != null && b.isNotEmpty && b[b.length - 1] == '0')) {
      throw Exception("Trailing zeros are not allowed: $a, $b");
    }

    if (b != null) {
      // remove longest common prefix.  pad `a` with 0s as we
      // go.  note that we don't need to pad `b`, because it can't
      // end before `a` while traversing the common prefix.
      int n = 0;
      while ((n < a.length ? a[n] : '0') == b[n]) {
        n++;
      }

      if (n > 0) {
        return b.substring(0, n) +
            midpoint(
                a.substring(min(n, a.length)), b.substring(min(n, b.length)));
      }
    }

    int digitA = (a.isNotEmpty) ? digits.indexOf(a[0]) : 0;
    int digitB =
        (b != null && b.isNotEmpty) ? digits.indexOf(b[0]) : digits.length;

    if (digitB - digitA > 1) {
      int midDigit = (digitA + digitB + 1) ~/ 2; // +1 is for rounding up
      return digits[midDigit];
    } else {
      // `a` and `b` are adjacent in the digit space.
      if (b != null && b.length > 1) {
        return b.substring(0, 1);
      } else {
        // `b` is null or has length 1 (a single digit).
        // the first digit of `a` is the previous digit to `b`,
        // or 9 if `b` is null.
        // given, for example, midpoint('49', '5'), return
        // '4' + midpoint('9', null), which will become
        // '4' + '9' + midpoint('', null), which is '495'
        return digits[digitA] +
            midpoint(a.isNotEmpty ? a.substring(1) : '', null);
      }
    }
  }

  static String getIntegerPart(String key) {
    int integerPartLength = getIntegerLength(key[0]);
    if (integerPartLength > key.length) {
      throw Exception('Invalid order key: $key');
    }
    return key.substring(0, integerPartLength);
  }

  static bool validateOrderKey(key) {
    if (key == smallestInteger) {
      throw Exception('Invalid order key: $key');
    }

    String i = getIntegerPart(key);
    String f = key.substring(i.length);
    if (f.isNotEmpty && f[f.length - 1] == '0') {
      throw Exception('Invalid order key: $key');
    }
    return true;
  }

  // `a` is an order key or null (START).
  // `b` is an order key or null (END).
  // `a < b` lexicographically if both are non-null.
  static String? generateKeyBetween(String? a, String? b) {
    if (a != null) {
      validateOrderKey(a);
    }

    if (b != null) {
      validateOrderKey(b);
    }

    if (a != null && b != null && a.compareTo(b) >= 0) {
      throw Exception(
          'Second order key must be greater than the first: $a, $b');
    }

    if (a == null && b == null) {
      return integerZero;
    }

    if (a == null) {
      // B is non-null, otherwise we would have thrown an exception.
      b = b!;
      String ib = getIntegerPart(b);
      String fb = b.substring(ib.length);
      if (ib == smallestInteger) {
        return ib + midpoint('', fb);
      }
      return ib.compareTo(b) < 0 ? ib : decrementInteger(ib);
    }

    if (b == null) {
      // A is non-null, otherwise we would have thrown an exception.
      String ia = getIntegerPart(a);
      String fa = a.substring(ia.length);
      String? i = incrementInteger(ia);
      return i ?? ia + midpoint(fa, null);
    }

    String ia = getIntegerPart(a);
    String fa = a.substring(ia.length);
    String ib = getIntegerPart(b);
    String fb = b.substring(ib.length);

    if (ia == ib) {
      return ia + midpoint(fa, fb);
    }

    String? i = incrementInteger(ia);
    return (i == null || i.compareTo(b) < 0) ? i : ia + midpoint(fa, null);
  }

  static List<String?> generateNKeysBetween(String? a, String? b, int n) {
    if (n <= 0) {
      return [];
    }
    if (n == 1) {
      return [generateKeyBetween(a, b)];
    }

    if (b == null) {
      String? c = generateKeyBetween(a, b);
      List<String?> result = [c];
      for (int i = 1; i < n; i++) {
        c = generateKeyBetween(c, b);
        result.add(c);
      }
      return result;
    }

    if (a == null) {
      String? c = generateKeyBetween(a, b);
      List<String?> result = [c];
      for (int i = 1; i < n; i++) {
        c = generateKeyBetween(a, c);
        result.add(c);
      }
      return result.reversed.toList();
    }

    int mid = n ~/ 2;
    String? c = generateKeyBetween(a, b);
    return generateNKeysBetween(a, c, mid)
        .followedBy([c])
        .followedBy(generateNKeysBetween(c, b, n - mid - 1))
        .toList();
  }

  static int min(int a, int b) {
    return a < b ? a : b;
  }
}
