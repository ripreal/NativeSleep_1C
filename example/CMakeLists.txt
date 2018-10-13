# Cmake script for project AddIn
# autor: 1C
cmake_minimum_required (VERSION 2.6)
project (AddIn)

message(STATUS "System: " ${CMAKE_SYSTEM_NAME} " " ${CMAKE_SYSTEM_VERSION})
message(STATUS "Processor: " ${CMAKE_HOST_SYSTEM_PROCESSOR})

if (UNIX)
    set(MySuffix1 "Lin")
    if (APPLE)
        set(MySuffix1 "Mac")
    endif(APPLE)
else(UNIX)
    set(MySuffix1 "Win")
endif(UNIX)

set(BUILD_DIR "build")
set(CMAKE_SKIP_RPATH ON CACHE TYPE BOOL)

OPTION(TARGET_PLATFORM_32 "Build target for i386" OFF)
MARK_AS_ADVANCED(TARGET_PLATFORM_32)

if (TARGET_PLATFORM_32)
    set(MySuffix2 "32")
    set (CMAKE_CXX_FLAGS  ${CMAKE_CXX_FLAGS} "-m32")
    set (CMAKE_C_FLAGS  ${CMAKE_C_FLAGS} "-m32")
else()
    set(MySuffix2 "64")
    set (CMAKE_CXX_FLAGS  ${CMAKE_CXX_FLAGS} "-m64")
    set (CMAKE_C_FLAGS  ${CMAKE_C_FLAGS} "-m64")
endif()

set (LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/bin)
set (EXECUTABLE_OUTPUT_PATH ${LIBRARY_OUTPUT_PATH})

include_directories(BEFORE  . ${CMAKE_SOURCE_DIR}../include)

add_subdirectory (NativeAPI)
if (NOT APPLE)
    add_subdirectory (AddInChrome)
endif()

if (WIN32)
    add_subdirectory(AddInIE)
endif (WIN32)
