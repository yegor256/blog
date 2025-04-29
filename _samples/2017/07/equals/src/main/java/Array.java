/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */
final class Array implements Digitizable {
    private final byte[] data;
    Array(byte[] array) {
        this.data = array;
    }
    public byte[] digits() {
        return this.data;
    }
}
