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
CMAKE_SOURCE_DIR = /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build

# Include any dependencies generated for this target.
include msr/CMakeFiles/raplcap-msr.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include msr/CMakeFiles/raplcap-msr.dir/compiler_depend.make

# Include the progress variables for this target.
include msr/CMakeFiles/raplcap-msr.dir/progress.make

# Include the compile flags for this target's objects.
include msr/CMakeFiles/raplcap-msr.dir/flags.make

msr/CMakeFiles/raplcap-msr.dir/raplcap-msr.c.o: msr/CMakeFiles/raplcap-msr.dir/flags.make
msr/CMakeFiles/raplcap-msr.dir/raplcap-msr.c.o: ../msr/raplcap-msr.c
msr/CMakeFiles/raplcap-msr.dir/raplcap-msr.c.o: msr/CMakeFiles/raplcap-msr.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object msr/CMakeFiles/raplcap-msr.dir/raplcap-msr.c.o"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT msr/CMakeFiles/raplcap-msr.dir/raplcap-msr.c.o -MF CMakeFiles/raplcap-msr.dir/raplcap-msr.c.o.d -o CMakeFiles/raplcap-msr.dir/raplcap-msr.c.o -c /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr.c

msr/CMakeFiles/raplcap-msr.dir/raplcap-msr.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/raplcap-msr.dir/raplcap-msr.c.i"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr.c > CMakeFiles/raplcap-msr.dir/raplcap-msr.c.i

msr/CMakeFiles/raplcap-msr.dir/raplcap-msr.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/raplcap-msr.dir/raplcap-msr.c.s"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr.c -o CMakeFiles/raplcap-msr.dir/raplcap-msr.c.s

msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.o: msr/CMakeFiles/raplcap-msr.dir/flags.make
msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.o: ../msr/raplcap-msr-common.c
msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.o: msr/CMakeFiles/raplcap-msr.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.o"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.o -MF CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.o.d -o CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.o -c /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr-common.c

msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.i"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr-common.c > CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.i

msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.s"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr-common.c -o CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.s

msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.o: msr/CMakeFiles/raplcap-msr.dir/flags.make
msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.o: ../msr/raplcap-msr-sys-linux.c
msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.o: msr/CMakeFiles/raplcap-msr.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.o"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.o -MF CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.o.d -o CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.o -c /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr-sys-linux.c

msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.i"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr-sys-linux.c > CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.i

msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.s"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-msr-sys-linux.c -o CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.s

msr/CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.o: msr/CMakeFiles/raplcap-msr.dir/flags.make
msr/CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.o: ../msr/raplcap-cpuid.c
msr/CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.o: msr/CMakeFiles/raplcap-msr.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object msr/CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.o"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT msr/CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.o -MF CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.o.d -o CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.o -c /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-cpuid.c

msr/CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.i"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-cpuid.c > CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.i

msr/CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.s"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && /usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr/raplcap-cpuid.c -o CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.s

# Object files for target raplcap-msr
raplcap__msr_OBJECTS = \
"CMakeFiles/raplcap-msr.dir/raplcap-msr.c.o" \
"CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.o" \
"CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.o" \
"CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.o"

# External object files for target raplcap-msr
raplcap__msr_EXTERNAL_OBJECTS =

msr/libraplcap-msr.a: msr/CMakeFiles/raplcap-msr.dir/raplcap-msr.c.o
msr/libraplcap-msr.a: msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-common.c.o
msr/libraplcap-msr.a: msr/CMakeFiles/raplcap-msr.dir/raplcap-msr-sys-linux.c.o
msr/libraplcap-msr.a: msr/CMakeFiles/raplcap-msr.dir/raplcap-cpuid.c.o
msr/libraplcap-msr.a: msr/CMakeFiles/raplcap-msr.dir/build.make
msr/libraplcap-msr.a: msr/CMakeFiles/raplcap-msr.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C static library libraplcap-msr.a"
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && $(CMAKE_COMMAND) -P CMakeFiles/raplcap-msr.dir/cmake_clean_target.cmake
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/raplcap-msr.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
msr/CMakeFiles/raplcap-msr.dir/build: msr/libraplcap-msr.a
.PHONY : msr/CMakeFiles/raplcap-msr.dir/build

msr/CMakeFiles/raplcap-msr.dir/clean:
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr && $(CMAKE_COMMAND) -P CMakeFiles/raplcap-msr.dir/cmake_clean.cmake
.PHONY : msr/CMakeFiles/raplcap-msr.dir/clean

msr/CMakeFiles/raplcap-msr.dir/depend:
	cd /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/msr /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr /home/catarina/Desktop/4ano2sem/EES/Trabalhos/Experimentacao-22-23/Trabalho3/raplcap/_build/msr/CMakeFiles/raplcap-msr.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : msr/CMakeFiles/raplcap-msr.dir/depend

