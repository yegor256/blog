---
# SPDX-FileCopyrightText: Copyright (c) 2014-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

layout: post
title: "Sibit Demonstrates How Bitcoin Works"
date: 2019-05-07
place: Moscow, Russia
tags: crypto
description: |
  Bitcoin, despite all the mystery around Blockchain,
  is not so technically complex; here is a quick
  summary of how it works and how you can use it
  from the command line.
keywords:
  - bitcoin
  - bitcoin programmable
  - how bitcoin works
  - bitcoin
  - blockchain how works
image: /images/2019/05/the-invention-of-lying.jpg
jb_picture:
  caption: The Invention of Lying (2009) by Ricky Gervais et al.
---

{% badge https://raw.githubusercontent.com/yegor256/sibit/master/logo.svg?sanitize=true 64 https://github.com/yegor256/sibit %}

[Bitcoin](https://www.bitcoin.org) was a big technical mystery for me. All the articles I'd read
about it sounded extremely complex and absolutely indigestible. Until
I got stuck with a task: I had to integrate [Zold](https://www.zold.io), our
experimental non-Blockchain cryptocurrency, with Bitcoin. I had to study
the architecture of Bitcoin and I found this short and simple
[video](https://www.youtube.com/watch?v=IV9pRBq5A4g) (I highly recommend you
watch it). I managed to implement the integration and understand how
Blockchain works. Here is my short summary. I hope it will be helpful.

<!--more-->

{% jb_picture_body %}

First, there is a [private key](https://en.bitcoin.it/wiki/Private_key),
which is a short piece of text, for example:

```text
c93a36feb31712c390a78b37337cb85d45d3b2f9f6e55108bde32477cbabac5f
```

How did I generate it? It's random. You can generate one too. Install
[Sibit](https://github.com/yegor256/sibit), my Ruby gem, and run the following
(it's a command line tool):

```text
$ sibit generate
c93a36feb31712c390a78b37337cb85d45d3b2f9f6e55108bde32477cbabac5f
```

Every time you call `sibit generate` you will get a new private key. It is
just a random piece of text (well, a large hex number).
Then, you create an [address](https://en.bitcoin.it/wiki/Address)
from your private key. Each private key has exactly one address.
Here is how you create it:

```text
$ sibit create c93a36feb31712c390a78b37337cb85d45d3b2f9f6e55108bde32477cbabac5f
1K3JgsdRbbUDUgTGo4gvUXUzRZjBse1TYe
```

You give it to someone who wants to send you a payment. A transaction in Bitcoin is not what
you're used to thinking about when you imagine a bank transaction. A Bitcoin
[transaction](https://en.bitcoin.it/wiki/Transaction)
has a number of _input_ and _output_ addresses. Say, three inputs of 10 BTC each
and two outputs of 25 BTC and 5 BTC. The sum of all inputs must be equal to the
sum of all outputs.

Thus, in one transaction you can move a lot of digital money between addresses.
You can take a hundred input addresses and send them to another hundred
output addresses. This is what surprised me a bit when I discovered it. The
transactions could be pretty large in size. And the sizes matter. They are
calculated in bytes. A transaction with one input and one output will consume
[about](https://bitcoin.stackexchange.com/questions/1195/) 220 bytes.
Keep this number in mind, we will get back to it soon.

As you can imagine already, in order to calculate how much money you have
_on_ your address you just go through all the transactions in the entire
database (there are
[over 400 million](https://www.blockchain.com/en/charts/n-transactions-total) already)
and see how many transactions had your address as their outputs (your inputs). Then you
deduct any transactions that were your outputs and someone else's inputs. You get
the balance. There are many public and free web services which can do this
work for you. You don't need to search the entire database yourself,
just use [Blockchain API](https://www.blockchain.com/api/blockchain_api)
(for example) and they will provide you with the information
about any Bitcoin address. Try this address, for example:

```text
$ sibit balance 1MUhYhaBqzgpwL1focqJNhTymdXbyky9UY
20000000
```

It is in [satoshi](https://en.bitcoin.it/wiki/Satoshi_%28unit%29),
which is 0.2 BTC. Click [here](https://www.blockchain.com/btc/address/1MUhYhaBqzgpwL1focqJNhTymdXbyky9UY)
and you will
see the inputs and outputs of this address. There is only one transaction
that mentioned this address. That transaction had a single input and two
outputs. One of its outputs was mine. I got 0.2 bitcoins and they are still
here, since there are no transactions which _move_ them somewhere else.

Thus, simply put, the Blockchain database is a large list of transactions
with inputs and outputs in each of them. Once a new transaction gets into
this database, the balance of a few addresses change. The database only
grows and no previous transactions can be deleted or modified. Thus, once
your transaction gets in, the money is moved from address to address.

To create a transaction you need to know all the input addresses, their private keys,
and all the output addresses. You need multiple inputs if you want to send
an amount that is larger than you have in a single address. There is something
known as a [wallet](https://www.bitcoin.com/bitcoin-wallet-directory)
in Bitcoin, which is a piece of software, like [Electrum](https://electrum.org/), which keeps track of all your
addresses and knows how to create a transaction, combining a number of
addresses and using them as inputs. That's all.

So, you know the inputs, you specify the outputs and you are expected to leave a small amount
unspent. Let's say your inputs have 10,000 satoshi and you specify an output
for 8,000. You leave the residual 2,000 unspent. They are called
[miner fees](https://en.bitcoin.it/wiki/Miner_fees).
You send your transaction to all Bitcoin nodes, they place it in their
memory pool, and attempt to combine a few thousand transactions in a
[block](https://en.bitcoin.it/wiki/Block).
They all attempt together and only one of them manages to do it,
[approximately](https://bitcoin.stackexchange.com/questions/8823)
once every ten minutes. Once a winner manages to [solve](https://en.bitcoin.it/wiki/Mining)
a block, it wins that 2,000 you left untouched in your transaction. Every transaction in the
block pays that winner some small fee.

Is it possible to pay nothing?
[Yes](https://bitcointalk.org/index.php?topic=245552). However, the smaller the
fee you leave in your transaction, the lower the chances that your
transaction will go into the next block. Each miner wants to make the maximum
out of each block and puts the most "generous" transactions in the block,
when trying to [mine](https://en.bitcoin.it/wiki/Mining) it.

The fee depends on the size of the transaction in bytes. Since any transaction
may include many inputs and outputs, its size is the only thing that matters.
For example, the fee I paid in
[this transaction](https://www.blockchain.com/btc/tx/eede4bb2ad4e3c21a09cf238a282b08daab66937c726dce8fe07ab55793c4c51)
was 8,971 satoshi, which is approximately 40 satoshi per byte, since
my transaction included 225 bytes.

To send your transaction to all Bitcoin nodes you have two options. The first
one is to start your own [full node](https://en.bitcoin.it/wiki/Full_node),
which will communicate with
[other nodes](https://en.wikipedia.org/wiki/Bitcoin_network)
through the Bitcoin [protocol](https://en.bitcoin.it/wiki/Protocol_documentation).
The second option is to use one of the HTTP relays, where you
just post your transaction in a POST HTTP request and the relay sends it to all
Bitcoin nodes; [this is](https://www.blockchain.com/btc/pushtx) one of them.

[Sibit](https://github.com/yegor256/sibit) automates this process. You just say:

```text
$ sibit pay 200000 L \
  1K3J...se1TYe:c93a36feb3...e55108bde32477cbabac5f \
  153dF1xKyVX5X8brBDroaqKkPmcB8kLtDB \
  1K3JgsdRbbUDUgTGo4gvUXUzRZjBse1TYe
```

Here, the first argument is the amount you are sending. The second one
is the fee you want to leave untouched. I made it easier for you, to help
you avoid calculations. Just say `S`, `M`, `L` or `XL` and the fee will be calculated
more or less correctly. The third argument is a list of addresses
and their private keys, separated by a colon.
The fourth argument is the target address ([Sibit](https://github.com/yegor256/sibit)
makes it possible to send to only one address). The last argument is the
address where the [change](https://en.bitcoin.it/wiki/Change) will be sent.

If you have 50,000 satoshi in your inputs and you want to send 15,000 satoshi
to a friend, you have to find a place where the other 35,000 will be
sent---well, minus the miner fee. You just provide your own address and
the change will arrive there.

This is pretty much all you need to know about Bitcoin and Blockchain,
in order to use it. What did I miss?

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Do you understand how <a href="https://twitter.com/hashtag/Blockchain?src=hash&amp;ref_src=twsrc%5Etfw">#Blockchain</a> works?</p>&mdash; Yegor Bugayenko (@yegor256) <a href="https://twitter.com/yegor256/status/1193419019870715904?ref_src=twsrc%5Etfw">November 10, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
