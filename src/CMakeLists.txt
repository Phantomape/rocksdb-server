cmake_minimum_required(VERSION 3.4)

project(RocksDBServer VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)

# Premium-calculator app (with advanced functionality) target_link_libraries( PremiumCalculator
# PRIVATE MyCalc::extmath Boost::program_options )
#
# # Possibly, compile key-file into premium-calculator, too. if (EXISTS
# "${CMAKE_CURRENT_SOURCE_DIR}/src/key-file.cpp") target_sources( PremiumCalculator PRIVATE "src
# /key-file.cpp" ) endif ()

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
