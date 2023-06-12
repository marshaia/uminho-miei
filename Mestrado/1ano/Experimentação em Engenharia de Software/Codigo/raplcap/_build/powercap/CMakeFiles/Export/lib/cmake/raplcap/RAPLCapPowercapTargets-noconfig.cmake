#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "RAPLCap::raplcap-powercap" for configuration ""
set_property(TARGET RAPLCap::raplcap-powercap APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(RAPLCap::raplcap-powercap PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "C"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libraplcap-powercap.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS RAPLCap::raplcap-powercap )
list(APPEND _IMPORT_CHECK_FILES_FOR_RAPLCap::raplcap-powercap "${_IMPORT_PREFIX}/lib/libraplcap-powercap.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
