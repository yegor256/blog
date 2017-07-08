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
class Main {
  public static void main(String... args) {
    claim(new Comparison<Weight>(new Weight(1), new Weight(1)).value() == 0);
    claim(new Comparison<Weight>(new Weight(586774), new Weight(586773)).value() == 1);
    claim(new Comparison<Text>(new Text("friend"), new Text("friend")).value() == 0);
    claim(new Comparison<Text>(new Text(""), new Text("oops")).value() == 1);
    claim(new Comparison<Text>(new Text("hey, boy"), new Text("hey, girl")).value() == -1);
  }
  private static void claim(boolean stmt) {
    if (!stmt) {
      throw new AssertionError("failed");
    }
  }
}
