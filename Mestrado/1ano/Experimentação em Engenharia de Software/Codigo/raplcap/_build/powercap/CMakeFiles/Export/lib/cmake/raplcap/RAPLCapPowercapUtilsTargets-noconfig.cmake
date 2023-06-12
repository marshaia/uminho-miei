#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "RAPLCap::rapl-configure-powercap" for configuration ""
set_property(TARGET RAPLCap::rapl-configure-powercap APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(RAPLCap::rapl-configure-powercap PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/rapl-configure-powercap"
  )

list(APPEND _IMPORT_CHECK_TARGETS RAPLCap::rapl-configure-powercap )
list(APPEND _IMPORT_CHECK_FILES_FOR_RAPLCap::rapl-configure-powercap "${_IMPORT_PREFIX}/bin/rapl-configure-powercap" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
