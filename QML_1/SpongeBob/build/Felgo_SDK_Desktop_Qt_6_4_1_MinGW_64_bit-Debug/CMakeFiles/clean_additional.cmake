# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appSpongeBob_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appSpongeBob_autogen.dir\\ParseCache.txt"
  "appSpongeBob_autogen"
  )
endif()
