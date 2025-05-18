/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */

final class Encrypted1 implements Encrypted {
    private final String text;
    Encrypted1(String txt) {
        this.text = txt;
    }
    @Override
    public String asString() {
        final byte[] in = this.text.getBytes();
        final byte[] out = new byte[in.length];
        for (int i = 0; i < in.length; ++i) {
            out[i] = (byte) (in[i] + 1);
        }
        return new String(out);
    }
}
