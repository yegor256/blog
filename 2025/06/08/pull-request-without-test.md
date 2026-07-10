# Write Unit Tests, Don't Waste Our Money!

Source: https://www.yegor256.com/2025/06/08/pull-request-without-test.html

Automated tests help us write code [faster](/angry-tests.html).
Unit tests immediately [tell us]({% pst 2022/jul/2022-07-05-safety-net %}) when we break something.
Integration tests calm us down, reducing the fear of shipping a failure to a user.
But who are "us"?
Programmers.
What about our employers?
How do automated tests help them?
Automated tests protect their **investments**.


{% jb_picture_body %}

Every change we make to a codebase costs our employer money.
Whether they pay us [monthly]({% pst 2015/jul/2015-07-21-hourly-pay-modern-slavery %})
  or [per line of code]({% pst 2014/apr/2014-04-11-cost-of-loc %}), the bottom line is the same:
  it's the code that reaches the repository and is eventually released to the end user.

That's what the business is investing in---new features [or]({% pst 2018/jul/2018-07-24-bugs-or-pull-requests %}) bug fixes.
The code that's written and shipped is what matters to them.

Even when they say they're investing in people, what they really want is the code.
People are merely an intermediate by-product.
The ultimate asset is the codebase.

They want to **protect** that **asset**.

A loss of investment could be a hundred lines written today not working tomorrow.
Think about it this way: we expect a car to work after paying the body shop to fix it.
We don't mind paying again if something else breaks---but not if it's the exact same part they fixed yesterday.
We expect the repaired part to function properly while driving.
We want a warranty on what's already been fixed.

{% quote People are merely an intermediate by-product---the ultimate asset is the codebase %}

Similarly, our employers expect our code to work once we've committed it and collected our paycheck.
They want a warranty that the code won't break again once it's been fixed.
Automated tests can offer that **warranty**.

Continuing the metaphor: "driving" a codebase means actively modifying its parts---refactoring or extending.
The more aggressively we drive it, the higher the risk of breaking something.
The parts of the code not covered by tests are the first to break.

Test coverage guarantees that what worked before---and was already paid for---continues to work even under the stress of refactoring.

So, any contribution to a codebase without a **supporting** test is a waste of the employer's money.
