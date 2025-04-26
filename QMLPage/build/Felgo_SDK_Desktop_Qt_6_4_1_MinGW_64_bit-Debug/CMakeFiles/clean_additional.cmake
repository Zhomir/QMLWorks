# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appQMLPage_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appQMLPage_autogen.dir\\ParseCache.txt"
  "appQMLPage_autogen"
  )
endif()
