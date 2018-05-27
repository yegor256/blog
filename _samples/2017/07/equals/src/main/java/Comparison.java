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
class Comparison<T extends Digitizable> {
    private T rt;
    private T lt;
    Comparison(T left, T right) {
        this.lt = left;
        this.rt = right;
    }
    int value() {
        final byte[] left = this.lt.digits();
        final byte[] right = this.rt.digits();
        long lenDiff = (long) left.length - (long) right.length;
        if (lenDiff != 0) {
            return (int) Long.signum(lenDiff);
        }
        int result = 0;
        int max = Math.max((left.length, right.length);
        for (int idx = max; idx > 0; --idx) {
            byte lft = 0;
            if (idx <= left.length) {
                lft = left[max - idx];
            }
            byte rht = 0;
            if (idx <= right.length) {
                rht = right[max - idx];
            }
            result = (int) lft - (int) rht;
            if (result != 0) {
                break;
            }
        }
        return Integer.signum(result);
    }
}
