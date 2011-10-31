cmake_minimum_required(VERSION 2.8)

set (CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})

# infer path for Torch7
string (REGEX REPLACE "(.*)lib/luarocks/rocks.*" "\\1" TORCH_PREFIX "${CMAKE_INSTALL_PREFIX}" )
message (STATUS "Found Torch7, installed in: " ${TORCH_PREFIX})
  
find_package (Torch REQUIRED)
SET(INSTALL_PREFIX /lua/allreduce)
SET(CINSTALL_PREFIX /lib)

set (CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

include_directories (${TORCH_INCLUDE_DIR} ${PROJECT_SOURCE_DIR})

include_directories (${TORCH_INCLUDE_DIR} ${PROJECT_SOURCE_DIR})
add_library (allreduce SHARED init.cpp allreduce.cc)
link_directories (${TORCH_LIBRARY_DIR})
target_link_libraries (allreduce ${TORCH_LIBRARIES} )

install_files(${INSTALL_PREFIX} init.lua)
install_targets(${CINSTALL_PREFIX} allreduce)
