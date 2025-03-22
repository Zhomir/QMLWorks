# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appQMLayouts_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appQMLayouts_autogen.dir\\ParseCache.txt"
  "appQMLayouts_autogen"
  )
endif()
