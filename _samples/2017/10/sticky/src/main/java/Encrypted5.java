/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import org.cactoos.Scalar;
import org.cactoos.scalar.IoCheckedScalar;
import org.cactoos.scalar.StickyScalar;

class Encrypted5 implements Encrypted {
    private final IoCheckedScalar<String> text;
    Encrypted5(InputStream stream) {
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
    Encrypted5(String txt) {
        this(() -> txt);
    }
    Encrypted5(Scalar<String> source) {
        this.text = new IoCheckedScalar<>(new StickyScalar<>(source));
    }
    @Override
    public String asString() throws IOException {
        final byte[] input = this.text.value().getBytes();
        final byte[] out = new byte[input.length];
        for (int i = 0; i < input.length; ++i) {
            out[i] = (byte) (input[i] + 1);
        }
        return new String(out, StandardCharsets.UTF_8);
    }
}
