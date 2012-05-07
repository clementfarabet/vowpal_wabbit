
CMAKE_MINIMUM_REQUIRED(VERSION 2.6 FATAL_ERROR)
CMAKE_POLICY(VERSION 2.6)
FIND_PACKAGE(Torch REQUIRED)
  
include_directories (${TORCH_INCLUDE_DIR} ${PROJECT_SOURCE_DIR})

SET(src init.cpp allreduce.cc)
SET(luasrc init.lua)

ADD_TORCH_PACKAGE(allreduce "${src}" "${luasrc}" "Parallel Computing")
TARGET_LINK_LIBRARIES(allreduce luaT TH)

add_executable(allserver cluster/spanning_tree.cc)

install(TARGETS allserver
  RUNTIME DESTINATION bin
)
