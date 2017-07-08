/**
 * Copyright (c) 2017 Yegor Bugayenko
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the 'Software'), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so. The Software doesn't include files with .md extension.
 * That files you are not allowed to copy, distribute, modify, publish, or sell.
 *
 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
class Main {
    public static void main(String... args) {
        texts("", "");
        texts("hello, world!", "");
        texts("hello, друг!", "hello, враг!");
        texts("hello, dude", "hello, world!");
        texts("", "hello, world!");
        weights(0, 0);
        weights(Integer.MAX_VALUE, 0);
        weights(14, Integer.MAX_VALUE);
    }

    private static void compare(Object left, Object right,
        int expected, int actual) {
        if (Math.signum(expected) != Math.signum(actual)) {
            throw new AssertionError(
                String.format(
                    "'%s' vs '%s' = %d (%d expected)",
                    left, right, actual, expected
                )
            );
        }
    }

    private static void texts(String left, String right) {
        compare(
            left, right,
            new Comparison<Text>(new Text(left), new Text(right)).value(),
            left.compareTo(right)
        );
    }

    private static void weights(Integer left, Integer right) {
        compare(
            left, right,
            new Comparison<Weight>(new Weight(left), new Weight(right)).value(),
            left.compareTo(right)
        );
    }
}
