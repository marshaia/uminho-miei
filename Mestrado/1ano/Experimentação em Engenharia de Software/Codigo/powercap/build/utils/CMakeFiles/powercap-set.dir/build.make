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
CMAKE_SOURCE_DIR = /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build

# Include any dependencies generated for this target.
include utils/CMakeFiles/powercap-set.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include utils/CMakeFiles/powercap-set.dir/compiler_depend.make

# Include the progress variables for this target.
include utils/CMakeFiles/powercap-set.dir/progress.make

# Include the compile flags for this target's objects.
include utils/CMakeFiles/powercap-set.dir/flags.make

utils/CMakeFiles/powercap-set.dir/powercap-set.c.o: utils/CMakeFiles/powercap-set.dir/flags.make
utils/CMakeFiles/powercap-set.dir/powercap-set.c.o: ../utils/powercap-set.c
utils/CMakeFiles/powercap-set.dir/powercap-set.c.o: utils/CMakeFiles/powercap-set.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object utils/CMakeFiles/powercap-set.dir/powercap-set.c.o"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT utils/CMakeFiles/powercap-set.dir/powercap-set.c.o -MF CMakeFiles/powercap-set.dir/powercap-set.c.o.d -o CMakeFiles/powercap-set.dir/powercap-set.c.o -c /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/utils/powercap-set.c

utils/CMakeFiles/powercap-set.dir/powercap-set.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/powercap-set.dir/powercap-set.c.i"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/utils/powercap-set.c > CMakeFiles/powercap-set.dir/powercap-set.c.i

utils/CMakeFiles/powercap-set.dir/powercap-set.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/powercap-set.dir/powercap-set.c.s"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/utils/powercap-set.c -o CMakeFiles/powercap-set.dir/powercap-set.c.s

utils/CMakeFiles/powercap-set.dir/util-common.c.o: utils/CMakeFiles/powercap-set.dir/flags.make
utils/CMakeFiles/powercap-set.dir/util-common.c.o: ../utils/util-common.c
utils/CMakeFiles/powercap-set.dir/util-common.c.o: utils/CMakeFiles/powercap-set.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object utils/CMakeFiles/powercap-set.dir/util-common.c.o"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT utils/CMakeFiles/powercap-set.dir/util-common.c.o -MF CMakeFiles/powercap-set.dir/util-common.c.o.d -o CMakeFiles/powercap-set.dir/util-common.c.o -c /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/utils/util-common.c

utils/CMakeFiles/powercap-set.dir/util-common.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/powercap-set.dir/util-common.c.i"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/utils/util-common.c > CMakeFiles/powercap-set.dir/util-common.c.i

utils/CMakeFiles/powercap-set.dir/util-common.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/powercap-set.dir/util-common.c.s"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/utils/util-common.c -o CMakeFiles/powercap-set.dir/util-common.c.s

# Object files for target powercap-set
powercap__set_OBJECTS = \
"CMakeFiles/powercap-set.dir/powercap-set.c.o" \
"CMakeFiles/powercap-set.dir/util-common.c.o"

# External object files for target powercap-set
powercap__set_EXTERNAL_OBJECTS =

utils/powercap-set: utils/CMakeFiles/powercap-set.dir/powercap-set.c.o
utils/powercap-set: utils/CMakeFiles/powercap-set.dir/util-common.c.o
utils/powercap-set: utils/CMakeFiles/powercap-set.dir/build.make
utils/powercap-set: libpowercap.a
utils/powercap-set: utils/CMakeFiles/powercap-set.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable powercap-set"
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/powercap-set.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
utils/CMakeFiles/powercap-set.dir/build: utils/powercap-set
.PHONY : utils/CMakeFiles/powercap-set.dir/build

utils/CMakeFiles/powercap-set.dir/clean:
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils && $(CMAKE_COMMAND) -P CMakeFiles/powercap-set.dir/cmake_clean.cmake
.PHONY : utils/CMakeFiles/powercap-set.dir/clean

utils/CMakeFiles/powercap-set.dir/depend:
	cd /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/utils /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils /home/joana/Desktop/Experimentacao-22-23/Trabalho3/powercap/build/utils/CMakeFiles/powercap-set.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : utils/CMakeFiles/powercap-set.dir/depend

