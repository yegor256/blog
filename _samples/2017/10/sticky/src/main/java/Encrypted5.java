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

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import org.cactoos.Scalar;
import org.cactoos.scalar.IoCheckedScalar;
import org.cactoos.scalar.StickyScalar;

class Encrypted5 implements Encrypted {
    private final IoCheckedScalar<byte[]> data;
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
                return baos.toByteArray();
            }
        );
    }
    Encrypted5(String txt) {
        this(() -> txt.getBytes(StandardCharsets.UTF_8));
    }
    Encrypted5(Scalar<byte[]> source) {
        this.data = new IoCheckedScalar<>(new StickyScalar<>(source));
    }
    @Override
    public String asString() throws IOException {
        final byte[] input = this.data.value();
        final byte[] out = new byte[input.length];
        for (int i = 0; i < input.length; ++i) {
            out[i] = (byte) (input[i] + 1);
        }
        return new String(out, StandardCharsets.UTF_8);
    }
}
