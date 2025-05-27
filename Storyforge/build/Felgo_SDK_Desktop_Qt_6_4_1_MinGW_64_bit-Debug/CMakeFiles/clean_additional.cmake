# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appStoryforge_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appStoryforge_autogen.dir\\ParseCache.txt"
  "appStoryforge_autogen"
  )
endif()
