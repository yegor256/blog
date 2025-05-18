/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */
class AbcComparison<T extends Digitizable> {
    private T lt;
    private T rt;
    AbcComparison(T left, T right) {
        this.lt = left;
        this.rt = right;
    }
    int value() {
        final byte[] left = this.lt.digits();
        final byte[] right = this.rt.digits();
        final int max = Math.max(left.length, right.length);
        final byte[] la = new byte[max];
        System.arraycopy(left, 0, la, 0, left.length);
        final byte[] ra = new byte[max];
        System.arraycopy(right, 0, ra, 0, right.length);
        return new Comparison<Array>(new Array(la), new Array(ra)).value();
    }
}
