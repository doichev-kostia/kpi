# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.20

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
CMAKE_COMMAND = /Applications/apps/CLion/ch-0/212.5457.51/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/apps/CLion/ch-0/212.5457.51/CLion.app/Contents/bin/cmake/mac/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/lab_1.dir/depend.make
# Include the progress variables for this target.
include CMakeFiles/lab_1.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/lab_1.dir/flags.make

CMakeFiles/lab_1.dir/main.cpp.o: CMakeFiles/lab_1.dir/flags.make
CMakeFiles/lab_1.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/lab_1.dir/main.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/lab_1.dir/main.cpp.o -c /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/main.cpp

CMakeFiles/lab_1.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lab_1.dir/main.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/main.cpp > CMakeFiles/lab_1.dir/main.cpp.i

CMakeFiles/lab_1.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lab_1.dir/main.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/main.cpp -o CMakeFiles/lab_1.dir/main.cpp.s

CMakeFiles/lab_1.dir/Utils.cpp.o: CMakeFiles/lab_1.dir/flags.make
CMakeFiles/lab_1.dir/Utils.cpp.o: ../Utils.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/lab_1.dir/Utils.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/lab_1.dir/Utils.cpp.o -c /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/Utils.cpp

CMakeFiles/lab_1.dir/Utils.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lab_1.dir/Utils.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/Utils.cpp > CMakeFiles/lab_1.dir/Utils.cpp.i

CMakeFiles/lab_1.dir/Utils.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lab_1.dir/Utils.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/Utils.cpp -o CMakeFiles/lab_1.dir/Utils.cpp.s

CMakeFiles/lab_1.dir/string-utils.cpp.o: CMakeFiles/lab_1.dir/flags.make
CMakeFiles/lab_1.dir/string-utils.cpp.o: ../string-utils.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/lab_1.dir/string-utils.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/lab_1.dir/string-utils.cpp.o -c /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/string-utils.cpp

CMakeFiles/lab_1.dir/string-utils.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/lab_1.dir/string-utils.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/string-utils.cpp > CMakeFiles/lab_1.dir/string-utils.cpp.i

CMakeFiles/lab_1.dir/string-utils.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/lab_1.dir/string-utils.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/string-utils.cpp -o CMakeFiles/lab_1.dir/string-utils.cpp.s

# Object files for target lab_1
lab_1_OBJECTS = \
"CMakeFiles/lab_1.dir/main.cpp.o" \
"CMakeFiles/lab_1.dir/Utils.cpp.o" \
"CMakeFiles/lab_1.dir/string-utils.cpp.o"

# External object files for target lab_1
lab_1_EXTERNAL_OBJECTS =

lab_1: CMakeFiles/lab_1.dir/main.cpp.o
lab_1: CMakeFiles/lab_1.dir/Utils.cpp.o
lab_1: CMakeFiles/lab_1.dir/string-utils.cpp.o
lab_1: CMakeFiles/lab_1.dir/build.make
lab_1: CMakeFiles/lab_1.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable lab_1"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lab_1.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/lab_1.dir/build: lab_1
.PHONY : CMakeFiles/lab_1.dir/build

CMakeFiles/lab_1.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/lab_1.dir/cmake_clean.cmake
.PHONY : CMakeFiles/lab_1.dir/clean

CMakeFiles/lab_1.dir/depend:
	cd /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1 /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1 /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/cmake-build-debug /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/cmake-build-debug /Users/Kostia/Documents/Programming/kpi/programming-basics/C-plus-plus/bachelor/year-1/semester-2/lab-1/cmake-build-debug/CMakeFiles/lab_1.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/lab_1.dir/depend

