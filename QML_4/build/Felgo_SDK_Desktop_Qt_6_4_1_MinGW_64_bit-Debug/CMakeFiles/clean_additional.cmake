# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appQML_4_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appQML_4_autogen.dir\\ParseCache.txt"
  "appQML_4_autogen"
  )
endif()
