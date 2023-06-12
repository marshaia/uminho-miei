#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Powercap::powercap" for configuration ""
set_property(TARGET Powercap::powercap APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Powercap::powercap PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "C"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libpowercap.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS Powercap::powercap )
list(APPEND _IMPORT_CHECK_FILES_FOR_Powercap::powercap "${_IMPORT_PREFIX}/lib/libpowercap.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
