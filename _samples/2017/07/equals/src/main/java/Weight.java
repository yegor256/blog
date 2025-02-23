/**
 * SPDX-FileCopyrightText: Copyright (c) 2017 Yegor Bugayenko
 * SPDX-License-Identifier: MIT
 */
import java.nio.ByteBuffer;

final class Weight implements Digitizable {
  private final int kilos;
  Weight(int k) {
    this.kilos = k;
  }
  public byte[] digits() {
    return ByteBuffer.allocate(4).putInt(this.kilos).array();
  }
}
