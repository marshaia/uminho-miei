# Install script for directory: /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/powercap

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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_Powercap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/libraplcap-powercap.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_Powercap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapPowercapTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapPowercapTargets.cmake"
         "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapPowercapTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapPowercapTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapPowercapTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapPowercapTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^()$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapPowercapTargets-noconfig.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_Powercap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/raplcap-powercap.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_Powercap_Utils_Runtimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-powercap" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-powercap")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-powercap"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/rapl-configure-powercap")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-powercap" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-powercap")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-powercap")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_Powercap_Utils_Runtimex" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/man/man1" TYPE FILE FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/man/man1/rapl-configure-powercap.1")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_Powercap_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapPowercapUtilsTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapPowercapUtilsTargets.cmake"
         "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapPowercapUtilsTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapPowercapUtilsTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapPowercapUtilsTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapPowercapUtilsTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^()$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES "/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/powercap/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapPowercapUtilsTargets-noconfig.cmake")
  endif()
endif()

