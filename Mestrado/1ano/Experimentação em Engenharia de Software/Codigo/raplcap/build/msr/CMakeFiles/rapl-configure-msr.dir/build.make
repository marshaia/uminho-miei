# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build

# Include any dependencies generated for this target.
include msr/CMakeFiles/rapl-configure-msr.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include msr/CMakeFiles/rapl-configure-msr.dir/compiler_depend.make

# Include the progress variables for this target.
include msr/CMakeFiles/rapl-configure-msr.dir/progress.make

# Include the compile flags for this target's objects.
include msr/CMakeFiles/rapl-configure-msr.dir/flags.make

msr/CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.o: msr/CMakeFiles/rapl-configure-msr.dir/flags.make
msr/CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.o: ../rapl-configure/rapl-configure.c
msr/CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.o: msr/CMakeFiles/rapl-configure-msr.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object msr/CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.o"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT msr/CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.o -MF CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.o.d -o CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.o -c /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/rapl-configure/rapl-configure.c

msr/CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.i"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/rapl-configure/rapl-configure.c > CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.i

msr/CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.s"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/rapl-configure/rapl-configure.c -o CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.s

# Object files for target rapl-configure-msr
rapl__configure__msr_OBJECTS = \
"CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.o"

# External object files for target rapl-configure-msr
rapl__configure__msr_EXTERNAL_OBJECTS =

msr/rapl-configure-msr: msr/CMakeFiles/rapl-configure-msr.dir/__/rapl-configure/rapl-configure.c.o
msr/rapl-configure-msr: msr/CMakeFiles/rapl-configure-msr.dir/build.make
msr/rapl-configure-msr: msr/libraplcap-msr.a
msr/rapl-configure-msr: msr/CMakeFiles/rapl-configure-msr.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable rapl-configure-msr"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/rapl-configure-msr.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
msr/CMakeFiles/rapl-configure-msr.dir/build: msr/rapl-configure-msr
.PHONY : msr/CMakeFiles/rapl-configure-msr.dir/build

msr/CMakeFiles/rapl-configure-msr.dir/clean:
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr && $(CMAKE_COMMAND) -P CMakeFiles/rapl-configure-msr.dir/cmake_clean.cmake
.PHONY : msr/CMakeFiles/rapl-configure-msr.dir/clean

msr/CMakeFiles/rapl-configure-msr.dir/depend:
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/msr /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr /home/joana/Desktop/Experimentacao-22-23/Trabalho3/raplcap/build/msr/CMakeFiles/rapl-configure-msr.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : msr/CMakeFiles/rapl-configure-msr.dir/depend

