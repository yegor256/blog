/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import org.cactoos.Scalar;
import org.cactoos.scalar.IoCheckedScalar;

class Encrypted4 implements Encrypted {
    private final IoCheckedScalar<String> text;
    Encrypted4(InputStream stream) {
        this(
            () -> {
                ByteArrayOutputStream baos =
                    new ByteArrayOutputStream();
                while (true) {
                    int one = stream.read();
                    if (one < 0) {
                        break;
                    }
                    baos.write(one);
                }
                return new String(baos.toByteArray());
            }
        );
    }
    Encrypted4(String txt) {
        this(() -> txt);
    }
    Encrypted4(Scalar<String> source) {
        this.text = new IoCheckedScalar<>(source);
    }
    @Override
    public String asString() throws IOException {
        final byte[] in = this.text.value().getBytes();
        final byte[] out = new byte[in.length];
        for (int i = 0; i < in.length; ++i) {
            out[i] = (byte) (in[i] + 1);
        }
        return new String(out);
    }
}
