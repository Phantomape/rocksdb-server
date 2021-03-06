# RocksDB-Server

[Fast](#benchmarks) and simple [Redis](https://redis.io/) clone written in C using [RocksDB](http://rocksdb.org/) as a backend.

## Initiative

My company uses RocksDB to persist data. Unfortunately, we don't have any handy tool to query or visualize the database. All we have is a flaky C++ script that does not work at all, the code of which is so poorly written that I don't want to get down to the bottom of why it doesn't work. I want a handy tool like redis client to access the database(mostly because I'm quite familiar with redis).

## Engineering Roadmap

* Replace rocksdb with git submodule(Done)
* Replace libuv with git submodule(Done)
* Switch to CMake + Ninja
* Use clang-tidy: https://segmentfault.com/a/1190000007610205, https://clang.llvm.org/docs/JSONCompilationDatabase.html
* Support thrift deserialization
* Support more redis commands

## Supported commands

```bash
SET key value
GET key
DEL key
KEYS *
SCAN cursor [MATCH pattern] [COUNT count]
FLUSHDB
```

Any [Redis client](https://redis.io/clients) should work.

## Building

Tested on Mac and Linux (Ubuntu), though should work on other platforms.
Please let me know if you run into build problems.

Requires `libtool` and `automake`.

Ubuntu users:

```bash
apt-get install build-esstential libtool automake
```

To build everything simply:

```bash
make
```

## Running

```bash
usage: ./rocksdb-server [-d data_path] [-p tcp_port] [--sync] [--inmem]
```

* `-d`      -- The database path. Default `./data/`
*`-p`      -- TCP server port. Default 5555.
* `--inmem` -- The active dataset is stored in memory.
* `--sync`  -- Execute fsync after every SET. More durable, but much slower.

## Benchmarks

### Redis

```bash
redis-server
```

```bash
redis-benchmark -p 6379 -t set,get -n 10000000 -q -P 256 -c 256
SET: 947867.38 requests per second
GET: 1394700.12 requests per second
```

### RocksDB

```bash
rocksdb-server
```

```bash
redis-benchmark -p 5555 -t set,get -n 10000000 -q -P 256 -c 256
SET: 419815.28 requests per second
GET: 2132196.00 requests per second
```

Running on a MacBook Pro 15" 2.8 GHz Intel Core i7 using Go 1.7

## Contact

Josh Baker [@tidwall](http://twitter.com/tidwall)

## License

RocksDB-Server source code is available under the MIT [License](/LICENSE).
