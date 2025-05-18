/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
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
        int result = 0;
        int max = Math.max(left.length, right.length);
        for (int idx = max; idx > 0; --idx) {
            byte lft = 0;
            if (idx <= left.length) {
                lft = left[max - idx];
            }
            byte rht = 0;
            if (idx <= right.length) {
                rht = right[max - idx];
            }
            result = lft - rht;
            if (result != 0) {
                break;
            }
        }
        return (int) Math.signum(result);
    }
}
