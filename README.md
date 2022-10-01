Crypto Collectibles Series -
[Cats](https://github.com/cryptocopycats/market.mooncatrescue) ·
[Punks](https://github.com/cryptopunksnotdead/market.punks)


# Punks Market Data & (Research) Articles


## (Research) Articles

[**(Pixel) Apes & Monkeys (Chimps, Gorillas & Kongs) Art & Token (Sales) Timeline / Evolution**](apes)


## (Auto-Generated) Collection Reports from (Cached) Opensea Datasets

- [Collections Timeline (in Reverse Chronological Order)](COLLECTIONS.md)
- [Top Collections by All-Time Sales Volume (in Ξ)](TOP.md)
- [Trending Collections (in 30d/7d/1d Sales Volume)](TRENDING.md)


See the scripts in the /sandbox directory to update the (cached)
datasets via the opensea api and (re)generate the reports.




## Datasets

### Prices Dataset


All Matt & John's® punk sales tracked via the
blockchain recorded data from the `CryptoPunksMarket` contract
in comma-separated values (CSV) format.
One datafile for every day with transaction count
(in parenthesis)
and filed per month and year
(e.g. `2017/06/2017-06-23_(20)` or `2021/04/2021-04-12_(19)`).
Example:


```
timestamp,           id,   price (in eth), price (in wei)
2017-06-23 21:05:06, 544,  0.010000, 10000000000000000
2017-06-23 21:10:32, 3134, 0.010000, 10000000000000000
2017-06-23 21:46:53, 5056, 0.100000, 100000000000000000
...
```

Note: For more transactions details (incl. from, to, block, etc.) see the Sales Dataset (below).



### Sales Dateaset

All Matt & John's® punk sales tracked via the
blockchain recorded data from the `CryptoPunksMarket` contract
in comma-separated values (CSV) format.
One datafile for every day with transaction count
(in parenthesis)
and filed per month and year
(e.g. `2017/06/2017-06-23_(20)` or `2021/04/2021-04-12_(19)`).
Example:

```
timestamp,           id, price (in eth), price (in wei), from, to, block, tx
2017-06-23 21:05:06, 544, 0.010000, 10000000000000000, 0xc352b534..., 0x00000000..., 3919706, 0xb28b5f2...
2017-06-23 21:10:32, 3134, 0.010000, 10000000000000000, 0x5b098b00..., 0xc352b534..., 3919721, 0x65579455...
2017-06-23 21:46:53, 5056, 0.100000, 100000000000000000, 0xc352b534e..., 0x00bd9fd5..., 3919847, 0xd79cca92...
...
```





### Your Tool Here

Do you have a tool for the punks dataset? Let us know! Add your tool here.




## License

![](https://publicdomainworks.github.io/buttons/zero88x31.png)

The punks dataset
is dedicated to the public domain.
Use it as you please with no restrictions whatsoever.



## Questions? Comments?

Post them on the [D.I.Y. Punk (Pixel) Art reddit](https://old.reddit.com/r/DIYPunkArt). Thanks.

