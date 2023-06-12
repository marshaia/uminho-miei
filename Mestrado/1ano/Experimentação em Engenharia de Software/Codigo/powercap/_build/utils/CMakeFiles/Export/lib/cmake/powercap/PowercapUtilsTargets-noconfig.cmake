#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Powercap::powercap-info" for configuration ""
set_property(TARGET Powercap::powercap-info APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Powercap::powercap-info PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/powercap-info"
  )

list(APPEND _IMPORT_CHECK_TARGETS Powercap::powercap-info )
list(APPEND _IMPORT_CHECK_FILES_FOR_Powercap::powercap-info "${_IMPORT_PREFIX}/bin/powercap-info" )

# Import target "Powercap::powercap-set" for configuration ""
set_property(TARGET Powercap::powercap-set APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(Powercap::powercap-set PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/bin/powercap-set"
  )

list(APPEND _IMPORT_CHECK_TARGETS Powercap::powercap-set )
list(APPEND _IMPORT_CHECK_FILES_FOR_Powercap::powercap-set "${_IMPORT_PREFIX}/bin/powercap-set" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
