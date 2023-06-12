
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was Config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

####################################################################################

include(${CMAKE_CURRENT_LIST_DIR}/PowercapTargets.cmake)

set(_${CMAKE_FIND_PACKAGE_NAME}_supported_components Utils)
foreach(_comp ${${CMAKE_FIND_PACKAGE_NAME}_FIND_COMPONENTS})
  if(NOT _comp IN_LIST _${CMAKE_FIND_PACKAGE_NAME}_supported_components)
    set(${CMAKE_FIND_PACKAGE_NAME}_FOUND False)
    set(${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE "Unsupported component: ${_comp}")
  elseif(EXISTS "${CMAKE_CURRENT_LIST_DIR}/${CMAKE_FIND_PACKAGE_NAME}${_comp}Targets.cmake")
    include("${CMAKE_CURRENT_LIST_DIR}/${CMAKE_FIND_PACKAGE_NAME}${_comp}Targets.cmake")
    set(${CMAKE_FIND_PACKAGE_NAME}_${_comp}_FOUND True)
  else()
    set(${CMAKE_FIND_PACKAGE_NAME}_${_comp}_FOUND False)
    if(${CMAKE_FIND_PACKAGE_NAME}_FIND_REQUIRED_${_comp})
      set(${CMAKE_FIND_PACKAGE_NAME}_FOUND False)
      set(${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE "Component not found: ${_comp}")
    endif()
  endif()
endforeach()
unset(_${CMAKE_FIND_PACKAGE_NAME}_supported_components)
