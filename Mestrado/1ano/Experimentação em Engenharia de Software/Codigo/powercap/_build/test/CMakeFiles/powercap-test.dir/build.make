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
CMAKE_SOURCE_DIR = /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build

# Include any dependencies generated for this target.
include test/CMakeFiles/powercap-test.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include test/CMakeFiles/powercap-test.dir/compiler_depend.make

# Include the progress variables for this target.
include test/CMakeFiles/powercap-test.dir/progress.make

# Include the compile flags for this target's objects.
include test/CMakeFiles/powercap-test.dir/flags.make

test/CMakeFiles/powercap-test.dir/powercap-test.c.o: test/CMakeFiles/powercap-test.dir/flags.make
test/CMakeFiles/powercap-test.dir/powercap-test.c.o: ../test/powercap-test.c
test/CMakeFiles/powercap-test.dir/powercap-test.c.o: test/CMakeFiles/powercap-test.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object test/CMakeFiles/powercap-test.dir/powercap-test.c.o"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build/test && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT test/CMakeFiles/powercap-test.dir/powercap-test.c.o -MF CMakeFiles/powercap-test.dir/powercap-test.c.o.d -o CMakeFiles/powercap-test.dir/powercap-test.c.o -c /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/test/powercap-test.c

test/CMakeFiles/powercap-test.dir/powercap-test.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/powercap-test.dir/powercap-test.c.i"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build/test && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/test/powercap-test.c > CMakeFiles/powercap-test.dir/powercap-test.c.i

test/CMakeFiles/powercap-test.dir/powercap-test.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/powercap-test.dir/powercap-test.c.s"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build/test && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/test/powercap-test.c -o CMakeFiles/powercap-test.dir/powercap-test.c.s

# Object files for target powercap-test
powercap__test_OBJECTS = \
"CMakeFiles/powercap-test.dir/powercap-test.c.o"

# External object files for target powercap-test
powercap__test_EXTERNAL_OBJECTS =

test/powercap-test: test/CMakeFiles/powercap-test.dir/powercap-test.c.o
test/powercap-test: test/CMakeFiles/powercap-test.dir/build.make
test/powercap-test: libpowercap.a
test/powercap-test: test/CMakeFiles/powercap-test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable powercap-test"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build/test && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/powercap-test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/CMakeFiles/powercap-test.dir/build: test/powercap-test
.PHONY : test/CMakeFiles/powercap-test.dir/build

test/CMakeFiles/powercap-test.dir/clean:
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build/test && $(CMAKE_COMMAND) -P CMakeFiles/powercap-test.dir/cmake_clean.cmake
.PHONY : test/CMakeFiles/powercap-test.dir/clean

test/CMakeFiles/powercap-test.dir/depend:
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/test /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build/test /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/powercap/_build/test/CMakeFiles/powercap-test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/CMakeFiles/powercap-test.dir/depend

