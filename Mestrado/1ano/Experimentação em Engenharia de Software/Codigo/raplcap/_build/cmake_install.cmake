# Install script for directory: /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap

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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/raplcap" TYPE FILE FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/inc/raplcap.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapTargets.cmake"
         "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapTargets.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES
    "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/RAPLCapConfig.cmake"
    "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/RAPLCapConfigVersion.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/Modules" TYPE DIRECTORY FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/cmake/" FILES_MATCHING REGEX "/Find[^/]*\\.cmake$")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/rapl-configure/cmake_install.cmake")
  include("/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/test/cmake_install.cmake")
  include("/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr/cmake_install.cmake")
  include("/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/cmake_install.cmake")
  include("/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/ipg/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
