/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */
final class Text implements Digitizable {
    private final String txt;
    Text(String t) {
        this.txt = t;
    }
    public byte[] digits() {
        return this.txt.getBytes();
    }
}
