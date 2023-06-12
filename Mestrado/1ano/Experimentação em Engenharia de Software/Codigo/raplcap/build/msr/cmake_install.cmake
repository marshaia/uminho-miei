# Install script for directory: /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/msr

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

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_MSR_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/libraplcap-msr.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_MSR_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/raplcap" TYPE FILE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_MSR_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapMSRTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapMSRTargets.cmake"
         "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapMSRTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapMSRTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapMSRTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapMSRTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^()$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapMSRTargets-noconfig.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_MSR_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/raplcap-msr.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_MSR_Utils_Runtimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-msr" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-msr")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-msr"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/rapl-configure-msr")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-msr" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-msr")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rapl-configure-msr")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_MSR_Utils_Runtimex" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/man/man1" TYPE FILE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/man/man1/rapl-configure-msr.1")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRAPLCap_MSR_Developmentx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapMSRUtilsTargets.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapMSRUtilsTargets.cmake"
         "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapMSRUtilsTargets.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapMSRUtilsTargets-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap/RAPLCapMSRUtilsTargets.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapMSRUtilsTargets.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^()$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/raplcap" TYPE FILE FILES "/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/CMakeFiles/Export/lib/cmake/raplcap/RAPLCapMSRUtilsTargets-noconfig.cmake")
  endif()
endif()

