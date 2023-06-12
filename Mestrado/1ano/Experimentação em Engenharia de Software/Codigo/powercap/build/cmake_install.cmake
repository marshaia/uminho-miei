# Install script for directory: /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xPowercap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/libpowercap.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xPowercap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/powercap" TYPE FILE FILES
    "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/inc/powercap.h"
    "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/inc/powercap-sysfs.h"
    "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/inc/powercap-rapl.h"
    "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/inc/powercap-rapl-sysfs.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xPowercap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE DIRECTORY FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/pkgconfig/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xPowercap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/powercap" TYPE FILE FILES
    "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/PowercapConfig.cmake"
    "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/PowercapConfigVersion.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xPowercap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/powercap/PowercapTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/powercap/PowercapTargets.cmake"
         "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/CMakeFiles/Export/lib/cmake/powercap/PowercapTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/powercap/PowercapTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/powercap/PowercapTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/powercap" TYPE FILE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/CMakeFiles/Export/lib/cmake/powercap/PowercapTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^()$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/powercap" TYPE FILE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/CMakeFiles/Export/lib/cmake/powercap/PowercapTargets-noconfig.cmake")
  endif()
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/test/cmake_install.cmake")
  include("/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
