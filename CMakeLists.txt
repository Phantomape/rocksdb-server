cmake_minimum_required(VERSION 3.4)

project(RocksDBServer VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)

find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${PROJECT_SOURCE_DIR}/.git")
    # Update submodules as needed
    option(GIT_SUBMODULE "Check submodules during build" ON)
    if(GIT_SUBMODULE)
        message(STATUS "Submodule update")
        execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
                        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                        RESULT_VARIABLE GIT_SUBMOD_RESULT)
        if(NOT GIT_SUBMOD_RESULT EQUAL "0")
            message(
                FATAL_ERROR
                    "git submodule update --init failed with ${GIT_SUBMOD_RESULT}, please checkout submodules"
                )
        endif()
    endif()
endif()

if(NOT EXISTS "${PROJECT_SOURCE_DIR}/third_party/libuv/CMakeLists.txt")
    message(
        FATAL_ERROR
            "The lib uv submodules were not downloaded! GIT_SUBMODULE was turned off or failed. Please update submodules and try again."
        )
endif()

if(CMAKE_VERSION VERSION_GREATER 3.4)
    # Add clang-tidy if available
    option(CLANG_TIDY_FIX "Perform fixes for Clang-Tidy" OFF)
    find_program(CLANG_TIDY_EXE NAMES "clang-tidy" DOC "Path to clang-tidy executable")

    # The following lines would produce too much noise
    if(CLANG_TIDY_EXE)
        if(CLANG_TIDY_FIX)
            set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE}" "-fix")
        else()
            set(CMAKE_CXX_CLANG_TIDY "${CLANG_TIDY_EXE}")
        endif()
    endif()
endif()

option(PACKAGE_TESTS "Build the tests" ON)
if(PACKAGE_TESTS)
    enable_testing()
    add_subdirectory(tests)
endif()

add_subdirectory(src)

add_subdirectory(third_party/libuv)
add_subdirectory(third_party/rocksdb)
add_subdirectory(third_party/thrift)
