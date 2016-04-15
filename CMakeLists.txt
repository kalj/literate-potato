CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

FIND_PACKAGE(CUDA)

#------------------------------------------------------------------------------
# sub library
#------------------------------------------------------------------------------

SET(sources test.cu junk.cc)


FOREACH(_build dbg rel)

  CUDA_ADD_CUDA_INCLUDE_ONCE()

  # Add the library.
  ADD_LIBRARY( strunt.${_build} OBJECT  ${sources} )

  # Create custom commands and targets for each file.
  CUDA_WRAP_SRCS( finallib.${_build} OBJ generated_files ${sources} SHARED)

  SET_PROPERTY(GLOBAL APPEND PROPERTY ALLOBJS_${_build}
    "$<TARGET_OBJECTS:strunt.${_build}>"
    "${generated_files}"
    )
ENDFOREACH()

#------------------------------------------------------------------------------
# main library
#------------------------------------------------------------------------------

FOREACH(_build dbg rel)

  GET_PROPERTY(_objects GLOBAL PROPERTY ALLOBJS_${_build})

  FOREACH(_object ${_objects})
    IF("${_object}" MATCHES "cu.o$")
      SET_SOURCE_FILES_PROPERTIES("${_object}"
        PROPERTIES
        EXTERNAL_OBJECT TRUE
        GENERATED TRUE
        )
    ENDIF()
  ENDFOREACH()

  ADD_LIBRARY(finallib.${_build} SHARED finallib.cc ${_objects})

ENDFOREACH()
