/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

class Encrypted3 implements Encrypted {
    private String text;
    private final InputStream input;
    Encrypted3(InputStream stream) {
        this.text = null;
        this.input = stream;
    }
    Encrypted3(String txt) {
        this.text = txt;
        this.input = null;
    }
    @Override
    public String asString() throws IOException {
        if (this.text == null) {
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
        final byte[] in = this.text.getBytes();
        final byte[] out = new byte[in.length];
        for (int i = 0; i < in.length; ++i) {
            out[i] = (byte) (in[i] + 1);
        }
        return new String(out);
    }
}
