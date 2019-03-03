all: rocksdb libuv
	@g++ -O2 -std=c++11 $(FLAGS) \
		-DROCKSDB_VERSION="\"4.13"\" \
		-DSERVER_VERSION="\"0.1.0"\" \
		-DLIBUV_VERSION="\"1.10.1"\" \
		-Isrc/rocksdb-4.13/include/ \
		-Isrc/libuv-1.10.1/build/include/ \
		-pthread \
		-o rocksdb-server \
		src/server.cc src/client.cc src/exec.cc src/match.cc src/util.cc \
		src/rocksdb-4.13/librocksdb.a \
		src/rocksdb-4.13/libbz2.a \
		src/rocksdb-4.13/libz.a \
		src/rocksdb-4.13/libsnappy.a \
		src/libuv-1.10.1/build/lib/libuv.a
clean:
	rm -f rocksdb-server
	rm -rf src/libuv-1.10.1/
	rm -rf src/rocksdb-4.13/
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
rocksdb: src/rocksdb-4.13 \
	src/rocksdb-4.13/librocksdb.a \
	src/rocksdb-4.13/libz.a \
	src/rocksdb-4.13/libbz2.a \
	src/rocksdb-4.13/libsnappy.a
src/rocksdb-4.13:
	cd src && tar xf rocksdb-4.13.tar.gz
src/rocksdb-4.13/librocksdb.a:
	DEBUG_LEVEL=0 make -C src/rocksdb-4.13 static_lib
src/rocksdb-4.13/libz.a:
	DEBUG_LEVEL=0 make -C src/rocksdb-4.13 libz.a
src/rocksdb-4.13/libbz2.a:
	DEBUG_LEVEL=0 make -C src/rocksdb-4.13 libbz2.a
src/rocksdb-4.13/libsnappy.a:
	DEBUG_LEVEL=0 make -C src/rocksdb-4.13 libsnappy.a

