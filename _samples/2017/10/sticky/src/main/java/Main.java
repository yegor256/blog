import java.io.IOException;

/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */
class Main {
    public static void main(String... args) throws IOException {
        final String input = "Hello, world!";
        final String output = "Ifmmp-!xpsme\"";
        Main.compare(new Encrypted1(input).asString(), output);
        Main.compare(new Encrypted2(input).asString(), output);
        Main.compare(new Encrypted3(input).asString(), output);
        Main.compare(new Encrypted4(input).asString(), output);
        Main.compare(new Encrypted5(input).asString(), output);
    }
    private static void compare(String first, String second) {
        if (!first.equals(second)) {
            throw new IllegalArgumentException(
                String.format("\"%s\" not equal to \"%s\"", first, second)
            );
        }
    }
}
