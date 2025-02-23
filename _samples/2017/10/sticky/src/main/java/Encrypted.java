import java.io.IOException;

/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */
interface Encrypted {
    String asString() throws IOException;
}
