import java.math.BigInteger;

/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */
final class BigNumber implements Digitizable {
    private final BigInteger num;
    BigNumber(BigInteger n) {
        this.num = n;
    }
    public byte[] digits() {
        return this.num.toByteArray();
    }
}
