# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appQML_3_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appQML_3_autogen.dir\\ParseCache.txt"
  "appQML_3_autogen"
  )
endif()
