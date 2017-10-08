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

class Encrypted3 implements Encrypted {
    private byte[] data;
    private final InputStream input;
    Encrypted3(InputStream stream) {
        this.data = null;
        this.input = stream;
    }
    Encrypted3(String txt) {
        this.data = txt.getBytes(StandardCharsets.UTF_8);
        this.input = null;
    }
    @Override
    public String asString() throws IOException {
        if (this.data == null) {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            while (true) {
                int one = input.read();
                if (one < 0) {
                    break;
                }
                baos.write(one);
            }
            this.data = baos.toByteArray();
        }
        final byte[] out = new byte[this.data.length];
        for (int i = 0; i < this.data.length; ++i) {
            out[i] = (byte) (this.data[i] + 1);
        }
        return new String(out, StandardCharsets.UTF_8);
    }
}
