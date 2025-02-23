import java.math.BigInteger;
import java.util.Arrays;

/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */
class Main {
    public static void main(String... args) {
        texts("", "");
        texts("hello, world!", "");
        texts("a", "something else and very long");
        texts("hello, друг!", "hello, враг!");
        texts("hello, dude", "hello, world!");
        texts("", "hello, world!");
        texts("abc", "bc");
        weights(0, 0);
        weights(Integer.MAX_VALUE, 0);
        weights(14, Integer.MAX_VALUE);
        bigNumbers(BigInteger.ONE, BigInteger.ONE);
        bigNumbers(BigInteger.TEN, BigInteger.TEN);
        bigNumbers(BigInteger.valueOf(500L), BigInteger.valueOf(600L));
        bigNumbers(BigInteger.valueOf(5000000L), BigInteger.valueOf(-9000600L));
        bigNumbers(BigInteger.valueOf(127L), BigInteger.valueOf(126L * 126L));
    }

    private static void compare(Object left, Object right,
        Digitizable ld, Digitizable rd,
        int expected, int actual) {
        if (Math.signum(expected) != Math.signum(actual)) {
            throw new AssertionError(
                String.format(
                    "'%s' %s vs '%s' %s = %d (%d expected)",
                    left, Arrays.toString(ld.digits()),
                    right, Arrays.toString(rd.digits()),
                    actual, expected
                )
            );
        }
        System.out.printf(
            "'%s' vs '%s' = %d\n",
            left, right, actual, expected
        );
    }

    private static void texts(String left, String right) {
        compare(
            left, right,
            new Text(left), new Text(right),
            new AbcComparison<Text>(new Text(left), new Text(right)).value(),
            left.compareTo(right)
        );
    }

    private static void weights(Integer left, Integer right) {
        compare(
            left, right,
            new Weight(left), new Weight(right),
            new Comparison<Weight>(new Weight(left), new Weight(right)).value(),
            left.compareTo(right)
        );
    }

    private static void bigNumbers(BigInteger left, BigInteger right) {
        compare(
            left, right,
            new BigNumber(left), new BigNumber(right),
            new Comparison<BigNumber>(
                new BigNumber(left), new BigNumber(right)
            ).value(),
            left.compareTo(right)
        );
    }
}
