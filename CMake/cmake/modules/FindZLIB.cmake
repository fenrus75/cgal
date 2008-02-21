# Try to find the ZLIB libraries
# ZLIB_FOUND - system has ZLIB lib
# ZLIB_INCLUDE_DIR - the ZLIB include directory
# ZLIB_LIBRARIES_DIR - Directory where the ZLIB libraries are located
# ZLIB_LIBRARIES - the ZLIB libraries
# ZLIB_IN_AUXILIARY - TRUE if the ZLIB found is the one distributed with CGAL in the auxiliary folder

# TODO: support MacOSX

include(FindPackageHandleStandardArgs)
include(GeneratorSpecificSettings)

# Is it already configured?
if (ZLIB_INCLUDE_DIR AND ZLIB_LIBRARIES ) 
   
  set(ZLIB_FOUND TRUE)
  
else()  

  # Look first for the ZLIB distributed with CGAL in auxiliary/zlib
  find_path(ZLIB_INCLUDE_DIR 
            NAMES zlib.h 
            PATHS ${CGAL_SOURCE_DIR}/auxiliary/zlib/include
                  ENV ZLIB_INC_DIR
  	        DOC "The directory containing the ZLIB header files"
           )

  if ( ZLIB_INCLUDE_DIR ) 

     if ( ZLIB_INCLUDE_DIR STREQUAL "${CGAL_SOURCE_DIR}/auxiliary/zlib/include" )
       set( ZLIB_IN_CGAL_AUXILIARY TRUE )
       set( ZLIB_LIB_SEARCH_PATHS ${CGAL_SOURCE_DIR}/auxiliary/gmp/lib )
     endif()
     
    set( ZLIB_NAMES zlib z zdll )
    
    find_library(ZLIB_LIBRARIES 
                 NAMES ${ZLIB_NAMES} 
                 PATHS ${ZLIB_LIB_SEARCH_PATHS}
                       ENV ZLIB_LIB_DIR
                 DOC "Path to the ZLIB library"
                )
     
    if ( ZLIB_LIBRARIES ) 
      get_filename_component(ZLIB_LIBRARIES_DIR ${ZLIB_LIBRARIES} PATH)
    endif()
    
  endif()  
  
  # Attempt to load a user-defined configuration for ZLIB if couldn't be found
  if ( NOT ZLIB_INCLUDE_DIR OR NOT ZLIB_LIBRARIES )
    include( ZLIBConfig OPTIONAL )
  endif()
  
  FIND_PACKAGE_HANDLE_STANDARD_ARGS(ZLIB "DEFAULT_MSG" ZLIB_INCLUDE_DIR ZLIB_LIBRARIES)
  
endif()


