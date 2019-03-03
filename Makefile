all: rocksdb libuv
	@g++ -O2 -std=c++11 $(FLAGS) \
		-DROCKSDB_VERSION="\"4.13"\" \
		-DSERVER_VERSION="\"0.1.0"\" \
		-DLIBUV_VERSION="\"1.10.1"\" \
		-Ithird_party/rocksdb/include/ \
		-Ithird_party/libuv/build/include/ \
		-pthread \
		-o rocksdb-server \
		src/server.cc src/client.cc src/exec.cc src/match.cc src/util.cc \
		third_party/rocksdb/librocksdb.a \
		third_partysrc/rocksdb/libbz2.a \
		third_party/rocksdb/libz.a \
		third_party/rocksdb/libsnappy.a \
		third_party/libuv/build/lib/libuv.a
clean:
	rm -f rocksdb-server
	rm -rf third_party/libuv/
	rm -rf third_party/rocksdb/
install: all
	cp rocksdb-server /usr/local/bin
uninstall: 
	rm -f /usr/local/bin/rocksdb-server

# libuv
libuv: third_party/libuv/build/lib/libuv.a
third_party/libuv/build/lib/libuv.a:
	cd third_party/libuv && sh autogen.sh
	mkdir -p third_party/libuv/build
	cd third_party/libuv/build && ../configure --prefix=$$(pwd)
	make -C third_party/libuv/build install

# rocksdb
rocksdb: third_party/rocksdb/librocksdb.a \
	third_party/rocksdb/libz.a \
	third_party/rocksdb/libbz2.a \
	third_party/rocksdb/libsnappy.a
third_party/rocksdb/librocksdb.a:
	DEBUG_LEVEL=0 make -C third_party/rocksdb static_lib
third_party/rocksdb/libz.a:
	DEBUG_LEVEL=0 make -C third_party/rocksdb libz.a
third_party/rocksdb/libbz2.a:
	DEBUG_LEVEL=0 make -C third_party/rocksdb libbz2.a
third_party/rocksdb/libsnappy.a:
	DEBUG_LEVEL=0 make -C third_party/rocksdb libsnappy.a

