cmake_minimum_required(VERSION 3.4)

project(RocksDBServer VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)

add_executable(rocksdb-server)
target_sources(rocksdb-server
               PRIVATE
               "server.cc"
               "client.cc"
               "exec.cc"
               "match.cc"
               "util.cc"
               PUBLIC
               "${CMAKE_CURRENT_SOURCE_DIR}/../include/server.h")
target_include_directories(rocksdb-server PRIVATE ../include)
target_include_directories(rocksdb-server PRIVATE ../third_party/libuv/include)
target_include_directories(rocksdb-server PRIVATE ../third_party/rocksdb/include)

add_definitions(-DROCKSDB_VERSION=\"5.8\" -DLIBUV_VERSION=\"1.26.0\" -DSERVER_VERSION=\"1.0.0\")

target_link_libraries(rocksdb-server uv rocksdb thrift)
