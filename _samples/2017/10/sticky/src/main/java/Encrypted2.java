/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

final class Encrypted2 implements Encrypted {
    private final String text;
    Encrypted2(final InputStream input) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        while (true) {
            int one = input.read();
            if (one < 0) {
                break;
            }
            baos.write(one);
        }
        this.text = new String(baos.toByteArray());
    }
    Encrypted2(final String txt) {
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
