CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

FIND_PACKAGE(CUDA)

#------------------------------------------------------------------------------
# sub library
#------------------------------------------------------------------------------

CUDA_ADD_CUDA_INCLUDE_ONCE()

# Create custom commands and targets for each file.
set(sources test.cu junk.cc)
CUDA_WRAP_SRCS( strunt OBJ generated_files ${sources})

message("generated files: " ${generated_files})

# Add the library.
ADD_LIBRARY(strunt OBJECT  ${sources} )
SET_PROPERTY(GLOBAL APPEND PROPERTY ALLOBJS
  "$<TARGET_OBJECTS:strunt>"
  "${_generated_cuda_files}"
  )

#------------------------------------------------------------------------------
# main library
#------------------------------------------------------------------------------

GET_PROPERTY(_objects GLOBAL PROPERTY ALLOBJS)
ADD_LIBRARY(finallib finallib.cc ${_objects})
