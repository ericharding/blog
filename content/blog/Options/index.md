+++
title="Efficient Load Shedding for Options Market Data"
date=2020-03-20
[taxonomies]
tags=[".NET", "F#"]
+++

Handling financial data from an exchange is a fascinating problem.  The data from a single exchange can include tens of thousands of updates every second typically in the form of UDP multicast.  Access to the real-time feed can cost thousands of dollars but data becomes near worthless seconds (or fractions of a second) after transmission.

<!-- more -->

## Conventional Wisdom

The conventional wisdom around processing market data mostly involves very fast single producer queues.  In particular the [LMAX Disruptor](https://lmax-exchange.github.io/disruptor/) has garnered some attention in the last few years for how they use large fixed size buffers to make extremely fast queues for moving market data across threads.  At [Blue Trading Systems](https://www.bluetradingsystems.com/) I introduced an alternative solution which has served our needs very well over the last few years.

## Background

First some background on what a derivatives exchange feed looks like. If you're already familiar with how this works you can [skip ahead to the next section](#requirements).

Each tradeable product (known as a security or an instrument) at an exchange has a symbol in the same way that a stock does. Unlike a stock each future or option has an [expiration (or maturation) date](https://www.investopedia.com/terms/m/maturitydate.asp) associated with it which is when the future or option can be traded of its underlying product. 

Each product has a separate set of bids and offers that traders have submitted to the exchange.  The set of bids and offers for a particular security is called the book.  Typically the bids and offers at a particular price are summed to produce a total size available to trade at each price and visualized as a trading "ladder" with a central column of prices and the quantity available to trade on the left or right side depending whether it is an offer to buy (bid) or sell (ask).  Any time there is a bid and an offer at the same price the exchange matching engine matches the orders and a trade occurs.

<img src="ladder.png" width="150" />

At the start of the day or when the software boots up it subscribes to a cycling feed which contains the latest "snapshot" of the books as of a specific moment time for every security at the exchange. The software also joins an incremental feed which is publishing the changes to the books in real time as orders arrive and matches occur.  The software will buffer the incremental updates until there is an overlap between the snapshot and the buffered feed and then it can begin applying the incremental updates to the snapshot and maintain the current state of the book for each product using only the incremental feed.

Futures and options are often lumped together in the same breath and use the same format for data distribution from the exchange. However, because an option includes both an expiration date and a [strike price](https://www.investopedia.com/terms/s/strikeprice.asp) there are an order of magnitude (thousands vs hundreds) more option securities for any given symbol.  Since there are so many more options the [depth of the book](https://www.investopedia.com/terms/d/depth-of-market.asp) (The number of outstanding buy and sell orders) tends to be smaller. Because of these differences in the data option expirations are typically visualized differently in trading software.

<image src="sheets.png" width="584" />

Here is an example of a single option expiration with [calls](https://www.investopedia.com/terms/c/calloption.asp) and [puts](https://www.investopedia.com/terms/p/put.asp) straddling a dark blue column with the [strike price](https://www.investopedia.com/terms/s/strikeprice.asp).  Each row shows only the best bid and offer for a single security at the exchange.


## Requirements

At BTS there are two classes of market data consumer. Machines and humans. While each class of consumer has very different needs in terms of latency they do share one very important similarity.  They *never* want to see stale data.


## Tools
* spin locks
    * bad
* Strongly ordered memory access guarantee (intel)
* Cache Lines
* atomic instructions

## Pro/Con

### Pro
* Always the latest value
* Consumer rate limited

### Con
* Recording
* What happened first


