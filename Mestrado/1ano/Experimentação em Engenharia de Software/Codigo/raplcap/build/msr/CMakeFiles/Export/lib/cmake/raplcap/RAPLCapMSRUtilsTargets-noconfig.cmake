#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "RAPLCap::rapl-configure-msr" for configuration ""
set_property(TARGET RAPLCap::rapl-configure-msr APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(RAPLCap::rapl-configure-msr PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/rapl-configure-msr"
  )

list(APPEND _IMPORT_CHECK_TARGETS RAPLCap::rapl-configure-msr )
list(APPEND _IMPORT_CHECK_FILES_FOR_RAPLCap::rapl-configure-msr "${_IMPORT_PREFIX}/bin/rapl-configure-msr" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
